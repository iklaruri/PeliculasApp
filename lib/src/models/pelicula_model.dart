class Peliculas {
  List<Pelicula> items = new List();
  Peliculas();

  Peliculas.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;

    for(var item in jsonList){
      final pelicula = new Pelicula.fromJsonMap(item);
      items.add(pelicula);
    }
  }
}

class Pelicula {
  int id,votoCantidad;
  bool video,adulto;
  double calificacion,popularidad;
  String uniqueId,titulo,posterPath,idioma,tituloOriginal,backdropPath,argumento,lanzamiento;
  List<int> idGeneros;

  Pelicula({
    this.id,
    this.votoCantidad,
    this.video,
    this.adulto,
    this.calificacion,
    this.popularidad,
    this.titulo,
    this.posterPath,
    this.idioma,
    this.tituloOriginal,
    this.backdropPath,
    this.argumento,
    this.lanzamiento,
    this.idGeneros
  });

  Pelicula.fromJsonMap(Map<String,dynamic> json){
    id = json['id'];
    votoCantidad = json['vote_count'];
    video = json['video'];
    adulto = json['adult'];
    calificacion = json['vote_average'] / 1;
    popularidad = json['popularity'] / 1;
    titulo = json['title'];
    posterPath = json['poster_path'];
    idioma = json['original_language'];
    tituloOriginal = json['original_title'];
    backdropPath = json['backdrop_path'];
    argumento = json['overview'];
    lanzamiento = json['release_date'];
    idGeneros = json['genre_ids'].cast<int>();
  }

  getPosterImg(){
    if(posterPath == null){
      return 'https://lh3.googleusercontent.com/proxy/jgKGZ1-kzvcIQ_mBlShbjogdt9A92Ao9_5PrHKiGzNRS61aJdc942j8AL7XAMjdbbFlCnzXJZjoYke9gM32gDxMQvAoGIJmVfMAiAwEIzLTZ1gRbn5Jd0g1RzQEy4TF9n9nRel1ZXqHdgqiGlALLKj8KGAtaQSz-cqQa9iLOjj63vYapMoeXK2pA3vsTIyXwy5EI-5Y7jipYnTOWZxD6az2DZei0_81efjk9przqcpwTHl22gtqn7u6MjCc9EbY8udH6Kuwtjt88_OwSccNkGdVoH4WMqD_Lgf5zgt6j0ELSjjC_Jq_xEOBWybWMtkSRaGwo1RGDHQpKnQzCPuBZT_auMGe0ixMs5IGaBgv18Kl_--ipQnZOWbjiVfOcu9NDbKOEUedszc99i0lXgqLC28x1BWWBMTTdKoPUOIaA9UlqPVC7z7CoVK-U7lh9_zLOxi1enWCcwP_zHYYNQrt105h1No2bsc5BiD002VJQiwjkog2WLBEbfbk09cueI3TWuLgsq6dIvbhsVAtnFYZiwDIRdE83LNN2lEWv-O4gmegdkhjQ-I4-E-3qErmtPlXrjLOChPg';
    }else {
      return 'https://image.tmdb.org/t/p/w500/$posterPath';
    }
  }

  getBackImg(){
    if(posterPath == null){
      return 'https://lh3.googleusercontent.com/proxy/jgKGZ1-kzvcIQ_mBlShbjogdt9A92Ao9_5PrHKiGzNRS61aJdc942j8AL7XAMjdbbFlCnzXJZjoYke9gM32gDxMQvAoGIJmVfMAiAwEIzLTZ1gRbn5Jd0g1RzQEy4TF9n9nRel1ZXqHdgqiGlALLKj8KGAtaQSz-cqQa9iLOjj63vYapMoeXK2pA3vsTIyXwy5EI-5Y7jipYnTOWZxD6az2DZei0_81efjk9przqcpwTHl22gtqn7u6MjCc9EbY8udH6Kuwtjt88_OwSccNkGdVoH4WMqD_Lgf5zgt6j0ELSjjC_Jq_xEOBWybWMtkSRaGwo1RGDHQpKnQzCPuBZT_auMGe0ixMs5IGaBgv18Kl_--ipQnZOWbjiVfOcu9NDbKOEUedszc99i0lXgqLC28x1BWWBMTTdKoPUOIaA9UlqPVC7z7CoVK-U7lh9_zLOxi1enWCcwP_zHYYNQrt105h1No2bsc5BiD002VJQiwjkog2WLBEbfbk09cueI3TWuLgsq6dIvbhsVAtnFYZiwDIRdE83LNN2lEWv-O4gmegdkhjQ-I4-E-3qErmtPlXrjLOChPg';
    }else {
      return 'https://image.tmdb.org/t/p/w500/$backdropPath';
    }
  }
}