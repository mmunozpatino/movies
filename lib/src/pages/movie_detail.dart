import 'package:flutter/material.dart';
import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:movies/src/providers/movies_provider.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        body: CustomScrollView(
            // slivers es análogo al children de otros widgets!
            slivers: <Widget>[
          _createAppBar(context, movie),
          SliverList(
              delegate: SliverChildListDelegate(<Widget>[
            SizedBox(height: 10.0),
            _titlePoster(context, movie),
            _description(context, movie),
            _createCast(movie)
          ]))
        ]));
  }

  Widget _createAppBar(BuildContext context, Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Theme.of(context).primaryColor,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
            placeholder: AssetImage('assets/img/loading.gif'),
            image: NetworkImage(movie.getBackgroundImage()),
            fadeInDuration: Duration(milliseconds: 150),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget _titlePoster(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            //No usamos fadeInImage porque ya tenemos la foto cargada de la pantalla anterior
            child: Image(
              image: NetworkImage(movie.getPosterImg()),
              height: 150.0,
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.title,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  movie.originalTitle,
                  style: Theme.of(context).textTheme.subhead,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(movie.voteAverage.toString(),
                        style: Theme.of(context).textTheme.subhead)
                  ],
                ),
              ]))
        ],
      ),
    );
  }

  Widget _description(BuildContext context, Movie movie) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Text(
          movie.overview,
          textAlign: TextAlign.justify,
        ));
  }

  Widget _createCast(Movie movie) {
    final MoviesProvider moviesProvider = new MoviesProvider();

    return FutureBuilder(
      future: moviesProvider.getCast(movie.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return _createActorPageView(snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createActorPageView(List<Actor> actorList) {
    //se recomienda usar el PageViewBuilder

    return SizedBox(
        height: 200.0,
        child: PageView.builder(
            pageSnapping: false,
            itemCount: actorList.length,
            controller: PageController(viewportFraction: 0.3, initialPage: 1),
            itemBuilder: (context, i) => _actorCard(actorList[i])));
  }

  Widget _actorCard(Actor actor) {
    return Container(
        child: Column(children: <Widget>[
      ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: FadeInImage(
          image: NetworkImage(actor.getPhoto()),
          placeholder: AssetImage('assets/img/no-image.jpg'),
          height: 150.0,
          fit: BoxFit.cover
        ),
      ),
      Text(
        actor.name,
        overflow: TextOverflow.ellipsis,
      )
    ]));
  }
}
