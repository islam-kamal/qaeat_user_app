import 'file:///D:/Wothoq%20Tech/qaeat/code/qaeat_user_app/lib/Custom_Widgets/custom_bottom_navigation_bar.dart';
import 'package:Qaeat/Model/hall_category_model.dart';
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
  //Future<List<ServiceModel>> serviceList;
  List<ServiceModel> service;
  SharedPreferences sharedPrefs;
  Widget sevicesWidget;

  Future<HallCategoryModel> allServiceList;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   // serviceList = null;
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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          bottomNavigationBar: CustomBottomNavigationBar(
            index: _currentIndex,
          ),
          body: GestureDetector(
            child: SafeArea(
              child: SingleChildScrollView(
                  child: Container(
                    alignment: Alignment.center,
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: [
                          Container(
                            child: Directionality(
                                textDirection: TextDirection.ltr,
                                child: Stack(
                                  overflow: Overflow.visible,
                                  alignment: Alignment.bottomCenter,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  children: [
                                    OfferSlider(
                                      token: (widget.token == StaticMethods.vistor_token)
                                          ? StaticMethods.vistor_token
                                          : widget.token,
                                    ),
                                    Positioned(
                                      bottom: -width *0.1,
                                      right: MediaQuery.of(context).size.width * 0.06,
                                      left: MediaQuery.of(context).size.width * 0.06,
                                      child:   SearchClass(
                                        token: (widget.token == StaticMethods.vistor_token)
                                            ? StaticMethods.vistor_token
                                            : widget.token,

                                      ),
                                    )
                                  ],
                                )

                            ),
                          ),

                          Container(
                            child: FutureBuilder<HallCategoryModel>(
                              future: allServiceList,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data.categories.length != 0) {
                                      return Column(
                                        children: [

                                          Container(
                                            padding: EdgeInsets.only(right: 10, left: 10,top: width * 0.15),
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
                                            height: MediaQuery.of(context).size.width/1.2,
                                            padding: EdgeInsets.all(width * 0.05),
                                            child: ListView.builder(
                                                itemCount: snapshot.data.categories.length ,
                                                scrollDirection: Axis.horizontal,
                                                shrinkWrap: true,
                                                itemBuilder: (BuildContext context, index) {
                                                  print("home icon : ${  snapshot.data.categories[index].icon}");
                                                  return Container(
                                                    padding: EdgeInsets.all(width * 0.01),
                                                    child: InkWell(
                                                      child: Stack(
                                                          children: <Widget>[

                                                            Card(
                                                                clipBehavior: Clip.hardEdge,
                                                                color: Color(0xFFF6F6F6),
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(15.0),
                                                                ),
                                                                child:  Stack(
                                                                  children: [
                                                                    Container(
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(15.0),
                                                                        ),
                                                                        child:Image.network(
                                                                          snapshot.data.categories[index].icon,
                                                                          fit: BoxFit.fill,
                                                                          width: MediaQuery.of(context).size.width /1.5,
                                                                          height: MediaQuery.of(context).size.width / 2,
                                                                        )),
                                                                    Image(
                                                                      width: MediaQuery.of(context).size.width /1.5,
                                                                      height: MediaQuery.of(context).size.width / 2,
                                                                      image: AssetImage('images/home/layer.png'),
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  ],
                                                                )


                                                            ),
                                                            Positioned(
                                                              top: width * 0.40,
                                                              right: 0,
                                                              left:0,
                                                              child: Container(
                                                                width: MediaQuery.of(context).size.width / 3,
                                                                padding: EdgeInsets.only(right: width *0.05),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: BorderRadius.circular(15.0),
                                                                ),
                                                                child:Align(

                                                                  child:  Text(
                                                                    '${snapshot.data.categories[index].name}',
                                                                    style: TextStyle(
                                                                        fontFamily: 'Cairo',
                                                                        color: QaeatColor.secondary_color,fontSize: 17,fontWeight: FontWeight.bold),
                                                                  ),
                                                                  alignment: Alignment.centerRight,
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
                                                                      category_id: snapshot.data.categories[index].id,
                                                                      service_type: 2,

                                                                    )));
                                                      },
                                                    ),);
                                                }),
                                          )
                                        ],
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
                        ],
                      )

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
