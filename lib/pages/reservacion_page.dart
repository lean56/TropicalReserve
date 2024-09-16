import 'package:flutter/material.dart';
import '../lista_global.dart';
import 'package:quickalert/quickalert.dart';

// Modelo de Reservación
class Reservacion {
  final String nombreRestaurante;
  final String nombre;
  final String num_persona;
  final String horario;
  final int capacidades;

  Reservacion({
    required this.nombreRestaurante,
    required this.nombre,
    required this.num_persona,
    required this.horario,
    required this.capacidades,
  });
}

// Capacidad máxima por restaurante
final Map<String, int> capacidadMaxima = {
  "Ember": 3,
  "Zao": 4,
  "Grappa": 2,
  "Larimar": 3
};

// Pantalla para realizar reservaciones
class ReservationPage extends StatefulWidget {
  final String restaurantName;

  const ReservationPage({super.key, required this.restaurantName, required List<Reservacion> reservations, required Null Function() onShowReservations, required Null Function(Reservacion reservation) addReservation});

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

  // Verificar si un restaurante tiene disponibilidad en un horario 
  bool verificarDisponibilidad(String restaurante, String horario) {
    int capacidadMaximaRestaurante = capacidadMaxima[restaurante] ?? 0;
    int capacidadActual = 0;

    for (var reservacion in listaGlobal) {
      if (reservacion.nombreRestaurante == restaurante &&
          reservacion.horario == horario) {
          capacidadActual++;
      }
    }
    return capacidadActual < capacidadMaximaRestaurante;
  }

  // Método para realizar la reservación
  void realizarReservacion() {
    int capacidadRestaurante = capacidadMaxima[widget.restaurantName] ?? 0;

    // Verificar disponibilidad antes de agregar la reservación
    if (!verificarDisponibilidad(widget.restaurantName, dropdownHorario)) {
      setState(() {
       // _errorText = 'Capacidad máxima alcanzada. No se pueden reservar más mesas en este horario.';
        _controller.clear();
        AlertError();
      });
      return;
    }

    if (_inputText.isEmpty) {
      setState(() {
        _errorText = 'Por favor ingrese su nombre';
      });
      return;
    }

    setState(() {
      _errorText = '';
      final reservacion = Reservacion(
        nombreRestaurante: widget.restaurantName,
        nombre: _inputText,
        num_persona: dropdownValue,
        horario: dropdownHorario,
        capacidades: capacidadRestaurante,
      );

      // Agregar la reservación a la lista global
      listaGlobal.add(reservacion);
      AlertSuccess(); 
      _controller.clear(); // limpiar campo de texto

    });
  }

 // Mostrar una alerta de exito
  void AlertSuccess(){
   QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: '',
      text: '¡Reservacion realizada con exito!',
      autoCloseDuration: const Duration(seconds: 3),
      showConfirmBtn: false,
    );
  }

  void AlertError(){
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: '',
      text: 'Capacidad máxima alcanzada. No se pueden reservar más mesas en este horario.',
      autoCloseDuration: const Duration(seconds: 6),
      showConfirmBtn: false,
    );
  }

  // Navegar a la pantalla de reservaciones
  void mostrarReservaciones() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReservationsListScreen(
          reservations: listaGlobal, // Pasa la lista global a la pantalla de reservas
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
              child: const Text('Ver Reservaciones'),
            ),
          ],
        ),
      ),
    );
  }
}

// Pantalla para mostrar la lista de reservaciones
class ReservationsListScreen extends StatelessWidget {
  final List<Reservacion> reservations;

  const ReservationsListScreen({super.key, required this.reservations});

  @override
  Widget build(BuildContext context) {
    // Agrupamos las reservaciones por restaurante
    final groupedReservations = <String, Map<String, List<Reservacion>>>{};

    for (var reservacion in reservations) {
      if (!groupedReservations.containsKey(reservacion.nombreRestaurante)) {
        groupedReservations[reservacion.nombreRestaurante] = {};
      }

      var restaurantReservations = groupedReservations[reservacion.nombreRestaurante]!;

      if (!restaurantReservations.containsKey(reservacion.horario)) {
        restaurantReservations[reservacion.horario] = [];
      }

      restaurantReservations[reservacion.horario]!.add(reservacion);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Reservaciones'),
      ),
      body: ListView.builder(
        itemCount: groupedReservations.keys.length,
        itemBuilder: (context, index) {
          String nombre_restaurante = groupedReservations.keys.elementAt(index);
          var restaurantReservations = groupedReservations[nombre_restaurante]!;

          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ExpansionTile(
              title: Text(nombre_restaurante),
              children: restaurantReservations.keys.map((timeSlot) {
                List<Reservacion> horario = restaurantReservations[timeSlot]!;

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Horario: $timeSlot',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      ...horario.map((reservation) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(
                            'Nombre: ${reservation.nombre}\n'
                            'Número de personas: ${reservation.num_persona}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        );
                      }).toList(),
                      const Divider(),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
