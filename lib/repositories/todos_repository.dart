import 'package:lesson47/models/product.dart';
import 'package:lesson47/models/todo_model.dart';
import 'package:lesson47/services/products_http_services.dart';
import 'package:lesson47/services/todos_http_services.dart';

class TodosRepository {
  final TodosHttpServices todosHttpServices = TodosHttpServices();
  
  // get todosHttpServices => null;
  // final productLocalService = ProductLocalService();

  Future<List<TodoModel>> getTodos() async {
    // if (productLocalService.isNotEmpty) {
    //   return productLocalService.products;
    // }
    return todosHttpServices.getTodos();
  }

  Future<TodoModel> addTodo(String title, String  description, bool isCompleted) async {
    // Todo add product
    final newTodo =
        await todosHttpServices.addTodo(title, description, isCompleted);
    // productLocalService.addProduct();
    return newTodo;
  }

  //! ID kerak chunki qaysi mahsulotni o'zgartirishni bilish uchun
  Future<void> editTodo(
      String id, String newTitle, String newDescription, bool newIsCompleted) async {
    await todosHttpServices.editTodo(id, newTitle, newDescription, newIsCompleted);
    // productLocalService.editProduct();
  }

  Future<void> deleteProduct(String id) async {
    // Todo delete product
    await todosHttpServices.deleteTodo(id);
  }
}
