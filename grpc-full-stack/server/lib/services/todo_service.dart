import 'package:protos/protos.dart';

class TodoService extends TodoServiceBase {
  @override
  Future<Todo> getTodo(ServiceCall call, GetTodoByIdRequest request) {
    final id = request.id;
    final todo = Todo(id: id, title: 'todo #$id', completed: false);
    return Future.value(todo);
  }
}
