import 'package:flutter/material.dart';

class MovieSearch extends SearchDelegate {

  String selected = '';
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

    final listSuggested = query.isEmpty ? recets : movies.where((m) => m.toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemCount: listSuggested.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listSuggested[i]),
          onTap: () {
            selected = listSuggested[i];
            showResults(context);
          }
        );
      },
    );
  }

}