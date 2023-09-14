import 'package:amazon_shop/constants/global_variables.dart';
import 'package:amazon_shop/features/admin/screens/posts_screen.dart';
import 'package:flutter/material.dart';

import 'package:badges/badges.dart' as badge;

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  //utk pindah menu btoom bar
  void updatePage(int page) {
    _page = page;

    setState(() {});
  }

  List<Widget> pages = [
    const PostsScreen(), //page 0
    const Center(
      child: Text("Shop Page"),
    ),
    const Center(
      child: Text("Cart Page"),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(52), //tingginya 52
        child: AppBar(
          flexibleSpace: Container(
            decoration:
                const BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  "assets/images/amazon_in.png",
                  width: 120.0,
                  height: 45.0,
                  //fit: BoxFit.fill,
                  color: Colors.black,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(
                        Icons.notifications_outlined,
                        size: 24.0,
                      ),
                    ),
                    Icon(
                      Icons.search,
                      size: 24.0,
                    )
                  ],
                ),
              ),
              const Text(
                "Admin",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
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
            //Orders
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
                    Icons.all_inbox_outlined,
                  ),
                ),
                label: 'Orders'),
            // Analytics
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
                        Icons.analytics,
                        size: 24.0,
                      ),
                    )),
                label: 'Analytics'),
          ]),
    );
  }
}
