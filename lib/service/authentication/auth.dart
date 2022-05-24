import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vinsartisanmarket/Models/AuthUser.dart';

import 'package:vinsartisanmarket/Styles/ButtonStyles.dart';
import 'package:vinsartisanmarket/Styles/TextStyles.dart';
import 'package:vinsartisanmarket/screens/layout.dart';
import 'package:vinsartisanmarket/components/primaryLoadingIndicator.dart';
import 'package:vinsartisanmarket/components/snackBar.dart';
import 'package:vinsartisanmarket/service/http_handeler/httpClient.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool loading = false.obs;
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    void signIn() async {
      loading.value = true;
      Map res = await httpClient.signIn({
        'email': _emailController.text,
        'password': _passwordController.text
      });

      if (kDebugMode) {
        print(res);
      }

      if (res['code'] == 200) {
        httpClient.setToken(res['data']['token']);
        authUser.saveUser(res['data']['user']);
        Get.offAll(() => const Layout());
      } else {
        showSnackBar('Oops!', 'Email/Password is incorrect. Please try again.');
        loading.value = false;
      }
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('VinS', style: TextStyles.title(64, Colors.indigo)),
              Text('Artisan Market',
                  style: TextStyles.title(21, Colors.indigo)),
              const SizedBox(height: 32),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: Get.width * 0.4,
                    height: 48,
                    child: ElevatedButton(
                      style: ButtonStyles.primaryButton(),
                      onPressed: () {
                        signIn();
                      },
                      child: Obx(() => loading.value
                          ? primaryLoadingIndicator()
                          : const Text('Sign In')),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.4,
                    height: 48,
                    child: TextButton(
                        style: ButtonStyles.primaryButton(),
                        onPressed: () {},
                        child: const Text('Forgot Password?')),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
