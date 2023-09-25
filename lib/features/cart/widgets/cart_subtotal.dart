import 'package:amazon_shop/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({super.key});

  @override
  Widget build(BuildContext context) {
    //memantau data user yang login
    //ambil datanya yang sudah tertampung di model user
    final user = context.watch<UserProvider>().user;
    int sum = 0;

    //utk mengetahui harga barang
    // belanjaan user di keranjang sekaligus menjumlahkannya
    //e itu adalah data cartnya user
    //jumlah barang dipesan dikali harga produk, dan otomatis menjumlahkan
    //jmlah barang yang dipesan (toList)
    user.cart
        .map((e) => sum += e['quantity'] * e['product']['price'] as int)
        .toList();
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            "Subtotal",
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          Text(
            "\$ $sum",
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
