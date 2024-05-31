import 'package:flutter/material.dart';
import 'package:lesson47/models/product.dart';

class ManageProductDialog extends StatefulWidget {
  final Product? product;
  const ManageProductDialog({
    super.key,
    this.product,
  });

  @override
  State<ManageProductDialog> createState() => _ManageProductDialogState();
}

class _ManageProductDialogState extends State<ManageProductDialog> {
  final formKey = GlobalKey<FormState>();
  String title = "";
  double price = 0;
  int amount = 0;

  @override
  void initState() {
    super.initState();

    if (widget.product != null) {
      title = widget.product!.title;
      price = widget.product!.price;
      amount = widget.product!.amount;
    }
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Navigator.pop(context, {
        "title": title,
        "price": price,
        "amount": amount,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Text(
        widget.product != null ? "Mahsulotni tahrirlash" : "Mahsulot qo'shish",
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: title,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Mahsulot nomi",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos mahsulot nomini kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                title = newValue!;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: price.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Mahsulot narxini",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos mahsulot narxini kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                price = double.parse(newValue!);
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: amount.toString(),
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Mahsulot sonini",
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Iltimos mahsulot sonini kiriting";
                }

                return null;
              },
              onSaved: (newValue) {
                amount = int.parse(newValue!);
              },
            ),
          ],
        ),
      ),
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
