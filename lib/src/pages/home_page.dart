import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';

import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text('Películas en Cines'),
          // backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperCards(),
            _footer(context)],
        )));
  }


  Widget _swiperCards() {
    // moviesProvider.getNowPlaying();

    return FutureBuilder(
      future: moviesProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(movies: snapshot.data);
        } else {
          return Container( child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
  
  Widget _footer(BuildContext context){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 1.0),
          Container(
            padding: EdgeInsets.only(left: 15.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subhead,)),
          SizedBox(height: 5.0,),
          FutureBuilder(
            future: moviesProvider.getPopulars(),
            // initialData: InitialData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                return MovieHorizontal(movieList: snapshot.data);
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
