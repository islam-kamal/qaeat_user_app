import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Massara/Custom_Widgets/export_file.dart';
import 'package:Massara/Model/offer_model.dart';
import 'package:Massara/View/Home/Services/all_services.dart';
import 'package:Massara/View/Home/Services/home_services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'Search/search_class.dart';

class HomePage extends StatefulWidget {
  final int user_id;
  final String token;
  final String name;
  final String email;
  final String mobile;
  HomePage({this.user_id, this.token, this.name, this.email, this.mobile});
  @override
  State<StatefulWidget> createState() {
    ('user-id : ${user_id}');
    // TODO: implement createState

    return HomePage_state();
  }
}

class HomePage_state extends State<HomePage> {
  HelperWidgets _helperWidgets = new HelperWidgets();
  var style = TextStyle(fontFamily: 'Cairo');
  var index;
  var service_border;
  int _currentIndex;
  Future<List<ServiceModel>> serviceList;
  List<ServiceModel> service;
  SharedPreferences sharedPrefs;
  Widget sevicesWidget;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    serviceList = null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sevicesWidget = AllServices(
      token: (widget.token == StaticMethods.vistor_token)
          ? StaticMethods.vistor_token
          : widget.token,
      home_services: 2,
    );
    setState(() {
      service_border = 3;
      index = 3;
    });
    _currentIndex = 4;
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
      });
    });
    // serviceList = ApiProvider.allServiceList(   token: (widget.token == StaticMethods.vistor_token)
    //          ? StaticMethods.vistor_token
    //          : widget.token, context);
    ('home 3');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Padding(
                padding: EdgeInsets.only(right: 5, left: 5, top: 10),
                child: SearchClass(
                  token: (widget.token == StaticMethods.vistor_token)
                      ? StaticMethods.vistor_token
                      : widget.token,

                )),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            backgroundColor: MassaraColor.primary_color,
            elevation: 5.0,
            bottom: PreferredSize(
                child: Container(), preferredSize: Size.fromHeight(15.0)),
          ),
          bottomNavigationBar: BottomNavigation(
            index: _currentIndex,
          ),
          body: GestureDetector(
            child: SafeArea(
              child: SingleChildScrollView(
                  child: Container(
                    // height: MediaQuery.of(context).size.height,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    alignment: Alignment.center,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: <Widget>[

                          Container(
                            //    padding: EdgeInsets.only(top: 10),
                            child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: OfferSlider(
                                  token: (widget.token == StaticMethods.vistor_token)
                                      ? StaticMethods.vistor_token
                                      : widget.token,
                                )),
                          ),


                          Container(
                            padding: EdgeInsets.only(right: 10, left: 10),
                            alignment: Alignment.centerRight,
                            child: Text(
                              'الخدمات',
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 20, left: 20),
                            color: Color(0xFFF6F6F6),
                            child: Row(
                              children: <Widget>[
                                FlatButton(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: service_border == 3
                                          ? Border(
                                          bottom: BorderSide(color: Colors.black))
                                          : Border(
                                          bottom: BorderSide(
                                              color: Color(0xFFF6F6F6))),
                                    ),
                                    child: Text(
                                      ' الكل ',
                                      style: (index == 3)
                                          ? TextStyle(
                                          color: Color(0xFF444444),
                                          fontFamily: 'Cairo',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)
                                          : TextStyle(
                                        color: Color(0xFF444444),
                                        fontFamily: 'Cairo',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      index = 3;
                                      service_border = 3;
                                      sevicesWidget = AllServices(
                                        token: (widget.token ==
                                            StaticMethods.vistor_token)
                                            ? StaticMethods.vistor_token
                                            : widget.token,
                                        home_services: 2,
                                      );
                                    });
                                  },
                                ),
                                Spacer(),
                                FlatButton(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: service_border == 2
                                          ? Border(
                                          bottom: BorderSide(color: Colors.black))
                                          : Border(
                                          bottom: BorderSide(
                                              color: Color(0xFFF6F6F6))),
                                    ),
                                    child: Text(
                                      ' في المنزل ',
                                      style: (index == 2)
                                          ? TextStyle(
                                          color: Color(0xFF444444),
                                          fontFamily: 'Cairo',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)
                                          : TextStyle(
                                        color: Color(0xFF444444),
                                        fontFamily: 'Cairo',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      index = 2;
                                      service_border = 2;
                                      sevicesWidget = HomeServices(
                                        token: (widget.token ==
                                            StaticMethods.vistor_token)
                                            ? StaticMethods.vistor_token
                                            : widget.token,
                                        home_services: 1,
                                      );
                                    });
                                  },
                                ),
                                Spacer(),
                                FlatButton(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: service_border == 1
                                          ? Border(
                                          bottom: BorderSide(color: Colors.black))
                                          : Border(
                                          bottom: BorderSide(
                                              color: Color(0xFFF6F6F6))),
                                    ),
                                    child: Text(
                                      'في المركز',
                                      style: (index == 1)
                                          ? TextStyle(
                                          color: Color(0xFF444444),
                                          fontFamily: 'Cairo',
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)
                                          : TextStyle(
                                        color: Color(0xFF444444),
                                        fontFamily: 'Cairo',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      index = 1;
                                      service_border = 1;
                                      sevicesWidget = AppointmentService(
                                        token: (widget.token ==
                                            StaticMethods.vistor_token)
                                            ? StaticMethods.vistor_token
                                            : widget.token,
                                        home_services: 0,
                                      );
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          SafeArea(
                            child: SingleChildScrollView(
                              child: _helperWidgets.show_service(sevicesWidget),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            onTap: (){
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }

            },
          ),
        ));
  }
}
