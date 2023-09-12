import 'package:amazon_shop/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    //cek data usernya yang login sudah ada atau belum
    //menangkap data user yang login
    final user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
        body: Center(
      child: Text(
        user.toJson(), //tampilkan ke json
        style: const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ));
  }
}
