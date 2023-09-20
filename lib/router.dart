import 'package:amazon_shop/common/widgets/bottom_bar.dart';
import 'package:amazon_shop/features/admin/screens/add_product_screen.dart';
import 'package:amazon_shop/features/auth/screens/auth_screen.dart';
import 'package:amazon_shop/features/home/screens/category_deals_screens.dart';
import 'package:amazon_shop/features/home/screens/home_screen.dart';
import 'package:amazon_shop/features/search/screens/search_screen.dart';
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
    case CategoryDealsScreen.routeName:
      //akan bawa argumen dari category yang dipilih pada saat diklik
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          builder: (_) => CategoryDealsScreen(
                category: category,
              ),
          settings: routeSettings);
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      //karena searchquery dijadikan arguments, maka hapus constnya
      return MaterialPageRoute(
          builder: (_) => SearchScreen(
                searchQuery: searchQuery,
              ),
          settings: routeSettings);

    default:
      return MaterialPageRoute(
          builder: (_) => const Center(
                child: Text("Screen doesnt exist"),
              ),
          settings: routeSettings);
  }
}
