import 'package:flutter/material.dart';

const List<String> list = <String>['1 Persona', '2 Personas', '3 Personas', '4 Personas'];
const List<String> list_hora = <String>['6-8 P.M.', '8-10 P.M.'];

void main() => runApp(const Reservation());

class Reservation extends StatelessWidget {
  const Reservation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('')),
        body: const Center(
          child: ReservationForm(),
        ),
      ),
    );
  }
}

class ReservationForm extends StatefulWidget {
  const ReservationForm({super.key});

  @override
  State<ReservationForm> createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  TextEditingController _controller = TextEditingController();
  String _inputText = '';
  String _errorText = '';
  String dropdownValue = list.first;
  String dropdownHorario = list_hora.first;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Campo de texto para el nombre
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Ingrese su nombre',
                errorText: _errorText.isEmpty ? null : _errorText,
              ),
              textAlign: TextAlign.center,
              onChanged: (value) {
                setState(() {
                  _inputText = value;
                });
              },
            ),
            const SizedBox(height: 20),

            // Label y DropdownButton centrados
            const Text(
              'Cantidad de personas',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Menú desplegable centrado
            DropdownButton<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
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

            // Label y DropdownButton centrados
            const Text(
              'Horario',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            // Menú desplegable centrado
            DropdownButton<String>(
              value: dropdownHorario,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.deepPurple),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent,
              ),
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

            // Botón para confirmar reservación
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_inputText.isEmpty) {
                    _errorText = 'Por favor, ingrese su nombre';
                  } else {
                    _errorText = ''; // Limpiar el mensaje de error si se ingresa texto
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Nombre: $_inputText, Cantidad de personas: $dropdownValue'),
                      ),
                    );
                  }
                });
              },
              child: const Text('Confirmar reservación'),
            ),
          ],
        ),
      ),
    );
  }
}
