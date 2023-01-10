import 'package:fl_peliculas/providers/movies_provider.dart';
import 'package:flutter/material.dart';
import 'package:fl_peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cine'),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.search_off_outlined))
        ],),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(movies: moviesProvider.onDisplayMovies ),
            MovieSlider(
              movies: moviesProvider.onPopularMovies ,
              onNextPage: () => moviesProvider.getOnPopularMovies(),
              title: 'Populares'
            )
          ],
          ),
      )
    );
  }
}