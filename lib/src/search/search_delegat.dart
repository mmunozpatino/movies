import 'package:flutter/material.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';

class MovieSearch extends SearchDelegate {

  String selected = '';

  final moviesProvider = new MoviesProvider();

  final movies = [
    'movie 1',
    'movie 2',
    'movie 3', 
    'movie 4',
    'movie 5',
    'movie 6'
  ];

  final recets = [
    'reciente 1',
    'reciente 2'
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones del appBar! (icono para limpiar el texto por ejemplo)

    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la izq del appbar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow, 
        progress: transitionAnimation,
      ), 
      onPressed: () {
        close(context,null);
      }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.deepPurpleAccent,
        child: Text(selected)
      )
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    //V1
    // final listSuggested = query.isEmpty ? recets : movies.where((m) => m.toLowerCase().startsWith(query.toLowerCase())).toList();

    // return ListView.builder(
    //   itemCount: listSuggested.length,
    //   itemBuilder: (context, i) {
    //     return ListTile(
    //       leading: Icon(Icons.movie),
    //       title: Text(listSuggested[i]),
    //       onTap: () {
    //         selected = listSuggested[i];
    //         showResults(context);
    //       }
    //     );
    //   },
    // );

    if(query.isEmpty) return Container();

    return FutureBuilder(
      future: moviesProvider.searchMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if( snapshot.hasData ){
          return ListView(
            children: snapshot.data.map((movie) {
              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'), 
                  image: NetworkImage(movie.getPosterImg()),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(movie.title),
                subtitle: Text(movie.originalTitle),
                onTap: () {
                  close(context,null);
                  movie.uid = movie.id.toString();
                  Navigator.pushNamed(context, 'detail', arguments: movie);
                }
              ); 
            }).toList(),
          );
        } else {
          return Center(
            child: CircularProgressIndicator()
          );
        }
      }
    );
  }

}