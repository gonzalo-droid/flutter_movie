import 'package:flutter/material.dart';
import 'package:flutter_movie/src/models/movies_model.dart';
// import 'package:flutter_movie/src/pages/home_page.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movies;

  // enviada desde HomePage
  final Function nextPage;

  MovieHorizontal({@required this.movies, @required this.nextPage});

  final _pageController = new PageController(
      initialPage: 1, //inicia pag 1
      viewportFraction: 0.3 // 0.3 de 1.0
      );

  @override
  Widget build(BuildContext context) {
    //20% del screen
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.3,

      //pageview carga todo los datos obtenidos, ocasiona problemas de memoria
      //pageview.buildar carga los datos segun sean requeridos
      child: PageView.builder(
        pageSnapping: false, //efecto de pegado dessactivado
        controller: _pageController,
        // children: _cards(context),//es aceptado en PageVie()
        itemCount: movies.length, // tamaño dinamico segun la cantidad de datos
        itemBuilder: (BuildContext context, int index) => _createdCard(context, movies[index]),
      ),
    );
  }

  Widget _createdCard(BuildContext context, Movie movie) {
    final card = Container(
      // margin: EdgeInsets.only(right: 15.0),
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
          SizedBox(
            height: 10.0,
          ),
          Text(movie.title,
              overflow: TextOverflow.ellipsis, // pone los ...
              style: Theme.of(context).textTheme.caption),
        ],
      ),
    );


    return GestureDetector(
      onTap: (){
        // print(movie.title);
        Navigator.pushNamed(context, 'detail', arguments: movie);
      },
      child: card,
    );
  }


  // List<Widget> _cards(BuildContext context) {
  //   return movies.map((movie) {
      
  //   }).toList();
  // }
}
