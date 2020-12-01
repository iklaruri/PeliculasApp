import 'package:flutter/material.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';
import 'package:peliculas_app/src/widgets/card_swiper.dart';

class HomePage extends StatelessWidget {
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

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
          children: [
            _swiperTarjetas()
          ],
        )
      ),
    );
  }

  Widget _swiperTarjetas() {

      return FutureBuilder(
          future:  peliculasProvider.getEnCines(),
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
}
