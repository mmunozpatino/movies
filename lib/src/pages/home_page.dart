import 'package:flutter/material.dart';
import 'package:movies/src/providers/movies_provider.dart';

import 'package:movies/src/widgets/card_swiper_widget.dart';

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
        children: <Widget>[
          Text('Populares', style: Theme.of(context).textTheme.subhead,),
          FutureBuilder(
            future: moviesProvider.getPopulars(),
            // initialData: InitialData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                for(var movie in snapshot.data){
                  print(movie.title);
                }
                return Text(snapshot.data[0].title);
              }else{
                return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
              }
            },
          ),
        ],
      ),
    );
  }
}
