import 'package:Qaeat/Custom_Widgets/export_file.dart';

class NotificationModel{
  int id;
  int sender_salon_id;
  String title;
  String time;
  String message;
  Halls hall;
NotificationModel({this.id,this.sender_salon_id,this.title, this.time,this.message,this.hall});

factory NotificationModel.fromJson(Map<String, dynamic> json){
  return NotificationModel(
    id: json['id'],
    sender_salon_id: json['sender_salon_id'],
    title: json['title'],
    time: json['time'],
    message: json['message'],
    hall : Halls.fromJson(json['salon']),
  );
}


}

class Halls{
  int id;
  String name;

  Halls({this.id,this.name});

  factory Halls.fromJson(Map<String,dynamic> parsedJson){
    if (parsedJson == null) {} else {
      return Halls(
        id: parsedJson['id'],
        name: parsedJson['name'],

      );
    }
  }
}
