






import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:proyectofinalmovil/src/models/news_model.dart';
import 'package:proyectofinalmovil/src/screens/news/news_details.dart';
import 'package:proyectofinalmovil/src/services/api_consumer_service.dart';
import 'package:proyectofinalmovil/src/widgets/custom_widgets.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final _apiConsumer = ApiConsumerService();
  List<NewsModel> _news = [];

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  Future<void> _loadNews() async {
    try{
      final news = await _apiConsumer.getNews();
      await initializeDateFormatting('es_ES', null);
      setState(() {
        _news = news;
      });
    } catch (e) {
      if(!mounted) return;
      showScaffoldMessenger(context, 'Error al cargar noticias: $e',isError:  true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias'),
        backgroundColor: Colors.greenAccent,
      ),

      body: Padding(
        padding: EdgeInsets.only(top: 16),
        child: _buildBody(),
      ),

      bottomNavigationBar: Container(
        height: 17,
        color:Colors.greenAccent,
      ),
    );
  }

  Widget _buildBody() {
    return ListView.builder(
      itemCount: _news.length,
      itemBuilder: (context, index) {
        final noticia = _news[index];
        return listNewsItem(
        noticia.titulo,
        noticia.resumen, 
        noticia.imagen, 
        onTap: () => Navigator.push(
          context,
            MaterialPageRoute(builder: (context) => NewsDetails(news: noticia))
          )
        );
      }
    );
  }
}