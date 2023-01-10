
import 'package:fl_peliculas/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier{

  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '7f00212c5491b80eb9395fc7be66a712';
  final String _language = 'es-ES';
  int pagePopulars = 0;

  List<Movie> onDisplayMovies = [];
  List<Movie> onPopularMovies = [];
  Map<int, List<Cast>> listCasting = {};

  MoviesProvider(){
    getOnDisplayMovies();
    getOnPopularMovies();
  }


  Future<String> _getDataApi (String endpoint, [int? page = 1]) async {
       var url =
      Uri.https(_baseUrl, endpoint, {
        'api_key': _apiKey,
        'language': _language,
        'page' : '$page'
        });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async{
    
    var response  = await _getDataApi('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(response);
        
    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getOnPopularMovies() async{
    pagePopulars++;
    var response  = await _getDataApi('3/movie/popular', pagePopulars);
    final popularResponse = PopularResponse.fromJson(response);
        
    onPopularMovies = [...onPopularMovies, ...popularResponse.results];
    notifyListeners();
  }

   Future<List<Cast>> getCastingMovie(int idMovie) async{

    if(listCasting.containsKey(idMovie)) {
      return listCasting[idMovie]!;
    }

    var response  = await _getDataApi('3/movie/$idMovie/credits');
    final castingResponse = CastingResponse.fromJson(response);
        
    listCasting[idMovie] = castingResponse.cast;

    return castingResponse.cast;
  }
}