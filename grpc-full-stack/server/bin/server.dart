import 'dart:io';

import 'package:protos/protos.dart';
import 'package:server/server.dart' as server;

Future<void> main(List<String> arguments) async {
  final serv = Server([
    // TODO: declare services here
  ]);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  await serv.serve(port: port);

  print('gRPC server listening on port $port...');
}
