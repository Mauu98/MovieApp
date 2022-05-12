import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/models/Models.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({Key? key, required this.movies}) : super(key: key);

  //* El context sabe como esta relacionado cada widget y que va antes o despues de cada cosa.

  @override
  Widget build(BuildContext context) {
    //Widget para facilitar informacion de la plataforma en la que esta corriendo la app.
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height:
          size.height * 0.5, //Obtengo la mitad de la resolucion de la pantalla.
      child: Swiper(
          itemCount: movies.length, //Cantidad de tarjetas que voy a manejar
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.4,
          itemBuilder: (_, int index) {
            final movie = movies[index];

            movie.heroId = 'swiper-${movie.id}';

            return GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'details',
                  arguments:
                      movie), //Al hacer click se redirige hacia otra pantalla.
              child: Hero(
                //Hero animation
                tag: movie.heroId!, //El tag debe ser unico
                child: ClipRRect(
                  //Le da un diseño redondeado a los carteles
                  borderRadius: BorderRadius.circular(20),
                  child: FadeInImage(
                    placeholder: const AssetImage('assets/images/no-image.jpg'),
                    image: NetworkImage(movie.getPosterImg),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ); //Animacion al momento de cargar las imagenes
          }),
    );
  }
}
