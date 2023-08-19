import 'dart:async';

import 'package:protos/protos.dart';

class TodoService extends TodoServiceBase {
  @override
  Future<Todo> getTodo(ServiceCall call, GetTodoByIdRequest request) {
    final id = request.id;
    final todo = Todo(id: id, title: 'todo #$id', completed: false);
    return Future.value(todo);
  }

  @override
  Stream<Todo> listTodo(
    ServiceCall call,
    Stream<GetTodoByIdRequest> request,
  ) {
    final controller = StreamController<Todo>();

    request.listen((req) async {
      // yield Todo();
      final todo = Todo(id: req.id, title: 'todo #${req.id}', completed: false);
      controller.add(todo);
    }).onDone(() {
      controller.close();
    });

    return controller.stream;
  }
}
