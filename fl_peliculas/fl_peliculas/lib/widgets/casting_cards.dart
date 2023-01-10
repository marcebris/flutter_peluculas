import 'package:fl_peliculas/models/models.dart';
import 'package:fl_peliculas/providers/movies_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CastingCast extends StatelessWidget {
  const CastingCast({
    super.key, 
    required this.movieId
  });

  final int movieId;

  @override
  Widget build(BuildContext context) {

  final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

  return FutureBuilder(
    future: moviesProvider.getCastingMovie(movieId),
    builder: (_, AsyncSnapshot<List<Cast>> snapshot){
      
      if(!snapshot.hasData)
      {
        return Container(
          constraints: const BoxConstraints(maxWidth: 150),
          height: 180,
          child: const CupertinoActivityIndicator(),
        );
      }
      
      final List<Cast> cast =snapshot.data!;

          return Container(
          margin: const EdgeInsets.only(bottom: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                        itemCount: cast.length,
                        itemBuilder: (_, int i) => _CastCard(cast[i])
                      )
        );
     }
    );


  }
}

class _CastCard extends StatelessWidget {
  const _CastCard(this.cast);

  final Cast cast;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(20),
               child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(cast.fullProfilePath),
                  width: 100,
                  height: 140,
                  fit: BoxFit.cover
                ),
             ),
             const SizedBox(height: 5,),
             Text(cast.name,
             maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign:  TextAlign.center)
        ],
      ),
    );
  }
}