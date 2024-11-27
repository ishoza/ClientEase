import 'package:flutter/material.dart';
import 'package:footware_client/controller/login_controller.dart';
import 'package:footware_client/pages/login_page.dart';
import 'package:footware_client/widgets/otp_txt_field.dart';
import 'package:get/get.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                'Create Your Account!!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 66, 48, 106),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.phone,
                controller: ctrl.registerNumberctrl,
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
              TextField(
                keyboardType: TextInputType.phone,
                controller: ctrl.registerNamectrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.phone_android),
                  labelText: 'Your Name',
                  hintText: 'Enter your Name',
                ),
              ),
              const SizedBox(height: 20),
              OtpTxtField(
                otpController: ctrl.otpController,
                visble: ctrl.otpFieldShow,
                onComplete: (otp) {
                  ctrl.otpEnter = int.tryParse(otp ?? '000');
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (ctrl.otpFieldShow) {
                    ctrl.addUser();
                  } else {
                    ctrl.sendOtp();
                  }
                  ctrl.sendOtp();
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color.fromARGB(255, 66, 46, 108),
                ),
                child: Text(ctrl.otpFieldShow ? 'Register' : 'Send OTP'),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Get.to(const LoginPage());
                },
                child: const Text('Login'),
              )
            ],
          ),
        ),
      );
    });
  }

  OtpTextField({required OtpFieldControllerV2 otpController}) {}
}
