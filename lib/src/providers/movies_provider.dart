import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:movies/src/models/actor_model.dart';
import 'package:movies/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

import '../models/movie_model.dart';

class MoviesProvider {
  String _apiKey = '8138fcfa70221f83ec122fda5001b848';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _isLoading = false;

  List<Movie> _populars = new List();

  //REMINDER: permite que muchos escuchen este stream
  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  //REMINDER el fuction es opcional, el editor te ayuda más
  Function(List<Movie>) get popularSink => _popularsStreamController.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  void disposeStreams() {
    //REMINDER: se ejecuta si el stream tiene algún dato
    _popularsStreamController?.close();
  }

  Future<List<Movie>> _processAnswer(Uri url) async {
    final res = await http.get(url);

    final data = json.decode(res.body);

    final movies = Movies.fromJsonList(data['results']);

    return movies.items;
  }

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    return await _processAnswer(url);
  }

  Future<List<Movie>> getPopulars() async {
    if (_isLoading) {
      return [];
    }

    _isLoading = true;

    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularesPage.toString(),
    });

    final res = await _processAnswer(url);

    _populars.addAll(res);

    popularSink(_populars);

    _isLoading = false;

    return res;
  }

  Future<List<Actor>> getCast(String movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/credits',
        {'api_key': _apiKey, 'language': _language});

    final resp = await http.get(url);

    // log(url.toString());

    final decodedData = json.decode(resp.body);
    final cast = new Cast.fromJsonListMap(decodedData['cast']);

    return cast.actorList;
  }

  Future<List<Movie>> searchMovie(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});

    return await _processAnswer(url);
  }
}
