import 'package:flutter/material.dart';
import 'package:lesson47/models/todo_model.dart';

class TodoTile extends StatefulWidget {
  TodoModel todo;
  final Function() onChanged;
  final Function() onDelete;
  final Function() onEdit;
  TodoTile(
      {super.key,
      required this.onDelete,
      required this.onEdit,
      required this.onChanged,
      required this.todo});

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Card(
        child: Column(
          children: [
            Text(widget.todo.title),
            Text(widget.todo.description),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: widget.onDelete,
                  icon: Icon(Icons.delete),
                ),
                SizedBox(
                  width: 20,
                ),
                Checkbox(
                  value: widget.todo.isCompleted,
                  onChanged: (value) {
                    widget.todo.isCompleted = !widget.todo.isCompleted;
                  },
                ),
                IconButton(onPressed: widget.onEdit, icon: Icon(Icons.edit))
              ],
            )
          ],
        ),
      ),
    );
  }
}
