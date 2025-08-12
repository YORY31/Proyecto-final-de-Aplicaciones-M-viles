


import 'package:flutter/material.dart';

void showScaffoldMessenger(BuildContext context, String message, {bool isError = true}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      action: SnackBarAction(
        label: 'Ok', 
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }
      ),
    )
  );
}


Widget listServiceItem(String title, String icon, {required Function() onTap}) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child:  ListTile(
        leading: Text(icon),
        title: Text(
          title
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.greenAccent,
        ),
        onTap: onTap,
      ),
  );
}

Widget listNewsItem(String title, String? subtitle, String image, {Color? subtitleColor, required Function() onTap}) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    child:  ListTile(
        leading: Image.network(
          image,
          errorBuilder: (context, error, stackTrace) {
            return Image.network('https://s1.significados.com/foto/medio-ambiente-og.jpg');
          },
        ),
        title: Text(
          title
        ),
        subtitle: subtitle != null ? Text(
          subtitle,
          style: TextStyle(
            color: subtitleColor
          ),
        ) : null,
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.greenAccent
        ),
        onTap: onTap,
      ),
  );
}