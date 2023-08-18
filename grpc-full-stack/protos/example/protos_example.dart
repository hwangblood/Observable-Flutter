import 'package:protos/protos.dart';

void main() {
  final todo = Todo(id: 1, title: 'first todo', completed: false);
  print(todo.toProto3Json());
  print(todo.writeToJsonMap());
}
