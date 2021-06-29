import 'package:bees_pharmacy/app/modules/Cart/views/cart_view.dart';
import 'package:bees_pharmacy/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavBar extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 65,
      child: Stack(
        children: [
          CustomPaint(
            size: Size(size.width, 80),
            painter: BNBCustomPainter(),
          ),
          Center(
            heightFactor: 0.9,
            child: FloatingActionButton(
                backgroundColor: Colors.blue,
                child: Icon(Icons.shopping_basket),
                elevation: 0.1,
                onPressed: () {
                  Get.to(() => CartView());
                }),
          ),
          Obx(
            /// [Observer] listens for state changes
            () => Container(
              width: size.width,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    splashRadius: 5,
                    icon: Icon(
                      Icons.home,
                      color: homeController.currentIndex.value == 0
                          ? Colors.blue
                          : Colors.grey.shade400,
                    ),
                    onPressed: () {
                      homeController.setBottomBarIndex(
                          0, 'Home', Icon(Icons.search_outlined));

                      print(homeController.currentIndex.value);
                    },
                    splashColor: Colors.white,
                  ),
                  IconButton(
                      splashRadius: 3,
                      icon: Icon(
                        Icons.favorite,
                        color: homeController.currentIndex.value == 1
                            ? Colors.blue
                            : Colors.grey.shade400,
                      ),
                      onPressed: () {
                        homeController.setBottomBarIndex(
                            1, 'WishList', Icon(Icons.search_outlined));
                      }),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 30);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
