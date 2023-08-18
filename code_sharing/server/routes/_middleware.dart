import 'package:dart_frog/dart_frog.dart';
import 'package:stormberry/stormberry.dart';

// final connection = PostgreSQLConnection(
//   'localhost',
//   5432,
//   'postgres',
//   username: 'postgres',
//   password: 'password',
// );

final db = Database(
  // connection parameters go here
  host: 'localhost',
  port: 5432,
  database: 'postgres',
  user: 'postgres',
  password: 'password',
  useSSL: false,
);

Handler middleware(Handler handler) {
  // if (connection.isClosed) {
  //   connection.open();
  // }
  return handler.use(
    provider<Database>(
      (context) => db,
    ),
  );
}
