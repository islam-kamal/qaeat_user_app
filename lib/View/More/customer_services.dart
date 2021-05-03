import 'package:flutter/material.dart';
import 'package:Massara/Custom_Widgets/export_file.dart';
import 'package:Massara/Model/customer_services_model.dart';

class CustomerServices extends StatefulWidget {
  final String token;
  final int user_id;
  final int ticket_number;
  final String ticket_details;
  CustomerServices(
      {this.token, this.user_id, this.ticket_number, this.ticket_details});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomerServices_state();
  }
}

class CustomerServices_state extends State<CustomerServices> {
  SharedPreferences sharedPrefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      sharedPrefs = prefs;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'الدعم الفنى',
            style: TextStyle(
              fontFamily: 'Cairo',
              color: Color(0xFFFFFFFF),
            ),
          ),
          backgroundColor: MassaraColor.primary_color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFFFFFFFF),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MorePage()));
            },
          ),
        ),
        body: FutureBuilder<CustomerServicesModel>(
          future: ApiProvider.getSupportTicket(
              widget.token, widget.user_id, context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(top: 20),
                            child: Column(
                              children: <Widget>[
                                Image(
                                  image: AssetImage('images/more/correct.png'),
                                  color: MassaraColor.primary_color,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'تم ارسال شكوتك بنجاح ويتم مراجعتها\nوالتواصل معك فى اقرب وقت شكرا لك',
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(right: 20, left: 20, top: 30),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF6F6F6),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          child: Text(
                                            '${snapshot.data.ticket_num}',
                                            style:
                                                TextStyle(fontFamily: 'Cairo'),
                                          ),
                                          margin: EdgeInsets.only(
                                              right: 10, left: 10),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Text(
                                            'رقم الشكوى',
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontWeight: FontWeight.bold),
                                            textDirection: TextDirection.rtl,
                                          ),
                                          margin: EdgeInsets.only(
                                              right: 10, left: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF6F6F6),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          child: Text(
                                            '${snapshot.data.status == 0 ? 'يتم المراجعه' : 'تم اغلاق الشكوى'}',
                                            style:
                                                TextStyle(fontFamily: 'Cairo'),
                                          ),
                                          margin: EdgeInsets.only(
                                              right: 10, left: 10),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Text(
                                            'حاله الشكوى',
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontWeight: FontWeight.bold),
                                            textDirection: TextDirection.rtl,
                                          ),
                                          margin: EdgeInsets.only(
                                              right: 10, left: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF6F6F6),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 3,
                                        child: Container(
                                          child: Text(
                                            '${snapshot.data.details}',
                                            style:
                                                TextStyle(fontFamily: 'Cairo'),
                                            maxLines: 5,
                                          ),
                                          margin: EdgeInsets.only(
                                            right: 10,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: Text(
                                            'تفاصيل الشكوى',
                                            style: TextStyle(
                                                fontFamily: 'Cairo',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          margin: EdgeInsets.only(
                                              right: 10, left: 10),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(right: 20, left: 20, top: 50),
                            child: new Center(
                              child: new Column(
                                children: <Widget>[
                                  new SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height:
                                        MediaQuery.of(context).size.width / 8,
                                    child: new RaisedButton(
                                      onPressed: () async {
                                        if (snapshot.data.status == 0) {
                                          StaticMethods.customer_care_value = 1;
                                        } else {
                                          StaticMethods.customer_care_value = 0;
                                        }
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => HomePage(
                                                      token: widget.token,
                                                    )));
                                      },

                                      child: new Text(
                                        "اذهب الى الرئيسيه",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Cairo',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      //use to make circle border for button
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(5.0),
                                      ),
                                      color: MassaraColor.primary_color,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  new SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height:
                                        MediaQuery.of(context).size.width / 8,
                                    child: new RaisedButton(
                                      onPressed: () {
                                        if (snapshot.data.status == 0) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CustomerServiceComplain(
                                                          token: (sharedPrefs
                                                                      .getString(
                                                                          'user_access_token') ==
                                                                  null)
                                                              ? StaticMethods
                                                                  .vistor_token
                                                              : sharedPrefs
                                                                  .getString(
                                                                      'user_access_token'),
                                                          user_id: sharedPrefs
                                                              .getInt(
                                                                  'user_id'))));
                                        } else {}
                                      },
                                      child: new Text(
                                        "اعاده ارسال",
                                        style: TextStyle(
                                            color: MassaraColor.primary_color,
                                            fontFamily: 'Cairo',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(5.0),
                                        side: BorderSide(
                                          color: Color(0xFF707070),
                                        ),
                                      ),
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {}
            } else {}
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
