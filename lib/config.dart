import 'package:dotenv/dotenv.dart' as dotenv;

abstract class Config {
  static Map<String, dynamic> get _env => dotenv.env;

  static int get port => int.tryParse(_env['PORT']) ?? 3000;

  static String get secret => _env['JWT_AUTH_SECRET'] ?? '';

  static String get url => _env['HASURA_URL'] ?? '';

  static String get hasura_secret => _env['HASURA_ADM_SECRET'] ?? '';

  static void init() async {
    var filename = '.env';
    dotenv.load(filename);
  }
}
