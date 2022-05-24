import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vinsartisanmarket/Models/AuthUser.dart';
import 'package:get/get.dart';
import 'package:vinsartisanmarket/service/authentication/auth.dart';

class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout'),
        actions: [
          IconButton(
            icon: const Icon(Icons.login),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              Get.offAll(() => const Auth());
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(authUser.user['name']),
            Text(authUser.email),
          ],
        ),
      ),
    );
  }
}
