import 'package:flutter/material.dart';

import '../models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie> movieList;

  final Function nextPage;

  MovieHorizontal({@required this.movieList, @required this.nextPage });


  final _pageController = PageController(
      initialPage: 1,
      viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {

      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent - 100) {
        nextPage();
      }

    });

    //PageView.builder es mejor para celulares de bajo rendimiento
    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
//        children: _cards(context)),
      itemCount: movieList.length,
        itemBuilder: ( context, i ) => _card(context, movieList[i])
      )
    );
  }

  Widget _card(BuildContext context, Movie movie){
    final Container movieCard =  Container(
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

    return GestureDetector(
      child: movieCard,
      onTap: () {
        Navigator.pushNamed(context, "detail", arguments: movie);
      },
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
