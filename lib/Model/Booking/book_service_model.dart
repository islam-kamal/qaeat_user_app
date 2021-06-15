/*

class BookServiceModel{
  final int id;
  final String name;
  final String icon;
  final int price;
  final int home_service;

  BookServiceModel({this.id, this.name, this.icon, this.price, this.home_service});

  factory BookServiceModel.fromJson(Map<String,dynamic> json){
    return BookServiceModel(
      id:json['id'],
      name: json['name'],
      icon: json['icon'],
      home_service: json['home_service'],
      price: json['price'],

    );
  }
}*/
class BookServiceModel{

  int id;
  String name;
  String details;
  String icon;
  int price;
  String discount;
  int payment;
  int hallId;
  String createdAt;
  String updatedAt;
  BookServiceModel(
      {this.id,
        this.name,
        this.details,
        this.icon,
        this.price,
        this.discount,
        this.payment,
        this.hallId,
        this.createdAt,
        this.updatedAt});

  BookServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    details = json['details'];
    icon = json['icon'];
    price = json['price'];
    discount = json['discount'];
    payment = json['payment'];
    hallId = json['hall_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['details'] = this.details;
    data['icon'] = this.icon;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['payment'] = this.payment;
    data['hall_id'] = this.hallId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}