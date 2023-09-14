import 'package:amazon_shop/constants/global_variables.dart';
import 'package:amazon_shop/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../../features/account/screens/account_screen.dart';
import 'package:badges/badges.dart' as badge;

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  //utk pindah menu btoom bar
  void updatePage(int page) {
    _page = page;

    setState(() {});
  }

  List<Widget> pages = [
    const HomeScreen(), //page 0
    const AccountScreen(),
    const Center(
      child: Text("Cart Page"),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page], //ke pages[index page ke berapa]
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _page,
          selectedItemColor: GlobalVariables.selectedNavBarColor,
          unselectedItemColor: GlobalVariables.unselectedNavBarColor,
          backgroundColor: GlobalVariables.backgroundColor,
          iconSize: 30,
          onTap: updatePage,
          items: [
            BottomNavigationBarItem(
              icon: Container(
                width: bottomBarWidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: _page == 0
                                ? GlobalVariables.selectedNavBarColor
                                : GlobalVariables.backgroundColor,
                            width: bottomBarBorderWidth))),
                child: const Icon(
                  Icons.home_outlined,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Container(
                  width: bottomBarWidth,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              color: _page == 1
                                  ? GlobalVariables.selectedNavBarColor
                                  : GlobalVariables.backgroundColor,
                              width: bottomBarBorderWidth))),
                  child: const Icon(
                    Icons.person_outline_outlined,
                  ),
                ),
                label: 'Account'),
            BottomNavigationBarItem(
                icon: Container(
                    width: bottomBarWidth,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: _page == 2
                                    ? GlobalVariables.selectedNavBarColor
                                    : GlobalVariables.backgroundColor,
                                width: bottomBarBorderWidth))),
                    child: const badge.Badge(
                      badgeContent: Text(
                        "3",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      badgeStyle: badge.BadgeStyle(
                          elevation: 0, badgeColor: Colors.cyan),
                      child: Icon(
                        Icons.shopping_cart_checkout_outlined,
                        size: 24.0,
                      ),
                    )),
                label: ''),
          ]),
    );
  }
}
