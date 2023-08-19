import 'dart:io';

import 'package:protos/protos.dart';
import 'package:server/services/services.dart';

Future<void> main(List<String> arguments) async {
  final serv = Server([
    // register services here
    TodoService(),
  ]);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  await serv.serve(port: port);

  print('gRPC server listening on port $port...');
}
