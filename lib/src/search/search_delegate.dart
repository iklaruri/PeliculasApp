import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'package:peliculas_app/src/providers/cartelera_provider.dart';

class DataSearch extends SearchDelegate{
  String seleccion = '';
  final carteleraProvider = new CarteleraProvider();
  var peliculas = new List<Pelicula>();

   @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones del AppBar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: (){
            query = '';
          }
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del AppBar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: (){
          close(context, null);
        }
    );
  }

  @override
  Widget buildResults(BuildContext context) {
     return ListView(
         children: peliculas.map((pelicula) {
                  return ListTile(
                    leading: FadeInImage(
                        image: NetworkImage(pelicula.getPosterImg()),
                        placeholder: AssetImage('assets/img/no-image.jpg'),
                        fit: BoxFit.contain
                    ),
                    title: Text(pelicula.titulo),
                    onTap: (){
                      close(context, null);
                      pelicula.uniqueId = '';
                      Navigator.pushNamed(context, 'detalle',arguments: pelicula);
                    },
                  );
                }).toList()
            );
          }


  @override
  Widget buildSuggestions(BuildContext context) {
    // Sugerencia que aparecen al filtrar

    if(query.isEmpty){
      return Container();
    }

    return FutureBuilder(
        future: carteleraProvider.buscarPelicula(query),
        builder: (BuildContext context,AsyncSnapshot<List<Pelicula>> snapshot){
          if(snapshot.hasData){
            peliculas = snapshot.data;
            return ListView(
              children: peliculas.map((pelicula) {
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(pelicula.getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.contain
                  ),
                  title: Text(pelicula.titulo),
                  onTap: (){
                    close(context, null);
                    pelicula.uniqueId = '';
                    Navigator.pushNamed(context, 'detalle',arguments: pelicula);
                  },
                );
              }).toList()
            );
          }else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }
    );

  }
  
}