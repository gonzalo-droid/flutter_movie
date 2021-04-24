import 'dart:async';
import 'dart:convert';

import 'package:flutter_movie/src/models/actors_model.dart';
import 'package:flutter_movie/src/models/movies_model.dart';

//https://pub.dev/packages/http/install
import 'package:http/http.dart' as http;

class MovieProvider {
  String _apiKey = 'd3f8204ea97bb2fc6f4c7c013c95bf0a';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularsPage = 0;
  bool _loading = false;

  List<Movie> _populars = new List();

  //Steam
  final _popularsStreamController = StreamController<List<Movie>>.broadcast();
  //broadcast muchos lugares escuchando este stream

  // Add dato al stream
  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;

  //escucha datos que emite el stream
  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  //get -> static

   void disposeStreams(){
    // ? valida si hay un stream abierto
    _popularsStreamController?.close();
  }


  Future<List<Movie>> _processResponse(Uri url) async {
    final resp = await http.get(url);
    //decode al json
    final decodeData = json.decode(resp.body);
    // print(decodeData);
    final movies = new Movies.fromJsonList(decodeData['results']);

    return movies.items;
  }

  //https://developers.themoviedb.org/3/movies/get-now-playing
  Future<List<Movie>> getMovies() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
    });
    return _processResponse(url);
  }

  Future<List<Movie>> getPopulars() async {

    if(_loading) return [];

    _loading= true;
    _popularsPage++;

    print('loading next data');

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularsPage.toString(),
    });
    final resp= await  _processResponse(url);

    //add all lista de peliculas
    _populars.addAll(resp);

    popularsSink(_populars);

    _loading= false;

    return resp;
  }

   // Consumir Casting of  movie
   // 
  
  Future<List<Actor>> getCast(String movieId) async{
    final url = Uri.https(_url, '3/movie/$movieId/credits',{
      'api_key' : _apiKey,
      'laguage' : _language,
    });

    final resp = await http.get(url); //esperar la respuesta
    final decodedData = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);
    return cast.actors;

  }

    Future<List<Movie>> searchMovie(String query) async {

    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query,
    });
    return await  _processResponse(url);
  }


}