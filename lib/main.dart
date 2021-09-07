import 'dart:convert';

import 'package:functions_framework/functions_framework.dart';
import 'package:shelf/shelf.dart';
import 'access_controller.dart';
import 'model/auth_request_model.dart';

@CloudFunction()
Future<Response> function(Request request) async {
  switch (request.url.path) {
    case "login":
      var payload = await request.readAsString();
      var data = json.decode(payload);
      var decodedData = data['input']['credentials'];
      var credentials = AuthRequest.fromMap(decodedData);
      var user = await AccessController().fetchUserPermissions(
          username: credentials.username, pass: credentials.password);
      if (user!.error != null) {
        return Response.ok(
            ''' 
        {
          "accessToken":
          "${user.error}",
          "hasError":
          true
        }
      ''');
      } else {
        user.token = AccessController().generateToken(
            username: credentials.username,
            userId: credentials.password,
            role: user.role!);
        return Response.ok(
            ''' 
        {
          "accessToken":
          "${user.token}",
          "hasError":
          false
        }
      ''');
      }
    default:
      return Response.ok("Page not found");
  }
}
