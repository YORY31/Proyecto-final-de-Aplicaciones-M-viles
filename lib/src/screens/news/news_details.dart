






import 'package:flutter/material.dart';
import 'package:proyectofinalmovil/src/helpers/formats.dart';
import 'package:proyectofinalmovil/src/models/news_model.dart';

class NewsDetails extends StatelessWidget {
  final NewsModel news;

  const NewsDetails({
    super.key,
    required this.news
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                news.titulo,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 10),
              Image.network(
                news.imagen,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network('https://s1.significados.com/foto/medio-ambiente-og.jpg');
                },
              ),
              SizedBox(height: 10),
              Text('Fecha y hora: ${dateTimeFormat.format(news.fecha)}'),
              SizedBox(height: 15),
              Text(news.contenido),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 17,
        color:Colors.greenAccent,
      ),
    );
  }
}