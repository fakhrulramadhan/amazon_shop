import 'package:amazon_shop/common/widgets/bottom_bar.dart';
import 'package:amazon_shop/features/admin/screens/add_product_screen.dart';
import 'package:amazon_shop/features/auth/screens/auth_screen.dart';
import 'package:amazon_shop/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';

// atur routenya disini
Route<dynamic> generateRoute(RouteSettings routeSettings) {
  // case '/auth_screen':
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const AuthScreen(), settings: routeSettings);

    case HomeScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const HomeScreen(), settings: routeSettings);

    case BottomBar.routeName:
      return MaterialPageRoute(
          builder: (_) => const BottomBar(), settings: routeSettings);

    case AddProductScreen.routeName:
      return MaterialPageRoute(
          builder: (_) => const AddProductScreen(), settings: routeSettings);

    default:
      return MaterialPageRoute(
          builder: (_) => const Center(
                child: Text("Screen doesnt exist"),
              ),
          settings: routeSettings);
  }
}
