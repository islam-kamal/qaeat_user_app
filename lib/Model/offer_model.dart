/*
class OfferModel{
  String title;
  int salon_id;
  int service_id;
  String discount;
  String banner;
  Salons salons;
  OfferModel({this.title,this.salon_id,this.service_id,this.discount,this.banner,this.salons});

  factory OfferModel.fromJson(Map<String,dynamic> json){
    return OfferModel(
      title: json['title'],
      salon_id: json['salon_id'],
      service_id: json['service_id'],
      discount: json['discount'],
      banner: json['banner'],
      salons: Salons.fromJson(json['salons']),
    );
  }

}


class Salons{
  int id;
  String name;
  String address;
  TotalRate total_rate;
  City city;

  Salons({this.id,this.name,this.address,this.total_rate,this.city});

  factory Salons.fromJson(Map<String,dynamic> parsedJson){

    return Salons(
        id: parsedJson['id'],
        name: parsedJson['name'],
        address: parsedJson['address'],
        total_rate: TotalRate.fromJson(parsedJson['total_rate']),
        city: City.fromJson(parsedJson['city']),

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
*/
class OfferModel {
  String title;
  int hallId;
  String discount;
  String banner;
  Hall hall;

  OfferModel(
      {this.title, this.hallId, this.discount, this.banner, this.hall});

  OfferModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    hallId = json['hall_id'];
    discount = json['discount'];
    banner = json['banner'];
    hall = json['hall'] != null ? new Hall.fromJson(json['hall']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['hall_id'] = this.hallId;
    data['discount'] = this.discount;
    data['banner'] = this.banner;
    if (this.hall != null) {
      data['hall'] = this.hall.toJson();
    }
    return data;
  }
}

class Hall {
  int id;
  String name;
  String address;
  int cityId;
  TotalRate totalRate;
  City city;

  Hall(
      {this.id,
        this.name,
        this.address,
        this.cityId,
        this.totalRate,
        this.city});

  Hall.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    cityId = json['city_id'];
    totalRate = json['total_rate'] != null
        ? new TotalRate.fromJson(json['total_rate'])
        : null;
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['city_id'] = this.cityId;
    if (this.totalRate != null) {
      data['total_rate'] = this.totalRate.toJson();
    }
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    return data;
  }
}

class TotalRate {
  int id;
  int value;
  int hallId;

  TotalRate({this.id, this.value, this.hallId});

  TotalRate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    hallId = json['hall_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['hall_id'] = this.hallId;
    return data;
  }
}

class City {
  int id;
  String name;

  City({this.id, this.name});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}