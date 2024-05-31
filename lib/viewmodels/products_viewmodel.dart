import 'package:lesson47/models/product.dart';
import 'package:lesson47/repositories/products_repository.dart';

class ProductsViewmodel {
  final productsRepository = ProductsRepository();

  List<Product> _list = [
    Product(
      id: "1",
      title: "iPhone 11",
      price: 900,
      amount: 22,
    ),
  ];

  Future<List<Product>> get list async {
    _list = await productsRepository.getProducts();
    return [..._list];
  }

  void addProduct(String title, double price, int amount) async {
    // Todo add product
    final newProduct =
        await productsRepository.addProduct(title, price, amount);
    _list.add(newProduct);
  }

  //! ID kerak chunki qaysi mahsulotni o'zgartirishni bilish uchun
  void editProduct(String id, String newTitle, double newPrice, int newAmount) {
    productsRepository.editProduct(id, newTitle, newPrice, newAmount);
    final index = _list.indexWhere((product) {
      return product.id == id;
    });

    _list[index].title = newTitle;
    _list[index].price = newPrice;
    _list[index].amount = newAmount;
  }

  Future<void> deleteProduct(String id) async {
    // Todo delete product

    await productsRepository.deleteProduct(id);
    _list.removeWhere((product) {
      return product.id == id;
    });
  }
}
