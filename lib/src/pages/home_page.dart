import 'package:flutter/material.dart';
import 'package:peliculas_app/src/providers/cartelera_provider.dart';
import 'package:peliculas_app/src/widgets/card_swiper.dart';
import 'package:peliculas_app/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  final carteleraProvider = new CarteleraProvider();

  @override
  Widget build(BuildContext context) {
    carteleraProvider.getPopulares();

    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en cines'),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: (){}
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _swiperTarjetas(),
            _footer(context)
          ],
        )
      ),
    );
  }

  Widget _swiperTarjetas() {

      return FutureBuilder(
          future:  carteleraProvider.getEnCines(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot){
            if(snapshot.hasData){
              return CardSwiper(
                  peliculas: snapshot.data
              );
            }else{
              return Container(
                  height: 400.0,
                  child: Center(
                      child: CircularProgressIndicator()
                  )
              );
            }
          }
      );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Populares', style: Theme.of(context).textTheme.subtitle1,)),
          SizedBox(height: 5.0),

          StreamBuilder(
              stream: carteleraProvider.popularesStream,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot){
                if(snapshot.hasData){
                  return MovieHorizontal(
                    peliculas: snapshot.data,
                    siguientePagina: carteleraProvider.getPopulares,
                  );
                }else{
                  return Center(child: CircularProgressIndicator());
                }
              }
          )
        ],
      ),
    );
  }
}
