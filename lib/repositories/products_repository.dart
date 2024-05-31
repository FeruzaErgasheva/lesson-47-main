import 'package:lesson47/models/product.dart';
import 'package:lesson47/services/products_http_services.dart';

class ProductsRepository {
  final productsHttpServices = ProductsHttpServices();
  // final productLocalService = ProductLocalService();

  Future<List<Product>> getProducts() async {
    // if (productLocalService.isNotEmpty) {
    //   return productLocalService.products;
    // }
    return productsHttpServices.getProducts();
  }

  Future<Product> addProduct(String title, double price, int amount) async {
    // Todo add product
    final newProduct =
        await productsHttpServices.addProduct(title, price, amount);
    // productLocalService.addProduct();
    return newProduct;
  }

  //! ID kerak chunki qaysi mahsulotni o'zgartirishni bilish uchun
  Future<void> editProduct(
      String id, String newTitle, double newPrice, int newAmount) async {
    await productsHttpServices.editProduct(id, newTitle, newPrice, newAmount);
    // productLocalService.editProduct();
  }

  Future<void> deleteProduct(String id) async {
    // Todo delete product
    await productsHttpServices.deleteProduct(id);
  }
}
