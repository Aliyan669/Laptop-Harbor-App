import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:laptop_harbor_app/features/admin/category_screen.dart';
import 'package:laptop_harbor_app/features/admin/homes_creen.dart';
import 'package:laptop_harbor_app/features/admin/orders_screen.dart';
import 'package:laptop_harbor_app/features/admin/product_screen.dart';
import 'package:line_icons/line_icons.dart';
import 'package:laptop_harbor_app/features/profile/profile_screen.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int index = 0;

  final List<Widget> pages = [
    AdminHomeScreen(),
    OrdersScreen(),
    ProductScreen(),
    CategoryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1)),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 12,
                ),
                child: GNav(
                  gap: 8, // 
                  iconSize: 24,

                  color: Colors.grey,
                  activeColor: Colors.white,

                  tabBackgroundColor: Colors.black,

                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ), // 👈 space do

                  duration: Duration(milliseconds: 400),

                  tabs: [
                    GButton(
                      icon: LineIcons.home,
                      text: 'Home',
                      textStyle: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    GButton(
                      icon: LineIcons.shoppingCart,
                      text: 'Orders',
                      textStyle: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    GButton(
                      icon: LineIcons.productHunt,
                      text: 'Product',
                      textStyle: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    GButton(
                      icon: LineIcons.list,
                      text: 'Category',
                      textStyle: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    GButton(
                      icon: LineIcons.user,
                      text: 'Profile',
                      textStyle: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],

                  selectedIndex: index,
                  onTabChange: (val) {
                    setState(() {
                      index = val;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
