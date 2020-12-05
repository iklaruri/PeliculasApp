import 'dart:async';
import 'dart:convert';
import 'package:peliculas_app/src/models/actor_model.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class CarteleraProvider{
  String _apikey = '887f16b8eedac8afd6c306c974158a58';
  String _url = 'api.themoviedb.org';
  String _idioma = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;
  List<Pelicula> _peliculasPopulares = new List();
  final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;
  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> getEnCines() async{
      final url = Uri.https(_url, '3/movie/now_playing', {
        'api_key':_apikey,
        'language':_idioma
      });

      return await _obtenerRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async{
    if(_cargando) return [];

    _cargando = true;

    _popularesPage++;

    //print('Cargando siguiente pagina');

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key':_apikey,
      'language':_idioma,
      'page':_popularesPage.toString()
    });

    final resp = await _obtenerRespuesta(url);

    _peliculasPopulares.addAll(resp);
    popularesSink(_peliculasPopulares);

    _cargando = false;
    return resp;
  }

  Future <List<Pelicula>> _obtenerRespuesta(Uri url) async{
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    // print(decodedData['results']);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Actor>> getActores(int idPelicula) async {
    final url = Uri.https(_url, '3/movie/$idPelicula/credits', {
      'api_key':_apikey,
      'language':_idioma
    });

    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    final actores = new Actores.fromJsonList(decodedData['cast']);

    return actores.items;
  }
}