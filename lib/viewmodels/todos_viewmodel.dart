import 'package:lesson47/models/todo_model.dart';
import 'package:lesson47/repositories/todos_repository.dart';

class TodosViewmodel {
  final TodosRepository  todosRepository= TodosRepository();

  List<TodoModel> _list = [];

  Future<List<TodoModel>> get list async {
    _list = await todosRepository.getTodos();
    return [..._list];
  }

  void addTodo(String title, String description, bool isCompleted) async {
    // Todo add product
    final newTodo =
        await todosRepository.addTodo(title, description,isCompleted);
    _list.add(newTodo);
  }

  //! ID kerak chunki qaysi mahsulotni o'zgartirishni bilish uchun
  void editTodo(String id, String newTitle, String newDescription, bool newIsCompleted) {
    todosRepository.editTodo(id, newTitle, newDescription, newIsCompleted);
    final index = _list.indexWhere((todo) {
      return todo.id == id;
    });

    _list[index].title = newTitle;
    _list[index].description = newDescription;
    _list[index].isCompleted = newIsCompleted;
  }

  Future<void> deleteTodo(String id) async {
    // Todo delete product

    await todosRepository.deleteProduct(id);
    _list.removeWhere((todo) {
      return todo.id == id;
    });
  }
}
