import 'package:flutter/material.dart';
import 'package:flutter_movie/src/models/movies_model.dart';
import 'package:flutter_movie/src/provides/movie_provider.dart';

class DataSearch extends SearchDelegate {
  String selected = '';
  final movieProvider = new MovieProvider();

  final movies = [
    'iron man ',
    'iron man 1',
    'iron man 2',
    'iron man 3',
  ];

  final moviesRecent = ['spiderman', 'super'];

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    // acciones del appbar (cancelar o limpiar)
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = ''; //vaciar el search
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    // icono del buscador de la izquierda
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        //accion de la flecha
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    // crea los resultados q vamos a mostrar
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text('Holas'),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    // sugerencias cuando se escribe
    if (query.isEmpty) return Container();

    return FutureBuilder(
      future: movieProvider.searchMovie(query),
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data; 
          return ListView(
              children: movies.map((movie) {
                movie.uniqueId = '${ movie.id }-search';
            return ListTile(
              leading: Hero(
                tag: movie.uniqueId,
                child: FadeInImage(
                  image: NetworkImage(movie.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
              ),
              title: Text(movie.title),
              subtitle: Text(movie.originalTitle),
              onTap: () {
                close(context, null); //cerrar la bsuqueda
                // movie.uniqueId = '';
                Navigator.pushNamed(context, 'detail', arguments: movie);
              },
            );
          }).toList());
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  //  @override
  //   Widget buildSuggestions(BuildContext context) {
  //   // TODO: implement buildSuggestions
  //   // sugerencias cuando se escribe
  //   final listSuggestion = (query.isEmpty)?moviesRecent:movies.
  //   where((p) =>p.toLowerCase().startsWith(query.toLowerCase())).toList();

  //   return ListView.builder(
  //     itemCount: listSuggestion.length,
  //     itemBuilder: (context,i){
  //       return ListTile(
  //         leading: Icon(Icons.movie),
  //         title: Text(listSuggestion[i]),
  //         onTap: (){
  //           selected = listSuggestion[i];
  //           showResults(context);
  //         },
  //       );
  //     },
  //   );
  // }

}
