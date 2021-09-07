import 'package:dotenv/dotenv.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';

import 'config.dart';
import 'model/user_auth_model.dart';

class AccessController {
  // ignore: unused_field
  final _env = Config.init();

  final HASURA_ADM_SECRET = env['HASURA_ADM_SECRET']!;
  final HASURA_URL = env['HASURA_URL']!;
  final HASURA_ROLE = 'auth';
  final JWT_AUTH_SECRET = env['JWT_AUTH_SECRET'];

  HasuraConnect hasuraInit({required String username}) {
    var HASURA_HEADERS = {
      'X-Hasura-Role': HASURA_ROLE,
      'x-hasura-admin-secret': HASURA_ADM_SECRET,
      'x-hasura-user-name': username
    };
    final client = HasuraConnect(HASURA_URL, headers: HASURA_HEADERS);
    return client;
  }

  String generateToken({
    required String username,
    required String userId,
    required String role,
  }) {
    var claims = JwtClaim(
        issuedAt: DateTime.now(),
        expiry: DateTime.now().add(Duration(hours: 16)),
        otherClaims: {
          'https://hasura.io/jwt/claims': {
            'x-hasura-allowed-roles': ['admin', 'user', 'auth'],
            'x-hasura-default-role': role,
            'x-hasura-user-id': userId,
            'x-hasura-user-name': username
          }
        });
    var token = issueJwtHS256(claims, JWT_AUTH_SECRET!);
    return token;
  }

  Future<UserAuthModel?> fetchUserPermissions(
      {required String username, required String pass}) async {
    var _client = hasuraInit(username: username);
    var user = UserAuthModel();
    final response;
    try {
      response = await _client.query('''
       query authQuerry {
         auth_permission(where: {user_name: {_eq: "$username"}, pass: {_eq: "$pass"}},limit: 1) {
           user_name
           role
           user_id
         }
       }
       ''');
    } catch (e) {
      user.error = e.toString();
      return user;
    }
    var list = response['data']['auth_permission'] as List;
    if (list.isNotEmpty) {
      var json = list[0];
      user = UserAuthModel.fromMap(json);
      return user;
    }
    user.error = 'Login e/ou senha inválido(s).';
    return user;
  }
}
