import 'package:flutter/foundation.dart';

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