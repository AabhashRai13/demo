import 'package:bees_pharmacy/app/modules/prescription_page/views/image_upload_view.dart';
import 'package:bees_pharmacy/app/modules/prescription_page/views/text_upload_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/prescription_page_controller.dart';

class PrescriptionPageView extends GetView<PrescriptionPageController> {
  final PrescriptionPageController prescriptionPageController =
      Get.put(PrescriptionPageController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                size: 18,
              ),
              onPressed: () => Get.back(),
            ),
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            title: Text(
              'Add Prescription',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            centerTitle: false,
            bottom: TabBar(
                labelColor: Colors.blue,
                unselectedLabelColor: Colors.white,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: Colors.white),
                isScrollable: true,
                tabs: [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Image Upload',
                          style: (TextStyle(fontSize: 14)),
                        ),
                      ),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Text Upload',
                          style: (TextStyle(fontSize: 14)),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
          body: TabBarView(children: [ImageUploadView(), TextUploadView()])),
    );
  }
}
