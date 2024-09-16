import 'package:flutter/material.dart';
import 'package:myapp/lista_global.dart';
import 'package:myapp/pages/reservacion_page.dart';

class DisponibilidadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Disponibilidad de Restaurantes'),
      ),
      body: ListView.builder(
        itemCount: capacidadMaxima.keys.length,
        itemBuilder: (context, index) {
          String restaurantName = capacidadMaxima.keys.elementAt(index);
          return Card(
            child: ListTile(
              title: Text(restaurantName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '6-8 P.M.: ${isRestaurantAvailable(restaurantName, '6-8 P.M.') ? 'Disponible' : 'No disponible'}',
                    style: TextStyle(
                      color: isRestaurantAvailable(restaurantName, '6-8 P.M.') ? Colors.green : Colors.red,
                    ),
                  ),
                  Text(
                    '8-10 P.M.: ${isRestaurantAvailable(restaurantName, '8-10 P.M.') ? 'Disponible' : 'No disponible'}',
                    style: TextStyle(
                      color: isRestaurantAvailable(restaurantName, '8-10 P.M.') ? Colors.green : Colors.red,
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

  bool isRestaurantAvailable(String restaurantName, String horario) {
    int capacidadMaximaRestaurante = capacidadMaxima[restaurantName] ?? 0;
    int capacidadActual = 0;

    for (var reservacion in listaGlobal) {
      if (reservacion.nombreRestaurante == restaurantName &&
          reservacion.horario == horario) {
        capacidadActual += int.parse(reservacion.num_persona.split(' ')[0]);
      }
    }

    return capacidadActual < capacidadMaximaRestaurante;
  }
}
