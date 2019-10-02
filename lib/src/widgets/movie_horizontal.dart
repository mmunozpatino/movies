import 'package:flutter/material.dart';

import '../models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movieList;

  MovieHorizontal({@required this.movieList});
  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      height: _screenSize.height * 0.3,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3
        ),
        children: _cards(context)),
    );
  }

  List<Widget> _cards(context) {
    final _screenSize = MediaQuery.of(context).size;

    return movieList.map((movie) {
      return Container(
          margin: EdgeInsets.only(right: 15.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(movie.getPosterImg()),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 150.0,
                ),
              ),
              SizedBox(height: 5.0,),
              Text(
                movie.title,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: Theme.of(context).textTheme.caption,
              )
            ],
          ));
    }).toList();
  }
}
