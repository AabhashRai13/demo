import 'package:bees_pharmacy/widgets/widet_page.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/update_profile_controller.dart';

class UpdateProfileView extends GetView<UpdateProfileController> {
  final _formKey = GlobalKey<FormState>();
  final UpdateProfileController updateProfileController =
      Get.put(UpdateProfileController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus && currentScope.hasFocus) {
          FocusManager.instance.primaryFocus.unfocus();
          FocusScope.of(context).unfocus();

          updateProfileController.firstNameController.clear();
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            elevation: 0,
            title: Text(
              'Update Profile',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: ListView(
            shrinkWrap: true,
            children: [
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 20,
                      left: Get.width * 0.07,
                      right: Get.width * 0.07,
                      bottom: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        inputFirstName(),
                        gap(10, 0),
                        inputLastName(),
                        gap(10, 0),
                        inputShippingAddress(),
                        gap(10, 0),
                        inputBillingAddress(),
                        gap(10, 0),
                        inputContact(),
                        gap(10, 0),
                        inputCity(),
                        gap(10, 0),
                        inputAddress(),
                        gap(10, 0),
                        Text(
                          'Gender',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        gap(6, 0),
                        inputGender(),
                        gap(20, 0),
                        submitButton(),
                      ]),
                ),
              ),
            ],
          )),
    );
  }

  Widget inputFirstName() {
    return TextFormField(
      controller: updateProfileController.firstNameController,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,

          // isDense: true,
          // errorBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(5),
          //   borderSide: BorderSide(
          //     color: Colors.red,
          //     width: 2.0,
          //   ),
          // ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.black)),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.black)),
          hintText: 'First Name',
          hintStyle: TextStyle(color: Colors.blue)),
      validator: (value) {
        if (value.isEmpty) {
          return 'Field cannot be empty';
        } else
          return null;
      },
    );
  }

  Widget inputLastName() {
    return TextFormField(
      controller: updateProfileController.lastNameController,
      decoration: InputDecoration(
          isDense: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.black)),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.black)),
          hintText: 'Last Name',
          hintStyle: TextStyle(color: Colors.blue)),
      validator: (value) {
        if (value.isEmpty) {
          return 'Field cannot be empty';
        } else
          return null;
      },
    );
  }

  Widget inputGender() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              activeColor: Colors.blue,
              value: 0,
              groupValue: updateProfileController.genderRadioValue.value,
              onChanged: updateProfileController.handleGenderChange),
          Text('Male'),
          Radio(
              activeColor: Colors.blue,
              value: 1,
              groupValue: updateProfileController.genderRadioValue.value,
              onChanged: updateProfileController.handleGenderChange),
          Text('Female'),
        ],
      ),
    );
  }

  Widget inputShippingAddress() {
    return TextFormField(
      controller: updateProfileController.shippingAddressController,
      decoration: InputDecoration(
          isDense: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.black)),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.black)),
          hintText: 'Shipping Address',
          hintStyle: TextStyle(color: Colors.blue)),
      validator: (value) {
        if (value.isEmpty) {
          return 'Field cannot be empty';
        } else
          return null;
      },
    );
  }

  Widget inputBillingAddress() {
    return TextFormField(
      controller: updateProfileController.billingAddressController,
      decoration: InputDecoration(
          isDense: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.black)),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.black)),
          hintText: 'Billing Address',
          hintStyle: TextStyle(color: Colors.blue)),
      validator: (value) {
        if (value.isEmpty) {
          return 'Field cannot be empty';
        } else
          return null;
      },
    );
  }

  Widget inputContact() {
    return TextFormField(
      controller: updateProfileController.contactController,
      decoration: InputDecoration(
          isDense: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.black)),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.black)),
          hintText: 'Contact Number',
          hintStyle: TextStyle(color: Colors.blue)),
      validator: (value) {
        if (value.isEmpty) {
          return 'Field cannot be empty';
        } else if (!value.isNumericOnly) {
          return 'Invalid number';
        } else if (value.length != 10) {
          return 'Phone number length should be of 10 digits';
        } else
          return null;
      },
    );
  }

  Widget inputCity() {
    return TextFormField(
      controller: updateProfileController.cityController,
      decoration: InputDecoration(
          isDense: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.black)),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.black)),
          hintText: 'City',
          hintStyle: TextStyle(color: Colors.blue)),
      validator: (value) {
        if (value.isEmpty) {
          return 'Field cannot be empty';
        } else
          return null;
      },
    );
  }

  Widget inputAddress() {
    return TextFormField(
      controller: updateProfileController.addressController,
      decoration: InputDecoration(
          isDense: true,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.black)),
          border: OutlineInputBorder(
              borderSide: BorderSide(width: 0.5, color: Colors.black)),
          hintText: 'Address',
          hintStyle: TextStyle(color: Colors.blue)),
      validator: (value) {
        if (value.isEmpty) {
          return 'Field cannot be empty';
        } else
          return null;
      },
    );
  }

  Widget submitButton() {
    return MaterialButton(
      padding: EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.blue,
      minWidth: Get.width * 0.9,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          print('validated');
          updateProfileController.mapProfile();
        } else
          return;
      },
      child: Text(
        'Update',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
