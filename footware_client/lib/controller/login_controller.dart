import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:footware_client/model/user/user.dart';
import 'package:footware_client/pages/Home_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';

class LoginController extends GetxController {
  GetStorage box = GetStorage();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference userCollection;

  TextEditingController registerNumberctrl = TextEditingController();
  TextEditingController registerNamectrl = TextEditingController();

  TextEditingController loginNumberctrl = TextEditingController();

  OtpFieldControllerV2 otpController = OtpFieldControllerV2();
  bool otpFieldShow = false;
  int? otpSend;
  int? otpEnter;

  User? loginuser;

  @override
  void onReady() {
    Map<String, dynamic>? user = box.read('loginuser');
    if (user != null) {
      loginuser = User.fromJson(user);
      Get.to(HomePage());
    }
  }

  @override
  void onInit() {
    userCollection = firestore.collection('users');
    super.onInit();
  }

  addUser() {
    try {
      if (otpSend == otpEnter) {
        DocumentReference doc = userCollection.doc();
        User user = User(
          id: doc.id,
          name: registerNamectrl.text,
          number: int.parse(registerNumberctrl.text),
        );
        final userJson = user.tojson();
        doc.set(userJson);
        Get.snackbar('Success', 'User added successfully',
            colorText: Colors.green);
        registerNamectrl.clear();
        registerNumberctrl.clear();
        otpController.clear();
      } else {
        Get.snackbar('Error', 'Otp is incorrect', colorText: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.green);
      print(e);
    }
  }

  sendOtp() {
    try {
      if (registerNamectrl.text.isEmpty || registerNumberctrl.text.isEmpty) {
        Get.snackbar('Error', 'Please fill the field', colorText: Colors.red);
        return;
      }
      final random = Random();
      int otp = 1000 + random.nextInt(9000);
      print(otp);
      // ignore: unnecessary_null_comparison
      if (otp != null) {
        otpFieldShow = true;
        otpSend = otp;
        Get.snackbar('Success', 'OTP send successfully',
            colorText: Colors.green);
      } else {
        Get.snackbar('error', 'OTP not send', colorText: Colors.red);
      }
    } on Exception catch (e) {
      print(e);
    } finally {
      update();
    }
  }

  Future<void> loginwithphone() async {
    try {
      String phoneNumber = loginNumberctrl.text;
      if (phoneNumber.isNotEmpty) {
        var querySnapshot = await userCollection
            .where('number', isEqualTo: int.tryParse(phoneNumber))
            .limit(1)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          var x = querySnapshot.docs.first;
          var userData = x.data() as Map<String, dynamic>;
          box.write('loginuser', userData);
          loginNumberctrl.clear();
          Get.to(HomePage());
          Get.snackbar('Success', 'Login Successful', colorText: Colors.green);
        } else {
          Get.snackbar('Error', 'User not found,please register',
              colorText: Colors.red);
        }
      } else {
        Get.snackbar('Error', 'Please enter phone number',
            colorText: Colors.red);
      }
    } catch (error) {
      print("Failed to Login: $error");
      Get.snackbar('Error', 'Failed to login', colorText: Colors.red);
    }
  }
}
