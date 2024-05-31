import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lesson47/models/todo_model.dart';

class TodosHttpServices {
  Future<List<TodoModel>> getTodos() async {
    Uri url = Uri.parse(
        "https://todoapp-8fd7b-default-rtdb.firebaseio.com/todos.json");
    final response = await http.get(url);
    final data = jsonDecode(response.body);
    List<TodoModel> loadedTodos = [];
    if (data != null) {
      data.forEach((key, value) {
        /// ID qo'shishdan oldin -  title: Iphone, price: 600, amount: 200
        value['id'] = key;

        /// ID qo'shgandan keyin - id: product1, title: Iphone, price: 600, amount: 200
        loadedTodos.add(TodoModel.fromJson(value));
      });
    }
    return loadedTodos;
  }

  Future<TodoModel> addTodo(
      String title, String description, bool isCompleted) async {
    Uri url = Uri.parse(
        "https://todoapp-8fd7b-default-rtdb.firebaseio.com/todos.json");

    Map<String, dynamic> todoData = {
      "title": title,
      "description": description,
      "isCompleted": isCompleted,
    };
    final response = await http.post(
      url,
      body: jsonEncode(todoData),
    );

    final data = jsonDecode(response.body);

    ///random generated idsi qaytadi firebasedan datada
    print(data);
    todoData['id'] = data['name'];
    print(todoData);
    TodoModel newTodo = TodoModel.fromJson(todoData);
    return newTodo;
  }

  Future<void> editTodo(
    String id,
    String newTitle,
    String newDescription, //price
    bool newIsCompleted, //amount
  ) async {
    Uri url = Uri.parse(
        "https://todoapp-8fd7b-default-rtdb.firebaseio.com/todos/$id.json");

    Map<String, dynamic> todoData = {
      "title": newTitle,
      "description": newDescription,
      "isCompleted": newIsCompleted,
    };

    //response qaytadi
    final response = await http.patch(
      url,
      body: jsonEncode(todoData),
    );

    print(jsonDecode(response.body));
  }

  Future<void> deleteTodo(String id) async {
    Uri url = Uri.parse(
        "https://todoapp-8fd7b-default-rtdb.firebaseio.com/todos/$id.json");

    await http.delete(url);
  }
}

void main(List<String> args) {
  TodosHttpServices todosHttpServices = TodosHttpServices();
  // todosHttpServices.addProduct("playing", "playing football", false);
  // todosHttpServices.editProduct("todo1", "working", "working at lc", false);
  todosHttpServices.deleteTodo("todo1");
}
