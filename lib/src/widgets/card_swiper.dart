import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiper({
    @required this.peliculas
  });

  @override
  Widget build(BuildContext context) {

    final _tamanoPantalla = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.only(top:10.0),
      child: Swiper(
        itemWidth: _tamanoPantalla.width * 0.7,
        itemHeight: _tamanoPantalla.height * 0.55,
        layout: SwiperLayout.STACK,
        itemBuilder: (context, index) => _tarjeta(context,peliculas[index]),
        itemCount: peliculas.length
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    final tarjeta = ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: FadeInImage(
            image: NetworkImage(pelicula.getPosterImg()),
            placeholder: AssetImage('assets/img/no-image.jpg'),
            fit: BoxFit.cover
        )
    );

    return GestureDetector(
        child: tarjeta,
        onTap: (){
          print(pelicula.id);
          Navigator.pushNamed(context, 'detalle', arguments: pelicula);
        }
    );
  }
}
