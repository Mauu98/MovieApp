import 'package:flutter/material.dart';
import 'package:movies_app/providers/MoviesProviders.dart';
import 'package:movies_app/search/SearchDelegate.dart';
import 'package:movies_app/widgets/Widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProviders = Provider.of<MoviesProvider>(
        context); //El listen le dice al widget que se redibuje cuando haya un cambio.
    print(moviesProviders.getOnDisplayMovies());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Movies in Cinema"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: MovieSearchDelegate()),
              icon: const Icon(Icons.search))
        ],
      ),
      body: SingleChildScrollView(
        //Permite hacer scroll
        child: Column(
          children: [
            //Tarjetas principales
            CardSwiper(movies: moviesProviders.onDisplayMovies),

            //Sliders de peliculas
            MovieSlider(
                movies: moviesProviders.popularMovies,
                title: 'Populars',
                onNextPage: () => moviesProviders.getPopularMovies())
          ],
        ),
      ),
    );
  }
}
