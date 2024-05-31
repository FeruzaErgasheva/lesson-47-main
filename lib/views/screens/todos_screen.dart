import 'package:flutter/material.dart';
import 'package:lesson47/models/todo_model.dart';
import 'package:lesson47/viewmodels/todos_viewmodel.dart';
import 'package:lesson47/views/widgets/manage_todo_dialog.dart';
import 'package:lesson47/views/widgets/todo_tile.dart';

class TodosScreen extends StatefulWidget {
  TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  TodosViewmodel todosViewmodel = TodosViewmodel();

  void deleteTodo(TodoModel todo) async {
    final response = await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("ishonchingiz komilmi?"),
          content: Text("Siz ${todo.title}todoni o'chirmoqchisiz."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text("Bekor qilish"),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text("Ha, ishonchim komil"),
            ),
          ],
        );
      },
    );

    if (response) {
      await todosViewmodel.deleteTodo(todo.id);
      setState(() {});
    }
  }

  void addTodo() async {
    final data = await showDialog(
      context: context,
      builder: (context) => ManegTodoDialog(),
    );
    if (data != null) {
      setState(() {
        todosViewmodel.addTodo(
            data["title"], data["description"], data["isCompleted"]);
      });
    }
  }

  void editTodo(TodoModel todo) async {
    final data = await showDialog(
      context: context,
      builder: (context) => ManegTodoDialog(
        todo: todo,
      ),
    );
    if (data != null) {
      setState(() {
        todosViewmodel.editTodo(
            todo.id, data["title"], data["description"], data["isCompleted"]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: addTodo,
            ),
          ),
        ],
        backgroundColor: Colors.amber,
        title: const Text("Todos"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: FutureBuilder(
          future: todosViewmodel.list,
          builder: (context, snapshot) {
            print(snapshot.data);
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: Text("Todolar mavjud emas, iltimos qo'shing"),
              );
            }
            final todos = snapshot.data;
            return todos == null || todos.isEmpty
                ? const Center(
                    child: Text("Todolar mavjud emas, iltimos qo'shing"),
                  )
                : ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      print(todos[index].title);
                      final newTodo = todos[index];

                      return TodoTile(
                          onEdit: () {
                            editTodo(newTodo);
                          },
                          onDelete: () {
                            deleteTodo(newTodo);
                          },
                          onChanged: () {},
                          todo: newTodo);
                    },
                  );
          },
        ),
      ),
    );
  }
}
