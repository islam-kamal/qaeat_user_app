class FavouriteModel {
  int id;
  int user_id;
  int hall_id;
  Halls halls;

  FavouriteModel({this.id,this.user_id,this.hall_id,this.halls});
  factory FavouriteModel.fromJson(Map<String,dynamic> json){
    return FavouriteModel(
      id: json['id'],
      user_id: json['user_id'],
      hall_id: json['hall_id'],
      halls: Halls.fromJson(json['halls']),
    );
  }

}

class Halls{
  int id;
  String name;
  String address;
  TotalRate total_rate;
  City city;
  List<Gallery> gallery;
  Halls({this.id,this.name,this.address,this.total_rate,this.city,this.gallery});

  factory Halls.fromJson(Map<String,dynamic> parsedJson){
    var list =parsedJson['gallery'] as List;
    List<Gallery> galleryList =list.map((i)=>Gallery.fromJson(i)).toList();
    return Halls(
      id: parsedJson['id'],
      name: parsedJson['name'],
      address: parsedJson['address'],
      total_rate: TotalRate.fromJson(parsedJson['total_rate']),
      city: City.fromJson(parsedJson['city']),
      gallery: galleryList
    );
  }
}

class TotalRate{
  int value;
  TotalRate({this.value});

  factory TotalRate.fromJson(Map<String,dynamic> parsedJson){
    if(parsedJson==null){

    }else{
      return TotalRate(
        value: parsedJson['value'],
      );
    }

  }
}

class City{
  String name;
  City({this.name});
  factory City.fromJson(Map<String,dynamic> parsedJson){
    return City(
      name: parsedJson['name'],
    );
  }
}

class Gallery {
  String photo;
  Gallery({this.photo});
  factory Gallery.fromJson(Map<String,dynamic> parsedJson){
    return Gallery(
      photo: parsedJson['photo'],
    );
  }
}