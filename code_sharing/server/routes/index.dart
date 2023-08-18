import 'dart:async';
import 'dart:convert';

import 'package:dart_frog/dart_frog.dart';
import 'package:db/db.dart';
import 'package:shared/shared.dart' as shared;
import 'package:stormberry/stormberry.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  // const user = shared.User(id: 'user001', email: 'user001@example.com');

  // final connection = context.read<PostgreSQLConnection>();
  // final List<List<dynamic>> results = await connection.query('SELECT NOW()'); // results[0][0]

  final db = context.read<Database>();

  final dbUsers = await db.users.queryUsers();
  final firstDbUser = dbUsers.isNotEmpty ? dbUsers.first : null;

  if (firstDbUser == null) {
    return Response(body: 'No User Found', statusCode: 404);
  }

  final sharedUser = shared.User.fromDb(firstDbUser);
  // return Response(
  //   body: 'Welcome to Dart Frog!\n'
  //       'database name: ${db.database}\n'
  //       'first user name: ${sharedUser.name}\n'
  //       'users count: ${dbUsers.length}',
  // );

  return Response.json(
    body:sharedUser.toJson(),
    headers: {
      'Content-Type': 'application/json',
    },
  );
}
