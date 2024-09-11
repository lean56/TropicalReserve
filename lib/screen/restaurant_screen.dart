import 'package:flutter/material.dart';
import 'package:myapp/screen/reservation_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RestaurantView(),
    );
  }
}

class RestaurantView extends StatelessWidget {

  final List<String> images = [
    'assets/images/ember.png',
    'assets/images/zao.png',
    'assets/images/grappa.png',
    'assets/images/larimar.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Restaurantes')),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Número de columnas
          mainAxisSpacing: 10.0, // Espacio entre las filas
          crossAxisSpacing: 10.0, // Espacio entre las columnas
          childAspectRatio: 3 / 2, // Relación de aspecto para ajustar el tamaño
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
                    ),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
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
                  ],
                ),
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
  

  const RestaurantDetailScreen({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
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
           
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReservationScreen(),
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

class ReservationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reservación'),
      ),
      body: const Center(
        child: Reservation(),
      ),
    );
  }
}
