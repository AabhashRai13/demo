import 'package:bees_pharmacy/widgets/viewAllWidget/ViewAllWidget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/view_all_controller.dart';

class ViewAllView extends GetView<ViewAllController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: 240,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                    image: AssetImage('assets/curve1.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Text(''),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 18),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            Row(
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.favorite_border_outlined,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(),
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.shopping_cart_outlined,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: DefaultTabController(
                      length: 5,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: TabBar(
                                indicatorPadding: EdgeInsets.zero,
                                labelColor: Colors.white,
                                unselectedLabelColor:
                                    Colors.black.withOpacity(0.3),
                                indicatorColor: Colors.transparent,
                                isScrollable: true,
                                tabs: [
                                  Text(
                                    'Image Upload',
                                    style: (TextStyle(
                                      fontSize: 14,
                                    )),
                                  ),
                                  Text(
                                    'Image Upload',
                                    style: (TextStyle(
                                      fontSize: 14,
                                    )),
                                  ),
                                  Text(
                                    'Image Upload',
                                    style: (TextStyle(
                                      fontSize: 14,
                                    )),
                                  ),
                                  Text(
                                    'Image Upload',
                                    style: (TextStyle(
                                      fontSize: 14,
                                    )),
                                  ),
                                  Text(
                                    'Image Upload',
                                    style: (TextStyle(
                                      fontSize: 14,
                                    )),
                                  ),
                                ]),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 12.0,
                                right: 12.0,
                              ),
                              child: TabBarView(children: [
                                listGridView(context),
                                listGridView(context),
                                listGridView(context),
                                listGridView(context),
                                listGridView(context),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
