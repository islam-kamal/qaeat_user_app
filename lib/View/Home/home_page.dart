import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Qaeat/Custom_Widgets/export_file.dart';
import 'package:Qaeat/Model/offer_model.dart';
import 'package:Qaeat/View/Home/Services/all_services.dart';
import 'package:Qaeat/View/Home/Services/home_services.dart';

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

  Future<List<ServiceModel>> allServiceList;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    serviceList = null;
    allServiceList = null;

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
      });
    });
    allServiceList = ApiProvider.allServiceList(
        (widget.token == StaticMethods.vistor_token)
            ? StaticMethods.vistor_token
            : widget.token,
        context);

    _currentIndex = 4;
  }

/*  @override
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
  }*/

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          /*appBar: AppBar(
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
            backgroundColor: QaeatColor.primary_color,
            elevation: 5.0,
            bottom: PreferredSize(
                child: Container(), preferredSize: Size.fromHeight(15.0)),
          ),*/
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
                            child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: Stack(
                                  overflow: Overflow.visible,
                                  alignment: Alignment.bottomCenter,
                                  clipBehavior: Clip.hardEdge,
                                  children: [
                                    OfferSlider(
                                      token: (widget.token == StaticMethods.vistor_token)
                                          ? StaticMethods.vistor_token
                                          : widget.token,
                                    ),
                                    Positioned(
                                      bottom: -width *0.1,

                                        right: MediaQuery.of(context).size.width * 0.04,
                                        left: MediaQuery.of(context).size.width * 0.04,
                                        child:   Container(
                                     //     width: MediaQuery.of(context).size.width/1.2,
                                          child: SearchClass(
                                            token: (widget.token == StaticMethods.vistor_token)
                                                ? StaticMethods.vistor_token
                                                : widget.token,

                                          ),
                                        ))
                                  ],
                                )

                            ),
                          ),

                          Container(
                            padding: EdgeInsets.only(right: 10, left: 10,top: width * 0.08),
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
                            child: FutureBuilder<List<ServiceModel>>(
                              future: allServiceList,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data.length != 0) {
                                      return Container(
                                        height: MediaQuery.of(context).size.width/1.5,
                                        padding: EdgeInsets.all(width * 0.01),
                                        child: ListView.builder(
                                            itemCount: snapshot.data.length,
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemBuilder: (BuildContext context, index) {
                                              return Padding(
                                                padding: EdgeInsets.all(width * 0.01),
                                              child: InkWell(
                                                child: Stack(
                                                    children: <Widget>[

                                                      Card(
                                                        color: Color(0xFFF6F6F6),
                                                        child: Image.network(
                                                          snapshot.data[index].icon,
                                                          fit: BoxFit.fill,
                                                          width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                              2,
                                                          height: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                              2,
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: width * 0.43,
                                                        right: 0,
                                                        left:0,
                                                        child: Container(
                                                          width: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                              3,
                                                          child:Align(

                                                            child:  Text(
                                                              '${snapshot.data[index].name}',
                                                              style: TextStyle(
                                                                  fontFamily: 'Cairo',
                                                                  color: QaeatColor.black_color,fontSize: 17,fontWeight: FontWeight.bold),
                                                            ),
                                                            alignment: Alignment.center,
                                                          ),
                                                          decoration: BoxDecoration(
                                                              color: Colors.grey.shade100,
                                                              borderRadius: BorderRadius.circular(5)
                                                          ),
                                                        ),

                                                      )
                                                    ]),


                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SalonicListByServiceId(
                                                                token: (sharedPrefs.getString(
                                                                    'user_access_token') ==
                                                                    null)
                                                                    ? StaticMethods
                                                                    .vistor_token
                                                                    : sharedPrefs.getString(
                                                                    'user_access_token'),
                                                                service_id:
                                                                snapshot.data[index].id,
                                                                service_type: 2,

                                                              )));
                                                },
                                              ),);
                                            }),
                                      );
                                    } else {
                                      return Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Container(
                                          padding: EdgeInsets.only(top: width * 0.1),
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Icon(
                                                Icons.work,
                                                size: 80,
                                                color: QaeatColor.black_color,
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                'لا توجد خدمات  فى الوقت الحالى  ',
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    color: QaeatColor.black_color,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  } else {
                                    return Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Icon(
                                              Icons.work,
                                              size: 80,
                                              color: QaeatColor.secondary_color,
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              'لا توجد خدمات  فى الوقت الحالى  ',
                                              style: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  color: QaeatColor.secondary_color,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                } else {}

                                return Center(
                                  child: CircularProgressIndicator(backgroundColor:  QaeatColor.primary_color,

                                  ),
                                );
                              },
                            ),
                          )



                          /* Container(
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
                          ),*/
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
