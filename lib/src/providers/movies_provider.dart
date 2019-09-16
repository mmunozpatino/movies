import 'dart:convert';

import 'package:movies/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

class MoviesProvider {
  String _apiKey = '8138fcfa70221f83ec122fda5001b848';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  Future<List<Movie>> getNowPlaying() async {

    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language
    });

    final res = await http.get(url);

    final decodedData = json.decode(res.body);

    // print(decodedData['results']);

    final movies= Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }
}
