import 'package:flutter/material.dart';
import 'package:Massara/Custom_Widgets/export_file.dart';
import 'package:Massara/View/User_Sign/user_sigin.dart';

class VistorMessage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VistorMessageStatus();
  }
}

class VistorMessageStatus extends State<VistorMessage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage('images/splash_screen/massara_logo.png'),
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 2,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              ' قم بالتسجيل حتى تتمكن من الاستمتاع\n                   بخدمات التطبيق',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          RaisedButton(
            color: MassaraColor.primary_color,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'الدخول الى صفحة التسجيل',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserSignIn()));
            },
          )
        ],
      ),
    );
  }
}
