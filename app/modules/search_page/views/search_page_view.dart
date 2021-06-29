import 'package:bees_pharmacy/app/modules/search_page/controllers/search_page_controller.dart';
import 'package:bees_pharmacy/app/routes/app_pages.dart';
import 'package:bees_pharmacy/widgets/product_wise_container_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SearchView extends GetView {
  final SearchPageController searchPageController =
      Get.put(SearchPageController());
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget productWidget() {
    return searchPageController.productResponse == null
        ? CircularProgressIndicator()
        : Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: _randomProducts(),
          );
  }

  Widget _randomProducts() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 12,
          ),
          Obx(
            () => Center(
              child: Wrap(
                  spacing: 6,
                  children: List.generate(
                      searchPageController.productResponse.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.DETAIL_PAGE,
                            arguments:
                                searchPageController.productResponse[index]);
                      },
                      child: productWiseContainer(

                          searchPageController
                              .productResponse[index],
                          searchPageController.productResponse[index].name,
                          "",
                          searchPageController
                              .productResponse[index].variant[0].price,
                          searchPageController
                                      .productResponse[index].photos.length <=
                                  0
                              ? null
                              : searchPageController
                                  .productResponse[index].photos[0].photo,
                          100,
                          156,
                          null,
                          null,
                          searchPageController.productResponse[index].id,
                          searchPageController.productResponse[index].isAdded,
                          null),
                    );
                  })),
            ),
          )
        ],
      ),
    );
  }

  inputSearch() {
    return Container(
      width: Get.width,
      padding: EdgeInsets.only(left: 14, top: 3),
      margin: EdgeInsets.only(top: 6, bottom: 6),
      decoration: BoxDecoration(
          color: Colors.blueGrey[100].withOpacity(0.2),
          borderRadius: BorderRadius.circular(38)),
      child: TextFormField(
        controller: searchPageController.searchText,
        autofocus: false,
        maxLines: 1,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          fillColor: Colors.lightBlueAccent,
          hintText: 'Search',
          suffixIcon: IconButton(
            onPressed: () => searchPageController.fetchProducts(),
            icon: Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(0, 0))
              ]),
              child: Center(
                child: Row(
                  children: [
                    Flexible(
                      flex: 2,
                      child: IconButton(
                          padding: EdgeInsets.only(left: 15),
                          constraints: BoxConstraints(),
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () => Navigator.of(context).pop()),
                    ),
                    Flexible(
                      flex: 9,
                      child: inputSearch(),
                    ),
                    Flexible(
                        flex: 0,
                        child: SizedBox(
                          width: 0.01,
                        ))
                  ],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                productWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
