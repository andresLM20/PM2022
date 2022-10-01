import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/popular_model.dart';

class PopularMoviesAPI{
  final URL = 'https://api.themoviedb.org/3/movie/popular?api_key=7184ad6fe5d38d90a0dc261df9c7604b&language=es-MX&page=1';

  Future<List<PopularModel>?> getAllPopular() async{
    final response = await http.get(Uri.parse(URL));
    if(response.statusCode==200){
      var popular = jsonDecode(response.body)['results'] as List;
      List<PopularModel> listPopular = popular.map(
        (movie) => PopularModel.fromJSON(movie)
      ).toList();
      return listPopular;
    }else{
      return null;
    }
  } //Future
} // class