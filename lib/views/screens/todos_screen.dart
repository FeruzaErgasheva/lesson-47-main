import 'package:flutter/material.dart';
import 'package:lesson47/viewmodels/todos_viewmodel.dart';

class TodosScreen extends StatefulWidget {
  TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  TodosViewmodel todosViewmodel = TodosViewmodel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {},
            ),
          ),
        ],
        backgroundColor: Colors.amber,
        title: const Text("Todos"),
        centerTitle: true,
      ),
      body: FutureBuilder(
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

                    return ListTile(
                      title: Text(todos[index].title),
                      subtitle: Text(todos[index].description),
                      trailing: Checkbox(
                        value: todos[index].isCompleted,
                        onChanged: (value) {
                          setState(() {
                            todos[index].isCompleted =
                                !todos[index].isCompleted;
                            
                          });
                        },
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
