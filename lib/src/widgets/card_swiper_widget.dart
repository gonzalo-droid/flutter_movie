import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
//https://pub.dev/packages/flutter_swiper/install

class CardSwiper extends StatelessWidget {
  //recibe lista de peliculas
  final List<dynamic> movies;

  //parametro requerido
  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    //responsive design
    final _screeSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Swiper(
        itemCount: movies.length,
        itemWidth: _screeSize.width * 0.7, // 70% del ancho
        itemHeight: _screeSize.height * 0.5, // 50% del ancho
        layout: SwiperLayout.STACK,
        itemBuilder: (BuildContext context, int index) {
          //border redondeados
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              "https://picsum.photos/500/300/?image=12",
              fit: BoxFit.cover,
            ),
          );
        },

        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }
}