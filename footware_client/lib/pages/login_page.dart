import 'package:flutter/material.dart';
import 'package:footware_client/controller/login_controller.dart';
import 'package:footware_client/pages/register_page.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (ctrl) {
      return Scaffold(
          body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'welcome Back!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 66, 48, 106),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: ctrl.loginNumberctrl,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.phone_android),
                labelText: 'Mobile Number',
                hintText: 'Enter your Mobile Number',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ctrl.loginwithphone();
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color.fromARGB(255, 66, 46, 108),
              ),
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Get.to(RegisterPage());
              },
              child: const Text('Register New Account'),
            )
          ],
        ),
      ));
    });
  }
}
