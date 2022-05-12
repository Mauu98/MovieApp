import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/CreditsResponse.dart';
import 'package:movies_app/providers/MoviesProviders.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {
  final int movieId;

  const CastingCards(this.movieId);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
        future: moviesProvider.getMovieCast(movieId),
        builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              constraints: BoxConstraints(maxWidth: 150),
              height: 180,
              child: CupertinoActivityIndicator(),
            );
          }

          final cast = snapshot.data!;

          return Container(
            margin: EdgeInsets.only(bottom: 30),
            width: double.infinity,
            height: 180,
            child: ListView.builder(
              itemCount: cast.length,
              itemBuilder: (_, int index) => _CastCard(cast[index]),
              scrollDirection: Axis.horizontal,
            ),
          );
        });
  }
}

class _CastCard extends StatelessWidget {
  final Cast actor;

  const _CastCard(this.actor);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,
      child: Column(
        //Va a ser una columna, porque va a estar una foto del personaje, y abajo el nombre del mismo.
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
                image: NetworkImage(actor.fullProfilePath),
                placeholder: const AssetImage('assets/images/no-image.jpg'),
                height: 140,
                width: 100,
                fit: BoxFit.cover),
          ),
          SizedBox(height: 5),
          Text(
            actor.originalName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
