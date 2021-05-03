class ServiceModel {
  int id;
  String name;
  String icon;
  int home_service;
  ServiceModel({this.id, this.name, this.icon, this.home_service});

  factory ServiceModel.fromJson(Map<String, dynamic> json){
    return ServiceModel(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      home_service: json['home_service']
    );
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['home_service'] = this.home_service;
    return data;

  }
}

class Autogenerated {
  bool status;
  String errNum;
  String msg;
  List<Services> services;

  Autogenerated({this.status, this.errNum, this.msg, this.services});

  Autogenerated.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    if (json['services'] != null) {
      services = new List<Services>();
      json['services'].forEach((v) {
        services.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  String name;
  String icon;
  int homeService;

  Services({this.name, this.icon, this.homeService});

  Services.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
    homeService = json['home_service'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['home_service'] = this.homeService;
    return data;
  }
}