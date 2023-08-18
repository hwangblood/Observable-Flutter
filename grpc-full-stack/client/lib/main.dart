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

  int _counter = 0;
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

    _fetchTodo();
  }

  @override
  void dispose() {
    _channel.shutdown();
    super.dispose();
  }

  Future<void> _fetchTodo() async {
    setState(() {
      _counter++;
    });

    _stub.getTodo(GetTodoByIdRequest(id: _counter)).then(
          (p0) => setState(
            () => todo = p0,
          ),
        );
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
        floatingActionButton: FloatingActionButton(
          onPressed: _fetchTodo,
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
