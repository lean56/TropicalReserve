import 'package:flutter/material.dart';
import 'package:myapp/lista_global.dart';
import 'reservation_page.dart';

class RestaurantView extends StatelessWidget {
  final List<String> images = [
    'assets/images/ember.png',
    'assets/images/zao.png',
    'assets/images/grappa.png',
    'assets/images/larimar.png',
  ];

  final List<String> restaurantNames = [
    'Ember',
    'Zao',
    'Grappa',
    'Larimar',
  ];


  final Map<String, int> capacidades = {
    'Ember': 3,
    'Zao': 4,
    'Grappa': 2,
    'Larimar': 3,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Restaurantes')),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 3 / 2,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 4,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RestaurantDetailScreen(
                      image: images[index],
                      nombreRestaurante: restaurantNames[index],
                      reservacion: listaGlobal, // Pasa la lista global de reservaciones
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Image.asset(
                      images[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    restaurantNames[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class RestaurantDetailScreen extends StatelessWidget {
  final String image;
  final String nombreRestaurante;
  final List<Reservacion> reservacion; // Lista de reservaciones

  const RestaurantDetailScreen({
    Key? key,
    required this.image,
    required this.nombreRestaurante,
    required this.reservacion, // Inicializa la lista de reservaciones
  }) : super(key: key);

  void mostrarReservaciones(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReservationsListScreen(
          reservations: reservacion, // Pasa la lista de reservaciones a la pantalla de lista
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              image,
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            Text(
              nombreRestaurante,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReservationPage(
                      restaurantName: nombreRestaurante,
                      reservations: reservacion, // Pasa la lista de reservaciones
                      onShowReservations: () {
                        mostrarReservaciones(context); // Muestra la lista de reservaciones
                      }, addReservation: (Reservacion reservation) {  },
                    ),
                  ),
                );
              },
              child: const Text('Realizar Reservación'),
            ),
          ],
        ),
      ),
    );
  }
}
