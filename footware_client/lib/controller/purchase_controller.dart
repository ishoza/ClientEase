import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PurchaseController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference orderCollection;

  TextEditingController addressController = TextEditingController();
  double orderPrice = 0;
  String itemName = '';
  String orderaddress = '';

  @override
  void onInit() {
    orderCollection = firestore.collection('orders');
    super.onInit();
  }

  submitOrder({
    required double price,
    required String item,
    required String description,
  }) {
    orderPrice = price;
    itemName = item;
    orderaddress = addressController.text;

    Razorpay _razorpay = Razorpay();
    var options = {
      'key': 'rzp_test_IvLmuEgdHDcvsH', 
      'amount': price * 100,
      'name': item,
      'description': description,
    };

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.open(options);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar('Success', 'Payment is successfully', colorText: Colors.green);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar('Success', '${response.message}', colorText: Colors.red);
  }
}
