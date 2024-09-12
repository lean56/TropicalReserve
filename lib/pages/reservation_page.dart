// reservation_page.dart
import 'package:flutter/material.dart';
import 'package:myapp/globals.dart'; // Solo esta importación es necesaria

// Modelo de Reservación
class Reservation {
  final String restaurantName;
  final String name;
  final String numberOfPeople;
  final String timeSlot;

  Reservation({
     required this.restaurantName,
     required this.name,
     required this.numberOfPeople,
     required this.timeSlot,
  });
}

// Pantalla para realizar reservaciones
class ReservationPage extends StatefulWidget {
  final String restaurantName;

  ReservationPage({ required this.restaurantName,  required Null Function(Reservation reservation) addReservation,  required List reservations});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  final TextEditingController _controller = TextEditingController();
  String _inputText = '';
  String _errorText = '';
  String dropdownValue = '1 Persona';
  String dropdownHorario = '6-8 P.M.';

  final List<String> list = ['1 Persona', '2 Personas', '3 Personas', '4 Personas'];
  final List<String> list_hora = ['6-8 P.M.', '8-10 P.M.'];

  void realizarReservacion() {
    if (_inputText.isEmpty) {
      setState(() {
        _errorText = 'Por favor ingrese un nombre';
      });
    } else {
      setState(() {
        _errorText = '';
        final reservacion = Reservation(
          restaurantName: widget.restaurantName,
          name: _inputText,
          numberOfPeople: dropdownValue,
          timeSlot: dropdownHorario,
        );

        // Accede a la lista global directamente
        globalList.add(reservacion);

        // Mostrar un diálogo de confirmación antes de regresar
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirmación de Reservación'),
              content: Text('Reservación confirmada:\n${reservacion.restaurantName}\n${reservacion.name}\n${reservacion.numberOfPeople}\n${reservacion.timeSlot}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Cierra el diálogo
                    _controller.clear();
                    _inputText = '';
                    setState(() {});
                  },
                  child: Text('Agregar más reservas'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Cierra el diálogo
                    mostrarReservaciones(); // Navega a la pantalla de reservas
                  },
                  child: Text('Ver Reservaciones'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Cierra el diálogo
                    Navigator.pop(context); // Regresa a la pantalla anterior
                  },
                  child: Text('Cancelar'),
                ),
              ],
            );
          },
        );
      });
    }
  }

  void mostrarReservaciones() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReservationsListScreen(
          reservations: globalList, // Pasa la lista global a la pantalla de reservas
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservación en ${widget.restaurantName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Ingrese su nombre',
                errorText: _errorText.isEmpty ? null : _errorText,
              ),
              onChanged: (value) {
                setState(() {
                  _inputText = value;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text('Cantidad de personas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String? value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: list.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('Horario', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: dropdownHorario,
              onChanged: (String? value) {
                setState(() {
                  dropdownHorario = value!;
                });
              },
              items: list_hora.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: realizarReservacion,
              child: const Text('Confirmar reservación'),
            ),
            ElevatedButton(
              onPressed: mostrarReservaciones,
              child: const Text('Ver Reservación'),
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla para mostrar la lista de reservaciones
class ReservationsListScreen extends StatelessWidget {
  final List<Reservation> reservations;

  ReservationsListScreen({required this.reservations});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Reservaciones'),
      ),
      body: reservations.isEmpty
        ? Center(child: Text('No hay reservaciones'))
        : ListView.separated(
            itemCount: reservations.length,
            separatorBuilder: (context, index) => Divider(),
            itemBuilder: (context, index) {
              final reservation = reservations[index];
              return ListTile(
                title: Text(reservation.restaurantName),
                subtitle: Text(
                  'Nombre: ${reservation.name}\n'
                  'Número de personas: ${reservation.numberOfPeople}\n'
                  'Horario: ${reservation.timeSlot}',
                ),
                isThreeLine: true,
              );
            },
          ),
    );
  }
}
