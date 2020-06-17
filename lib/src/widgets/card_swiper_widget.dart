import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  CardSwiper({@required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          movies[index].uid = '${movies[index].id}-poster';
          return Hero(
            tag: movies[index].uid,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: GestureDetector(
                  onTap: () {
                    log("hola");
                    Navigator.pushNamed(context, "detail", arguments: movies[index]);
                  },
                  child: FadeInImage(
                    image: NetworkImage(movies[index].getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.cover,
                  ),
                )),
          );
        },
        itemCount: movies.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.6,
        itemHeight: _screenSize.height * 0.5,
      ),
    );
  }
}
