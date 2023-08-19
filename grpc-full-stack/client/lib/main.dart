import 'dart:math';

import 'package:flutter/material.dart';

import 'package:protos/protos.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomePage();
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ClientChannel _channel;
  late TodoServiceClient _stub;

  late Stream<GetTodoByIdRequest> requestStream;
  late Stream<Todo> todoStream;

  Todo? todo;

  @override
  void initState() {
    super.initState();
    _channel = ClientChannel(
      'localhost',
      port: 8080,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );

    _stub = TodoServiceClient(_channel);

    requestStream = Stream<GetTodoByIdRequest>.periodic(
      const Duration(seconds: 1),
      (count) => GetTodoByIdRequest(id: count),
    );

    todoStream = _stub.listTodo(requestStream);

    todoStream.listen((value) {
      setState(() {
        todo = value;
      });
    });
  }

  @override
  void dispose() {
    _channel.shutdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Full Stack with gRPC'),
        ),
        body: Center(
          child: todo == null
              ? Text(
                  'No data yet',
                  style: Theme.of(context)
                      .textTheme
                      .displayMedium
                      ?.copyWith(color: Colors.red),
                )
              : Text(
                  todo!.toString(),
                  style: Theme.of(context).textTheme.displayMedium,
                ),
        ),
      ),
    );
  }
}
