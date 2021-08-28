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

