import 'dart:convert';

import 'package:movies/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apiKey = '8138fcfa70221f83ec122fda5001b848';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Movie>> _processAnswer(Uri url) async {
    final res = await http.get(url);

    final data = json.decode(res.body);

    final movies = Movies.fromJsonList(data['results']);
    // print(movies[0]['title']);

    return movies.items;
  }

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    return await _processAnswer(url);
  }

  Future<List<Movie>> getPopulars() async {
    final url = Uri.https(
        _url, '3/movie/popular', {'api_key': _apiKey, 'language': _language});

    return await _processAnswer(url);
  }
}
