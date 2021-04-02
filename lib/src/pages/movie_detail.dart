import 'package:flutter/material.dart';
import 'package:flutter_movie/src/models/movies_model.dart';

class MovieDetail extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    //recibo argumentos del movie horizonal
    final Movie movie = ModalRoute.of(context).settings.arguments;

    print(movie.title);
    return Scaffold(
      body: Center(child: Text(movie.title),),
    );
  }
}