import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lesson47/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final Function() onEdit;
  final Function() onDelete;
  const ProductItem({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 150,
              color: Colors.primaries[Random().nextInt(17)],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Amount: ${product.amount}",
                ),
              ],
            ),
            Text(
              "\$${product.price}",
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: onEdit,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                  label: const Text(
                    "Tahrirlash",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: onDelete,
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: const Text("O'chirish",
                      style: TextStyle(
                        color: Colors.red,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
