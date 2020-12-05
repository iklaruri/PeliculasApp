class Actores{
  List<Actor> items = new List();

  Actores.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;

    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      items.add(actor);
    });

  }
}


class Actor {
  int id, castId, genero, orden;
  String personaje, idCredito, nombre, perfilImg;

  Actor({
    this.id,
    this.castId,
    this.genero,
    this.orden,
    this.personaje,
    this.idCredito,
    this.nombre,
    this.perfilImg
  });

  Actor.fromJsonMap(Map<String, dynamic> json){
    id = json['id'];
    castId = json['cast_id'];
    genero = json['gender'];
    orden = json['order'];
    personaje = json['character'];
    idCredito = json['credit_id'];
    nombre = json['name'];
    perfilImg = json['profile_path'];
  }

  getPerfilImg(){
    if(perfilImg == null){
      return 'https://bizraise.pro/wp-content/uploads/2014/09/no-avatar-300x300.png';
    }else {
      return 'https://image.tmdb.org/t/p/w500/$perfilImg';
    }
  }
}