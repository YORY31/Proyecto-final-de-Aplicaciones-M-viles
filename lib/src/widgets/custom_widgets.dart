// Importa el paquete principal de Flutter para construir widgets personalizados.
import 'package:flutter/material.dart';

/// Muestra un mensaje flotante en la pantalla usando ScaffoldMessenger.
/// El color depende de si es error (rojo) o éxito (verde).
void showScaffoldMessenger(
  BuildContext context,
  String message, {
  bool isError = true,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      action: SnackBarAction(
        label: 'Ok',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}

/// Widget para mostrar un servicio en una lista con icono y acción.
Widget listServiceItem(String title, String icon, {required Function() onTap}) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: ListTile(
      leading: Text(icon), // Icono del servicio.
      title: Text(title), // Título del servicio.
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.greenAccent),
      onTap: onTap, // Acción al tocar el servicio.
    ),
  );
}

Widget listNewsItem(
  String title,
  String? subtitle,
  String image, {
  Color? subtitleColor,
  required Function() onTap,
}) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child: ListTile(
      leading: Image.network(
        image,
        errorBuilder: (context, error, stackTrace) {
          return Image.network(
            'https://s1.significados.com/foto/medio-ambiente-og.jpg',
          );
        },
      ),
      title: Text(title),
      subtitle: subtitle != null
          ? Text(subtitle, style: TextStyle(color: subtitleColor))
          : null,
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.greenAccent),
      onTap: onTap,
    ),
  );
}
