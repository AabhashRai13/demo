import 'package:bees_pharmacy/widgets/widet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_khalti/flutter_khalti.dart';

import 'package:get/get.dart';

import '../controllers/khalti_payment_controller.dart';

class KhaltiPaymentView extends GetView<KhaltiPaymentController> {
  final KhaltiPaymentController khaltiPaymentController =
      Get.put(KhaltiPaymentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
          onPressed: () => Get.back(),
        ),
        elevation: 1,
        iconTheme: IconThemeData(color: Colors.black),
        title: Row(
          children: [
            SizedBox(
              height: 36,
              child: Image.asset(
                'assets/khalti.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Khalti Payment',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 18,
              ),
              Text('Enter Amount :'),
              SizedBox(
                height: 18,
              ),
              input(
                  Icon(
                    Icons.attach_money,
                    color: Colors.blue,
                    size: 18,
                  ),
                  "Enter amount",
                  khaltiPaymentController.paymentController,
                  false,
                  TextInputType.number,
                  1),
              SizedBox(
                height: 16,
              ),
              MaterialButton(
                padding: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22)),
                onPressed: () {
                  _sendToKhalti(context);
                },
                minWidth: Get.width,
                color: Colors.blue,
                child: Text(
                  "PAYMENT",
                  style: TextStyle(
                      color: Colors.white, fontSize: 14, letterSpacing: 2),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _sendToKhalti(BuildContext context) {
    ///Khalti calculates money in paisa so converting it into rupees
    double amount =
        double.parse(khaltiPaymentController.paymentController.text.trim()) *
            100;

    FlutterKhalti _flutterKhalti = FlutterKhalti.configure(
        publicKey: "test_public_key_1105de95fd514cdab9b83446c9c481c8",
        urlSchemeIOS: "KhaltiPayFlutterExample");

    KhaltiProduct product =
        KhaltiProduct(id: "test", name: "Ausadi", amount: amount);

    _flutterKhalti.startPayment(
        product: product,
        onSuccess: (data) {
          print("success $data");
        },
        onFaliure: (error) {
          print("Failure message $error");
        });
  }
}
