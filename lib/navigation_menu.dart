import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationMenu extends StatelessWidget {
  final controller = Get.put(NavigationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        ()=> NavigationBar(
        height: 80,
        elevation: 0,
        selectedIndex: controller.selectedIndex.value,
        onDestinationSelected: (index) => controller.selectedIndex.value =index,

        destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "Inicios"),
            NavigationDestination(icon: Icon(Icons.add), label: "Realizar Reservacion"),
            NavigationDestination(icon: Icon(Icons.find_in_page), label: "Ver Reservacion"),
            NavigationDestination(icon: Icon(Icons.print), label: "Imprimir Reservacion"),
          ],
          )
        ),
        body: Obx(()=> controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;

  final screens = [Container(color: Colors.green), Container(color: Colors.purple), Container(color: Colors.orange), Container(color: Colors.blue)];
}