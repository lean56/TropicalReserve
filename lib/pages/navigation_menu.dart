import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/pages/home_page.dart';
import 'package:myapp/pages/list_page.dart';
import 'package:myapp/pages/print_reservation_page.dart';

import 'reservation_page.dart';

class NavigationMenu extends StatelessWidget {
  final NavigationController controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 70,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.changeIndex(index),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "Inicio"),
            NavigationDestination(icon: Icon(Icons.local_restaurant), label: "Reservar"),
            NavigationDestination(icon: Icon(Icons.event_available), label: "Disponible"),
            NavigationDestination(icon: Icon(Icons.print), label: "Imprimir"),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final selectedIndex = 0.obs;

  final screens = [
    const HomeScreen(),
    RestaurantView(),
    Container(color: Colors.blue), // Placeholder for "Disponible"
    RestaurantView(), // Corregido aquí
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
