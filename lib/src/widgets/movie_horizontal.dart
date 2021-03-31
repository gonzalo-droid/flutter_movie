

import 'package:flutter/material.dart';
import 'package:flutter_movie/src/models/movies_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;

  MovieHorizontal({@required this.movies});

  @override
  Widget build(BuildContext context) {
    
    //20% del screen
    final _screenSize  = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView(
        pageSnapping: false, //efecto de pegado dessactivado
        controller: PageController(
          initialPage: 1, //inicia pag 1
          viewportFraction: 0.3 // 0.3 de 1.0
        ),
        children: _cards(context),
      ),
    );
  }

  List<Widget> _cards(BuildContext context) {
    return movies.map((movie){
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                height: 160.0,
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10.0,),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis, // pone los ...
              style: Theme.of(context).textTheme.caption
            ),
          ],
        ),
      );
    }).toList();
  }
}