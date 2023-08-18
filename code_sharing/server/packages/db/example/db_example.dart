import 'package:db/db.dart';
import 'package:stormberry/stormberry.dart';

void main(List<String> args) async {
  final db = Database(
    // connection parameters go here
    host: 'localhost',
    port: 5432,
    database: 'postgres',
    user: 'postgres',
    password: 'password',
    useSSL: false,
  );

  final users = await db.users.queryUsers();
  final first = users.isNotEmpty ? users.first : null;

  print(
    'database name: ${db.database}\n'
    'first user name: ${first?.name}\n'
    'users count: ${users.length}',
  );

  // close the connection
  await db.close();
}
