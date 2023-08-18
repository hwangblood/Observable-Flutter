import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared/shared.dart' as shared;

import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Code Sharing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Code Sharing'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  shared.User? sharedUser;
  String? message;

  @override
  void initState() {
    super.initState();

    fatchData();
  }

  Future<void> fatchData() async {
    setState(() {
      sharedUser = null;
      message = null;
    });

    await Future.delayed(const Duration(seconds: 2));

    http
        .get(Uri.parse('http://localhost:8080/'))
        .then((resp) {
          if (resp.statusCode == 404) {
            throw Exception(resp.body);
          }
          return resp.body;
        })
        .then((string) => jsonDecode(string) as Map<String, dynamic>)
        .then((Map<String, dynamic> json) => shared.User.fromJson(json))
        .then((user) => setState(() {
              sharedUser = user;
              message = null;
            }))
        .onError(
          (error, stackTrace) => setState(
            () {
              message = error.toString();
              sharedUser = null;
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: sharedUser == null && message == null
            ? const CircularProgressIndicator.adaptive()
            : Column(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (sharedUser != null) ...[
                    Text(
                      'The First User from db',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      sharedUser!.toString(),
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                  if (message != null)
                    Text(
                      message!,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: Colors.red),
                    )
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fatchData,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
