

import 'dart:convert';

import 'package:flutter_movie/src/models/movies_model.dart';

//https://pub.dev/packages/http/install
import 'package:http/http.dart' as http;


class MovieProvider{
  String _apiKey = 'd3f8204ea97bb2fc6f4c7c013c95bf0a';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  //https://developers.themoviedb.org/3/movies/get-now-playing
  Future<List<Movie>> getMovies() async{
    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key':_apiKey,
      'language':_language,
    });

    final response = await http.get(url);

    //decode al json
    final decodeData = json.decode(response.body);

    // print(decodeData);
    final movies = new Movies.fromJsonList(decodeData['results']);

    return movies.items;
  }

}