import 'package:flutter/material.dart';
import 'package:flutter_movie/src/provides/movie_provider.dart';
import 'package:flutter_movie/src/widgets/card_swiper_widget.dart';




class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Movie Home'),
        backgroundColor: Colors.indigoAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),

      //para evitar que la parte superio sea ocultada por el modelo del celular
      // body: SafeArea(
      //   child: Text('Holis'),
      // ),

      body: Container(
        child: Column(
          children: [_swiperCards()],
        ),
      ),
    );
  }

  Widget _swiperCards() {

    final moviesProvider = new MovieProvider();
    moviesProvider.getMovies();

    return CardSwiper(movies: [1,2,3,4,5]);
  }
}
