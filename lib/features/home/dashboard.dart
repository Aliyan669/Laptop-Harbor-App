import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:laptop_harbor_app/features/auth/login_screen.dart';
import 'package:laptop_harbor_app/features/product/product_list_screen.dart';
import 'package:laptop_harbor_app/utils/utils.dart';
import 'package:line_icons/line_icons.dart';
import 'package:laptop_harbor_app/features/cart/cart_screen.dart';
import 'package:laptop_harbor_app/features/home/home_screen.dart';
import 'package:laptop_harbor_app/features/profile/profile_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int index = 0;

  final List<Widget> pages = [
    HomeScreen(),
    ProductListScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  // final email = FirebaseAuth.instance.currentUser!.email;
  var userData = {};

  Future logout(context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } catch (e) {
      Utils.showMessage(context, e.toString());
    }
  }

  // Future getUserData()async{
  //   final id=FirebaseAuth.instance.currentUser!.uid;
  //   final dbinstance=FirebaseFirestore.instance;
  //    final userdata=await dbinstance.collection('users').doc(id).get();
  //    if(userdata.exists){
  //    userData=userdata.data() as Map;
  //    print(userData['name']);
  //    }

  // }
  @override
  // void initState() {
  //   // TODO: implement initState
  //   getUserData();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LaptopHarbour"),
        actions: [
          IconButton(
            onPressed: () {
              // Utils.showCustomDailog(context,title: 'profile',name:userData['name'] ,email:userData['email'] );
            },
            icon: Icon(LineIcons.heart),
          ),
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
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
                BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.1)),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: GNav(
                  gap: 8,
                  iconSize: 24,

                  color: const Color.fromARGB(255, 83, 83, 83),
                  activeColor: const Color.fromARGB(255, 255, 255, 255),

                  tabBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  // .withOpacity(0.8)
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),

                  duration: Duration(milliseconds: 400),

                  tabs: [
                    GButton(icon: LineIcons.home, text: 'Home'),
                    GButton(icon: LineIcons.productHunt, text: 'Product'),
                    GButton(icon: LineIcons.shoppingCart, text: 'Cart'),
                    GButton(icon: LineIcons.user, text: 'Profile'),
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
