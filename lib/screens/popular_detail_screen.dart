import 'package:flutter/material.dart';
import 'package:pm2022/models/popular_model.dart';

import '../database/database_movies.dart';

class PopularDetailScreen extends StatefulWidget {
  const PopularDetailScreen({Key? key}):super(key:key);

  @override
  State<PopularDetailScreen> createState() => _PopularDetailScreenState();
}

class _PopularDetailScreenState extends State<PopularDetailScreen> {
  PopularModel? popularModel;
   bool _isFavorited = true;
  DatabaseMovies? _databaseMovies;
  void initState() {
    super.initState();
    _databaseMovies = DatabaseMovies();
  }

  @override
  Widget build(BuildContext context) {
    popularModel = ModalRoute.of(context)?.settings.arguments as PopularModel;
     _databaseMovies!.getOne((popularModel?.id).toString()).then((value) {
      if (value > 0) {
        _isFavorited = false;
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('${popularModel!.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //CardMovieTrailer(id: popularModel?.id),
            //CardMovieOverview(overview: popularModel?.overview),
            //CastCard(id: popularModel?.id)
          ]
          ),
      ),
    );
  }
}