import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/actor_model.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'package:peliculas_app/src/providers/cartelera_provider.dart';

class PeliculaDetalle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _crearAppBar(pelicula),
          SliverList(
              delegate: SliverChildListDelegate(
                [
                  SizedBox(height: 10.0),
                  _posterTitulo(pelicula,context),
                  _descripcion(pelicula),
                  _actores(pelicula)
                ]
              )
          )
        ],
      )
    );
  }

  Widget _crearAppBar(Pelicula pelicula) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.black87,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
            pelicula.titulo,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0
            ),
        ),
        background: FadeInImage(
          image: NetworkImage(pelicula.getBackImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _posterTitulo(Pelicula pelicula, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                height: 150.0,
              )
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    pelicula.titulo,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.ellipsis
                ),
                // Text(
                //   pelicula.tituloOriginal,
                //   style: Theme.of(context).textTheme.subtitle2,
                //   overflow: TextOverflow.ellipsis
                // ),
                Row(
                  children: [
                    Icon(Icons.star_border),
                    Text(
                        pelicula.calificacion.toString(),
                        style: Theme.of(context).textTheme.subtitle2
                    )
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 20.0),
      child: Text(
        pelicula.argumento,
        textAlign: TextAlign.justify
      ),
    );
  }

  Widget _actores(Pelicula pelicula) {
    final carteleraProvider = new CarteleraProvider();
    
    return FutureBuilder(
      future: carteleraProvider.getActores(pelicula.id),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        if(snapshot.hasData){
          return _actoresPageView(snapshot.data);
        }else{
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }

  Widget _actoresPageView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
          pageSnapping: false,
          controller: PageController(
              viewportFraction: 0.3,
              initialPage: 1
          ),
          itemCount: actores.length,
          itemBuilder: (context,index) => _actorTarjeta(actores[index])
      ),
    );
  }

  Widget _actorTarjeta(Actor actor){
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getPerfilImg()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.nombre,
            overflow: TextOverflow.ellipsis
          )
        ],
      ),
    );
  }
}


