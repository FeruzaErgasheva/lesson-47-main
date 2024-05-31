import 'package:flutter/material.dart';
import 'package:lesson47/models/product.dart';
import 'package:lesson47/viewmodels/products_viewmodel.dart';
import 'package:lesson47/views/widgets/manage_product_dialog.dart';
import 'package:lesson47/views/widgets/product_item.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final productsViewModel = ProductsViewmodel();

  void addProduct() async {
    final data = await showDialog(
      context: context,
      builder: (ctx) {
        return const ManageProductDialog();
      },
    );

    if (data != null) {
      try {
        productsViewModel.addProduct(
          data['title'],
          data['price'],
          data['amount'],
        );
        setState(() {});
      } catch (e) {
        print(e);
      }
    }
  }

  void editProduct(Product product) async {
    final data = await showDialog(
      context: context,
      builder: (ctx) {
        return ManageProductDialog(product: product);
      },
    );

    if (data != null) {
      productsViewModel.editProduct(
        product.id,
        data['title'],
        data['price'],
        data['amount'],
      );
      setState(() {});
    }
  }

  void deleteProduct(Product product) async {
    final response = await showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("ishonchingiz komilmi?"),
          content: Text("Siz ${product.title} mahsulotini o'chirmoqchisiz."),
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
      await productsViewModel.deleteProduct(product.id);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mahsulotlar"),
        backgroundColor: Colors.amber,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: addProduct,
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: FutureBuilder(
          future: productsViewModel.list,
          builder: (context, snapshot) {
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
                child: Text("Mahsulotlar mavjud emas, iltimos qo'shing"),
              );
            }
            final products = snapshot.data;
            return products == null || products.isEmpty
                ? const Center(
                    child: Text("Mahsulotlar mavjud emas, iltimos qo'shing"),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: products.length,
                    itemBuilder: (ctx, index) {
                      final product = products[index];
                      return ProductItem(
                        product: product,
                        onEdit: () {
                          editProduct(product);
                        },
                        onDelete: () {
                          deleteProduct(product);
                        },
                      );
                    },
                  );
          }),
    );
  }
}
