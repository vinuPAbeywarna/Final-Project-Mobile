// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vinsartisanmarket/constansts/ui_constansts.dart';
import 'package:vinsartisanmarket/screens/home/account_tab/account_screen.dart';
import 'package:vinsartisanmarket/screens/home/cart_tab/cartscreen.dart';

import 'package:vinsartisanmarket/screens/home/store_tab/storescreen.dart';
import 'package:vinsartisanmarket/screens/home/wishlist_tab/notification_screen.dart';
import 'package:vinsartisanmarket/screens/home/wishlist_tab/wishListscreen.dart';
import 'package:vinsartisanmarket/test/testscreen.dart';

class HomeScreen extends StatefulWidget {
  final int index;

  const HomeScreen({Key? key, this.index = 1}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  DateTime pre_backpress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      const AccountScreen(),
      const StoreScreen(),
      const CartScreen(),
      const WishListScreen(),
    ];
    return WillPopScope(
      onWillPop: () {
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if (cantExit) {
          //show snackbar
          final snack = SnackBar(
            content: Text('Press Back button again to Exit'),
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return Future<bool>.value(false);
        } else {
          return Future<bool>.value(true);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: kprimaryColor,
                hoverColor: kmenucolor,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 300),
                tabBackgroundColor: kmenucolor.withOpacity(0.7),
                color: Colors.black,
                // ignore: prefer_const_literals_to_create_immutables
                tabs: [
                  GButton(
                    icon: LineIcons.user,
                    text: 'Account',
                  ),
                  GButton(
                    icon: LineIcons.store,
                    text: 'Store',
                  ),
                  GButton(
                    icon: LineIcons.shoppingCart,
                    text: 'Cart',
                  ),
                  GButton(
                    icon: LineIcons.heart,
                    text: 'WishList',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
