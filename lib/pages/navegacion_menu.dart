import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/lista_global.dart';
import 'disponibilidad_page.dart';
import 'home_page.dart';
import 'select_restaurant_page.dart';
import 'reservacion_page.dart';

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
            NavigationDestination(icon: Icon(Icons.list), label: "Ver Reservaciones"),
            NavigationDestination(icon: Icon(Icons.visibility), label: "Disponibilidad"),
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
    ReservationsListScreen(reservations: listaGlobal),
    DisponibilidadPage(),
  ];

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
