import 'package:flutter/material.dart';
import 'package:lesson47/models/todo_model.dart';

class ManegTodoDialog extends StatefulWidget {
  TodoModel? todo;
  ManegTodoDialog({super.key, this.todo});

  @override
  State<ManegTodoDialog> createState() => _ManegTodoDialogState();
}

class _ManegTodoDialogState extends State<ManegTodoDialog> {
  final formKey = GlobalKey<FormState>();

  String title = "";
  String description = "";
  late bool isCompleted = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.todo != null) {
      title = widget.todo!.title;
      description = widget.todo!.description;
      isCompleted = widget.todo!.isCompleted;
    }
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Navigator.pop(context, {
        "title": title,
        "description": description,
        "isCompleted": isCompleted,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title:
          widget.todo != null ? Text("Todoni tahrirlash") : Text("Yangi todo"),
      content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: title,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Todo nomi",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Iltimos todo nomini kiriting";
                  }

                  return null;
                },
                onSaved: (newValue) {
                  title = newValue!;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue: description,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Todo tavsifi",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Iltimos todo tavsifini kiriting";
                  }

                  return null;
                },
                onSaved: (newValue) {
                  description = newValue!;
                },
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                initialValue: widget.todo != null ? isCompleted.toString() : "",
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Todo holati: done/undone",
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Iltimos todo holatini kiriting";
                  }

                  return null;
                },
                onSaved: (newValue) {
                  isCompleted = newValue == "done" ? true : false;
                },
              ),
            ],
          )),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Bekor qilish"),
        ),
        FilledButton(
          onPressed: submit,
          child: const Text("Saqlash"),
        ),
      ],
    );
  }
}
