import 'package:bees_pharmacy/app/modules/login_page/controllers/login_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final LoginPageController controller = Get.put(LoginPageController());

Widget logo() {
  return Padding(
    padding: EdgeInsets.only(top: Get.size.height * 0.15),
    child: Container(
      width: Get.size.width,
      height: 220,
      child: Stack(
        children: <Widget>[
          Positioned(
            child: Container(
                height: 154,
                child: Align(
                  child: Image.asset(
                    "assests/logo_bees.png",
                  ),
                )),
          ),
        ],
      ),
    ),
  );
}

//input widget
Widget input(
  Icon icon,
  String hint,
  TextEditingController textEditingController,
  bool obsecure,
  TextInputType textInputType,
  int lines,
) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(60),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          offset: Offset(0, 0),
          spreadRadius: 1,
          blurRadius: 4,
        )
      ],
    ),
    child: TextFormField(
      maxLines: lines,
      keyboardType: textInputType,
      obscureText: obsecure,
      validator: (value) {
        if (value.isEmpty) {
          return '$hint cannot be empty';
        } else
          return null;
      },
      controller: textEditingController,
      style: TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        suffixIcon: icon,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: hint,
        contentPadding: EdgeInsets.all(20),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
    ),
  );
}

Widget inputEmail(
  Icon icon,
  String hint,
  TextEditingController textEditingController,
  bool obsecure,
  TextInputType textInputType,
  int lines,
) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(60),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          offset: Offset(0, 0),
          spreadRadius: 2,
          blurRadius: 4,
        )
      ],
    ),
    child: TextFormField(
      maxLines: lines,
      keyboardType: textInputType,
      obscureText: obsecure,
      validator: (value) {
        if (value.isEmail == null || value.isEmpty) {
          return 'email empty';
        }

        const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
        final regExp = RegExp(pattern);

        if (!regExp.hasMatch(value)) {
          return 'Invalid email address';
        }
        return null;
      },
      controller: textEditingController,
      style: TextStyle(
        color: Colors.black,
      ),
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        suffixIcon: icon,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: hint,
        contentPadding: EdgeInsets.all(20),
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(50)),
        labelStyle: TextStyle(
          color: Colors.grey,
        ),
      ),
    ),
  );
}

Widget button(
    String text,
    Color textColor,
    Color buttonColor,
    double horizontalPadding,
    double verticalPadding,
    function(),
    double textSize) {
  return MaterialButton(
    padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding, vertical: verticalPadding),
    color: buttonColor,
    onPressed: function(),
    child: Text(
      text,
      style: TextStyle(fontSize: textSize, color: textColor),
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
  );
}

Widget gap(double hvalue, double wvalue) {
  return SizedBox(
    height: hvalue,
    width: wvalue,
  );
}

Widget deleteIcon(value, int id, int index) {
  return IconButton(
      splashRadius: 1,
      constraints: BoxConstraints(),
      padding: EdgeInsets.only(left: 130),
      icon: Icon(
        Icons.delete,
        size: 20,
        color: Colors.red[400],
      ),
      onPressed: () {
        print(value);
      });
}

Widget shopIcon(value) {
  return IconButton(
      splashRadius: 2,
      constraints: BoxConstraints(),
      padding: EdgeInsets.only(left: 20, bottom: 0),
      icon: Icon(
        Icons.shop,
        size: 20,
        color: Colors.blue,
      ),
      onPressed: () {
        print(value);
      });
}

Widget imageContainer(value, products) {
  return Stack(
    alignment: Alignment.center,
    children: [
      ClipRRect(
        child: value == null
            ? Image.asset(
                "assets/loading.gif",
                height: 72,
                width: 72,
                fit: BoxFit.fill,
              )
            : Image.network(value),
      ),
    ],
  );
}
