import 'package:flutter/material.dart';

class MovieSearch extends SearchDelegate {

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
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }

}