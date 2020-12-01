import 'dart:convert';

import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider{
  String _apikey = '887f16b8eedac8afd6c306c974158a58';
  String _url = 'api.themoviedb.org';
  String _idioma = 'es-ES';

  Future<List<Pelicula>> getEnCines() async{
      final url = Uri.https(_url, '3/movie/now_playing', {
        'api_key':_apikey,
        'language':_idioma
      });

     final resp = await http.get(url);
     final decodedData = json.decode(resp.body);
     // print(decodedData['results']);
     final peliculas = new Peliculas.fromJsonList(decodedData['results']);

     return peliculas.items;
  }
}