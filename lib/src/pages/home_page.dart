import 'package:flutter/material.dart';
import 'package:flutter_movie/src/provides/movie_provider.dart';
import 'package:flutter_movie/src/widgets/card_swiper_widget.dart';
import 'package:flutter_movie/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new MovieProvider();

  @override
  Widget build(BuildContext context) {
    // primera llamaada a lista de peliculas
    moviesProvider.getPopulars();

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _swiperCards(),
            _footer(context)
          ],
        ),
      ),
    );
  }

  Widget _swiperCards() {
    // moviesProvider.getMovies();
    // return CardSwiper(movies: [1, 2, 3, 4, 5]);F

    return FutureBuilder(
      future: moviesProvider.getMovies(),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        
        
        if (snapshot.hasData) {
          return CardSwiper(
            movies: snapshot.data,
          );
        } else {
          //cuando no hay infomracion, o esta a la espera del future
          return Container(
            height: 400.0,
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {

    return Container(
      width: double.infinity,
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left:15.0),
            margin: EdgeInsets.only(top:20.0),
            child: Text(
              'Populars',
              style: Theme.of(context).textTheme.subtitle2,
              
               //tema de la aplicacaion
            ),
          ),
          SizedBox(height: 5.0),


          StreamBuilder(
            stream: moviesProvider.popularsStream,
            // initialData: InitialData,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              // snapshot.data?.forEach((element)=>print(element.title));

              if(snapshot.hasData){
                return MovieHorizontal(
                  movies: snapshot.data,
                  nextPage: moviesProvider.getPopulars,
                  );
              }else{
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
