import 'package:ebazaar/consts/consts.dart';
import 'package:ebazaar/controllers/home_controller.dart';
import 'package:ebazaar/views/cart_screen/cart_screen.dart';
import 'package:ebazaar/views/category_screen/category_screen.dart';
import 'package:ebazaar/views/home_screen/home_screen.dart';
import 'package:ebazaar/views/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navbaritem = [
      BottomNavigationBarItem(
        icon: Image.asset(
          icHome,
          width: 26,
        ),
        label: home,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          icCategories,
          width: 26,
        ),
        label: categories,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          icCart,
          width: 26,
        ),
        label: cart,
      ),
      BottomNavigationBarItem(
        icon: Image.asset(
          icProfile,
          width: 26,
        ),
        label: account,
      ),
    ];

    var navbody = [
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      body: Column(
        children: [
          Obx(
            () => Expanded(
              child: navbody.elementAt(controller.currentNavIndex.value),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentNavIndex.value,
          backgroundColor: whiteColor,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: redColor,
          selectedLabelStyle: TextStyle(fontFamily: semibold),
          items: navbaritem,
          onTap: (value) {
            controller.currentNavIndex.value = value;
          },
        ),
      ),
    );
  }
}
