import 'package:flutter/material.dart';
import 'package:pm2022/network/popular_movies_api.dart';
import '../models/popular_model.dart';

class ListPopularScreen extends StatefulWidget {
  const ListPopularScreen({Key? key}): super(key: key);

  @override
  State<ListPopularScreen> createState() => _ListPopularScreenState();
}

class _ListPopularScreenState extends State<ListPopularScreen> {

  PopularMoviesAPI popularAPI = PopularMoviesAPI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Popular Movies')),
      body: FutureBuilder(
        future: popularAPI.getAllPopular(),
        builder: (BuildContext context,AsyncSnapshot<List<PopularModel>?> snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            return _listViewPopular(snapshot.data);
          }else{
            if(snapshot.hasError){
              return Center(child: Text("Ocurrió un error en la petición."),);
            }else{
              return Center(child: CircularProgressIndicator(),);
            }
          }
        
        },
      ),
    );
  }

  Widget _listViewPopular(List<PopularModel>? snapshot){
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(color: Colors.black),
      padding: EdgeInsets.all(10),
      itemCount: snapshot!.length,
      itemBuilder: (context, index){
      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
          child: FadeInImage(
            fadeInDuration: Duration(milliseconds: 500),
            placeholder: AssetImage('assets/loading_movie.gif'),
            image: NetworkImage('https://image.tmdb.org/t/p/w500/${snapshot[index].backdropPath!}'),
          ),
      );
    },
  );
}
}