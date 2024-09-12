import 'package:flutter/material.dart';
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
                      restaurantName: restaurantNames[index],
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
  final String restaurantName;

  const RestaurantDetailScreen({
    Key? key,
    required this.image,
    required this.restaurantName,
  }) : super(key: key);

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
              restaurantName,
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
                      restaurantName: restaurantName,
                      reservations: [], addReservation: (Reservation ) {  }, // Lista de reservaciones inicial vacía
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
