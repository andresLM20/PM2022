import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pm2022/models/cast_model.dart';
import 'package:pm2022/models/popular_model.dart';

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

  Future<List<CastModel>?> getCast(int movie_id) async {
    //NEEDS A VALID API KEY
    var response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$movie_id/credits?api_key=7184ad6fe5d38d90a0dc261df9c7604b&language=en-US'));
    if (response.statusCode == 200) {
      var cast = jsonDecode(response.body)['cast'] as List;
      return cast.map((character) => CastModel.fromMap(character)).toList();
    } else {
      return null;
    }
  } //Future

  Future<String?> getTrailer(int movie_id) async {
    //NEEDS A VALID API KEY
    var response = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$movie_id/videos?api_key=7184ad6fe5d38d90a0dc261df9c7604b&language=en-US'));
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['results'] as List;
      String trailer = "";
      popular.forEach((element) {
        if (element['official'] && element['type'] == "Trailer") {
          trailer = element['key'];
        }
      });
      return trailer;
    } else {
      return "";
    }
  }
} // class