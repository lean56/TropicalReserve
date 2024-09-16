import 'package:flutter/material.dart';
import 'package:myapp/pages/select_restaurant_page.dart';

// Modelo de Reservación
class Reservation {
  final String nombreRestaurante;
  final String nombre;
  final String num_persona;
  final String horario;
  final int capacidades;

  Reservation({
    required this.nombreRestaurante,
    required this.nombre,
    required this.num_persona,
    required this.horario,
    required this.capacidades,
  });
}

// Lista global de reservaciones
final List<Reservation> globalList = [];

// Capacidad máxima por restaurante
final Map<String, int> capacidadMaxima = {
  'Ember': 3,
  'Zao': 4,
  'Grappa': 2,
  'Larimar': 3,
};

// Método para verificar si un restaurante tiene disponibilidad en un horario específico
bool isRestaurantAvailable(String restaurantName, String horario) {
  int capacidadMaximaRestaurante = capacidadMaxima[restaurantName] ?? 0;
  int capacidadActual = 1;

  for (var reservacion in globalList) {
    if (reservacion.nombreRestaurante == restaurantName &&
        reservacion.horario == horario) {
      capacidadActual++;
    }
  }

  return capacidadActual < capacidadMaximaRestaurante;
}

// Método para verificar la disponibilidad en todos los horarios
String checkAvailability(String restaurantName) {
  final List<String> horarios = ['6-8 P.M.', '8-10 P.M.'];
  String availability = '';
  for (var horario in horarios) {
    availability += '$horario: ${isRestaurantAvailable(restaurantName, horario) ? "Disponible" : "No disponible"}\n';
  }
  return availability;
}

// Pantalla para mostrar la disponibilidad de los restaurantes
class AvailabilityScreen extends StatelessWidget {
  final String restaurantName;

  AvailabilityScreen({required this.restaurantName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disponibilidad para $restaurantName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Disponibilidad:\n${checkAvailability(restaurantName)}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla para realizar reservaciones
class ReservationPage extends StatefulWidget {
  final String restaurantName;

  ReservationPage({required this.restaurantName});

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

  // Método para realizar la reservación
  void realizarReservacion() {
    int capacidadRestaurante = capacidadMaxima[widget.restaurantName] ?? 0;

    // Verificar disponibilidad antes de agregar la reservación
    if (!isRestaurantAvailable(widget.restaurantName, dropdownHorario)) {
      setState(() {
        _errorText = 'Capacidad máxima alcanzada. No se pueden reservar más mesas en este horario.';
      });
      return;
    }

    // Comprobar si el nombre está vacío
    if (_inputText.isEmpty) {
      setState(() {
        _errorText = 'Por favor ingrese un nombre';
      });
      return;
    }

    // Si hay disponibilidad y el nombre no está vacío, crear la reservación
    setState(() {
      _errorText = '';
      final reservacion = Reservation(
        nombreRestaurante: widget.restaurantName,
        nombre: _inputText,
        num_persona: dropdownValue,
        horario: dropdownHorario,
        capacidades: capacidadRestaurante,
      );

      // Agregar la reservación a la lista global
      globalList.add(reservacion);

      // Mostrar un diálogo de confirmación
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmación de Reservación'),
            content: Text('Reservación confirmada:\n'
                '${reservacion.nombreRestaurante}\n'
                '${reservacion.nombre}\n'
                '${reservacion.num_persona}\n'
                '${reservacion.horario}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _controller.clear();
                  _inputText = '';
                  setState(() {});
                },
                child: Text('Agregar más reservas'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  mostrarReservaciones(); // Navega a la pantalla de reservas
                },
                child: Text('Ver Reservaciones'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text('Cancelar'),
              ),
            ],
          );
        },
      );
    });
  }

  // Navegar a la pantalla de reservaciones
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AvailabilityScreen(
                      restaurantName: widget.restaurantName,
                    ),
                  ),
                );
              },
              child: const Text('Mostrar Disponibilidad'),
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
                  title: Text(reservation.nombreRestaurante),
                  subtitle: Text(
                    'Nombre: ${reservation.nombre}\n'
                    'Número de personas: ${reservation.num_persona}\n'
                    'Horario: ${reservation.horario}',
                  ),
                  isThreeLine: true,
                );
              },
            ),
    );
  }
}

// Pantalla principal para la visualización de los restaurantes
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
        title: Center(child: Text('Restaurantes')),
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
                      nombreRestaurante: restaurantNames[index], reservacion: [],
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
                  const SizedBox(height: 10),
                  Text(
                    checkAvailability(restaurantNames[index]),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.red,
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
