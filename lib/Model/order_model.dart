import 'package:flutter/foundation.dart';

/*

class OrderModel{
   var id;
   var salon_id;
   var employee_id;
   var address;
   var type;
   var payment;
   var date;
   var time;
   var status;
   var user_id;
   var total_cost;
   var cost;
   var cartTotal;
   var total_bonus;
  Hall hall;
  List<Service> services;
  Employee employee;

  OrderModel({this.id,this.salon_id,this.employee_id,this.address,this.type,this.payment,
    this.date,this.time,this.status,this.user_id,this.total_cost,this.cost,
      this.total_bonus,this.hall,this.services,this.employee,this.cartTotal});

  factory OrderModel.fromJson(Map<String,dynamic> json){
    var list = json['services'] as List;
    List<Service> servicelist = list.map((i)=>Service.fromJson(i)).toList();
    return OrderModel(
      id: json['id'],
      salon_id: json['salon_id'],
      employee_id: json['employee_id'],
      address: json['address'],
      type: json['type'],
      payment: json['payment'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
      user_id: json['user_id'],
      total_cost: json['total_cost'],
      cost: json['cost'],
      cartTotal: (json['cartTotal']==null)?0:json['cartTotal'],
      total_bonus: json['total_bonus'],
      hall: Hall.fromJson(json['salon']),
      employee: Employee.fromJson(json['employee']),
      services: servicelist,
    );
  }


}

class Hall{
  final int id;
  final String name;
  final String logo;
  final String address;
  final String Latitude;
  final String Longitude;
  final int city_id;
  City city;

  Hall({this.id,this.name,this.logo,this.address,this.Longitude,this.Latitude,
    this.city_id,this.city});

  factory Hall.fromJson(Map<String,dynamic>json){
    return Hall(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      address: json['address'],
      Latitude: json['Latitude'],
      Longitude: json['Longitude'],
      city_id: json['city_id'],
      city: City.fromJson(json['city'])
    );
  }
}

class City{
  final int id;
  final String name;
  City({this.id,this.name});
  factory City.fromJson(Map<String,dynamic> json){
    return City(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Service{
  final int service_id;
  final int person_num;
  final String name;
   var price;
  Service({this.service_id, this.person_num, this.name,this.price});
  factory Service.fromJson(Map<String,dynamic> json){
    return Service(
      service_id: json['service_id'],
      person_num: json['person_num'],
      name: json['name'],
      price: json['price'],
    );
  }
}

class Employee{
  final int id;
  final String name;
  Employee({this.id,this.name});
  factory Employee.fromJson(Map<String,dynamic> json){
    if(json==null){
      return null;
    }else{
      return Employee(
        id: json['id'],
        name: json['name'],
      );
    }

  }
}
*/

/*
class OrderModel {
  int id;
  String title;
  String date;
  String time;
  int payment;
  int cost;
  int totalBonus;
  int totalCost;
  String orderPaid;
  int status;
  int hallId;
  int userId;
  String createdAt;
  Null updatedAt;

  OrderModel({this.id,
    this.title,
    this.date,
    this.time,
    this.payment,
    this.cost,
    this.totalBonus,
    this.totalCost,
    this.orderPaid,
    this.status,
    this.hallId,
    this.userId,
    this.createdAt,
    this.updatedAt});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    date = json['date'];
    time = json['time'];
    payment = json['payment'];
    cost = json['cost'];
    totalBonus = json['total_bonus'];
    totalCost = json['total_cost'];
    orderPaid = json['order_paid'];
    status = json['status'];
    hallId = json['hall_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['date'] = this.date;
    data['time'] = this.time;
    data['payment'] = this.payment;
    data['cost'] = this.cost;
    data['total_bonus'] = this.totalBonus;
    data['total_cost'] = this.totalCost;
    data['order_paid'] = this.orderPaid;
    data['status'] = this.status;
    data['hall_id'] = this.hallId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}*/

class OrderModel {
  int id;
  int hallId;
  int payment;
  String date;
  String time;
  int status;
  int userId;
  int totalCost;
  int cost;
  int totalBonus;
  int cartTotal;
  Hall hall;
  List<Services> services;

  OrderModel(
      {this.id,
        this.hallId,
        this.payment,
        this.date,
        this.time,
        this.status,
        this.userId,
        this.totalCost,
        this.cost,
        this.totalBonus,
        this.cartTotal,
        this.hall,
        this.services});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hallId = json['hall_id'];
    payment = json['payment'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    userId = json['user_id'];
    totalCost = json['total_cost'];
    cost = json['cost'];
    totalBonus = json['total_bonus'];
    cartTotal = json['cartTotal'];
    hall = json['hall'] != null ? new Hall.fromJson(json['hall']) : null;
    if (json['services'] != null) {
      services = new List<Services>();
      json['services'].forEach((v) {
        services.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hall_id'] = this.hallId;
    data['payment'] = this.payment;
    data['date'] = this.date;
    data['time'] = this.time;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['total_cost'] = this.totalCost;
    data['cost'] = this.cost;
    data['total_bonus'] = this.totalBonus;
    data['cartTotal'] = this.cartTotal;
    if (this.hall != null) {
      data['hall'] = this.hall.toJson();
    }
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hall {
  int id;
  String name;
  String logo;
  String address;
  String latitude;
  String longitude;
  int cityId;
  City city;

  Hall(
      {this.id,
        this.name,
        this.logo,
        this.address,
        this.latitude,
        this.longitude,
        this.cityId,
        this.city});

  Hall.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    logo = json['logo'];
    address = json['address'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    cityId = json['city_id'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['logo'] = this.logo;
    data['address'] = this.address;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['city_id'] = this.cityId;
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
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

class Services {
  int price;
  String name;
  int serviceId;

  Services({this.price, this.name, this.serviceId});

  Services.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    name = json['name'];
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['name'] = this.name;
    data['service_id'] = this.serviceId;
    return data;
  }
}