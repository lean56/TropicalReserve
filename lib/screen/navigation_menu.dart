import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/screen/reservation_screen.dart';
import 'home_screen.dart';
import 'restaurant_screen.dart';

class NavigationMenu extends StatelessWidget {
  final controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 70, // Ajusta el tamaño si es necesario
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.changeIndex(index),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "Inicio"),
            NavigationDestination(icon: Icon(Icons.local_restaurant), label: "Reservar"),
            NavigationDestination(icon: Icon(Icons.event_available), label: "Disponible"),
            NavigationDestination(icon: Icon(Icons.view_list), label: "Reservaciones"),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  // Observa el índice seleccionado
  final selectedIndex = 0.obs;

  // Define las pantallas que se mostrarán según el índice
  final screens = [
    const HomeScreen(),
    RestaurantView(),
    Reservation(), // Ajusta el nombre según tu implementación
    Container(color: Colors.blue), // Pantalla para "Imprimir"
  ];

  // Cambia el índice seleccionado
  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}
