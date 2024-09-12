import 'package:flutter/material.dart';
import 'package:myapp/pages/reservation_page.dart';

class ReservationsListScreen extends StatelessWidget {
  final List<Reservation> reservations;

  const ReservationsListScreen({Key? key, required this.reservations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Reservaciones'),
      ),
      body: ListView.builder(
        itemCount: reservations.length,
        itemBuilder: (context, index) {
          final reservacion = reservations[index];
          return ListTile(
            title: Text('${reservacion.restaurantName} - ${reservacion.name}'),
            subtitle: Text('Número de personas: ${reservacion.numberOfPeople}\nHorario: ${reservacion.timeSlot}'),
          );
        },
      ),
    );
  }
}
