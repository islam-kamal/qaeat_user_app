import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Qaeat/Custom_Widgets/export_file.dart';

class HallDetails extends StatefulWidget {
  final String token;
  final int hall_id;
  final int route; // if route =1 ---- map page , 2------ offer page , 3 -------- favourite page
  HallDetails({this.token, this.hall_id, this.route});
  @override
  State<StatefulWidget> createState() {

    print('hall_id : ${hall_id}');
    // TODO: implement createState
    return HallDetails_state();
  }
}

class HallDetails_state extends State<HallDetails> {
  bool favourite_icon = false;
  List<int> fav_salon_id;
  List<String> savedStrList;
  SharedPreferences sharedPrefs;
  Future<SalonDetailsModel> hall_details;
  List<int> payment_method_list =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fav_salon_id = new List<int>();
    savedStrList = new List<String>();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
      });
    });
    hall_details = ApiProvider.getAllSalonsBy_id(
        widget.token, widget.hall_id, context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    hall_details = null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        switch(widget.route){
          case 1 :
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NearestSalonic(
                      token: widget.token,
                      map_details_route: 1,
                    )));
            break;
          case 2 :
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OfferPage(
                      token: widget.token,
                    )));
            break;
          case 3:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MorePage(
                    )));
            break;
        }

      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: QaeatColor.primary_color,
          title: Text('احجز الآن',
              style: TextStyle(
                fontFamily: 'Cairo',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              switch(widget.route){
                case 1 :
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NearestSalonic(
                            token: widget.token,
                            map_details_route: 1,
                          )));
                  break;
                case 2 :
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OfferPage(
                            token: widget.token,
                          )));
                  break;
                case 3:
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MorePage(
                          )));
                  break;
              }

            },
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: FutureBuilder<SalonDetailsModel>(
            future: hall_details,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (widget.token == StaticMethods.vistor_token) {
                  fav_salon_id = [];
                } else {
                  savedStrList = sharedPrefs.getStringList('salon_list');
                  fav_salon_id = savedStrList.map((i) => int.parse(i)).toList();
                  double rate = (snapshot.data.total_rate == null)
                      ? 0.0
                      : snapshot.data.total_rate.value.toDouble();

                  snapshot.data.services.forEach((element) {
                    payment_method_list.add(element.payment);
                  });
                  print("--------تفاصيل القاعة payment_method_list ------------ : ${payment_method_list}");
                  payment_method_list.toList().toSet();
                  return Wrap(
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: <Widget>[
                          Padding(
                            padding:
                            EdgeInsets.only(top: 20, left: 5, right: 5),
                            child: Card(
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                BorderSide(color: Color(0xFFDCDCDC)),
                              ),
                              child: Column(
                                children: <Widget>[
                                  SalonSlider(
                                    hallPictures: snapshot.data.gallery,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 3,
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(
                                                    right: 20),
                                                child: Text(
                                                  '${snapshot.data.username.isEmpty
                                                      ? ''
                                                      : snapshot.data.username}',
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      color:
                                                      Color(0xFF707070),
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                //  padding: EdgeInsets.only(right: 20),
                                                child: HelperWidgets
                                                    .ratingbar_fun(
                                                    5, rate, 18),
                                              ),
                                            ],
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding:
                                            EdgeInsets.only(left: 20),
                                            child: new Container(
                                                padding: EdgeInsets.only(
                                                    top: 15.0),
                                                alignment: Alignment.center,
                                                child: ButtonTheme(
                                                  minWidth:
                                                  MediaQuery
                                                      .of(context)
                                                      .size
                                                      .width,
                                                  child: RaisedButton(
                                                    shape:
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius
                                                          .circular(
                                                          5.0),
                                                      side: BorderSide(
                                                        color: QaeatColor
                                                            .primary_color,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    color: QaeatColor
                                                        .primary_color,
                                                    child: Text(
                                                      'احجز الان',
                                                      style: TextStyle(
                                                          color:
                                                          Colors.white,
                                                          fontSize: 16.0,
                                                          fontFamily:
                                                          'Cairo',
                                                          fontWeight:
                                                          FontWeight
                                                              .normal),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                RerservationNow(
                                                                  token: widget.token,
                                                                  salon_id: snapshot.data.id,
                                                                  logo: snapshot.data.logo,
                                                                  name: snapshot.data.name,
                                                                  rate: rate,
                                                                  home_services:
                                                                  snapshot.data.home_service,
                                                                  payment:  payment_method_list.contains(2)?
                                                                  2 :  payment_method_list.contains(1) ? 1 : 0,
                                                                  salonPictures:
                                                                  snapshot.data.gallery,
                                                                  salon_list_type: 7,
                                                                  hall_details_route: widget.route,
                                                                ),
                                                          ));
                                                    },
                                                  ),
                                                )),
                                          )),
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.only(
                                            right: 20, top: 5),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color:
                                                    Color(0xFF959090),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 7,
                                              child: Text(
                                                '${snapshot.data.address.isEmpty
                                                    ? ''
                                                    : snapshot.data.address}',
                                                style: TextStyle(
                                                  color: Color(0xFF403E3E),
                                                  fontFamily: 'Cairo',
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  right: 20, left: 10),
                                              child: Text(
                                                'طريقه الدفع :',
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    color:
                                                    Color(0xFF292929)),
                                              ),
                                            ),
                                            payment_method_list.contains(2)   ?
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  padding:
                                                  EdgeInsets.only(
                                                      right: 10,
                                                      left: 10),
                                                  child: Container(

                                                    alignment:
                                                    Alignment
                                                        .center,
                                                    decoration: BoxDecoration(
                                                        color: Color(
                                                            0xFFDCDCDC),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            5)),
                                                    child: Text(
                                                      '  الدفع عند مقدم الخدمة  ',
                                                      style: TextStyle(
                                                          fontFamily: 'Cairo',
                                                          color: Color(0xFF292929),
                                                          fontWeight: FontWeight.normal,
                                                          fontSize: 12
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                  EdgeInsets.only(
                                                      right: 10,
                                                      left: 10),
                                                  child: Container(
                                                    alignment:
                                                    Alignment
                                                        .center,
                                                    decoration: BoxDecoration(
                                                        color: Color(
                                                            0xFFDCDCDC),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            5)),
                                                    child: Text(
                                                      '    اونلاين    ',
                                                      style: TextStyle(
                                                          fontFamily:
                                                          'Cairo',
                                                          color: Color(
                                                              0xFF292929),
                                                          fontWeight:
                                                          FontWeight
                                                              .normal),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                                : Container(
                                              padding:
                                              EdgeInsets.only(
                                                  right: 10,
                                                  left: 10),
                                              child: Container(
                                                alignment:
                                                Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: Color(
                                                        0xFFDCDCDC),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        5)),
                                                child: Text(
                                                  payment_method_list.contains(1) ?
                                                  '    اونلاين    '
                                                      : '   الدفع عند مقدم الخدمة   ',
                                                  style: TextStyle(
                                                      fontFamily:
                                                      'Cairo',
                                                      color: Color(
                                                          0xFF292929),
                                                      fontWeight:
                                                      FontWeight
                                                          .normal),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      (snapshot.data.categoryId == 1) // ----------------- if category id represent hall will shoe number of indivdaual
                                          ?   Container(
                                        padding: EdgeInsets.only(top: 10,bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  right: 20, left: 10),
                                              child: Text(
                                                'عدد الافراد :',
                                                style: TextStyle(
                                                    fontFamily: 'Cairo',
                                                    color:
                                                    Color(0xFF292929)),
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(right: 10, left: 10),
                                              child: Container(
                                                width: MediaQuery.of(context).size.width / 4,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(color: Color(0xFFDCDCDC),
                                                    borderRadius: BorderRadius.circular(5)),
                                                child: Center(
                                                  child: Text(
                                                    ' ${snapshot.data.hallMaxNumber} ', //---------------------- hall individuals number .....................
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        color: Color(0xFF292929),
                                                        fontWeight: FontWeight.normal),
                                                  ),
                                                ),
                                              ),
                                            )

                                          ],
                                        ),
                                      ) : Container(),
                                      SizedBox(height: 10,),

                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(30)),
                                child: (fav_salon_id
                                    .contains(snapshot.data.id))
                                    ? IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    size: 30,
                                    color: QaeatColor.primary_color,
                                  ),
                                  onPressed: () {
                                    if (widget.token ==
                                        StaticMethods
                                            .vistor_token) {} else {
                                      setState(() async {
                                        await ApiProvider
                                            .removeSalonFromFavourite(
                                            widget.token,
                                            snapshot.data.id,
                                            sharedPrefs.getInt(
                                                'user_id'),
                                            context);
                                        await ApiProvider
                                            .getAllFavourits(
                                            widget.token,
                                            sharedPrefs.getInt(
                                                'user_id'),
                                            context);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                context) =>
                                                super.widget));
                                      });
                                    }
                                  },
                                )
                                    : IconButton(
                                  icon: Icon(
                                    Icons.favorite_border,
                                    size: 30,
                                    color: QaeatColor.primary_color,
                                  ),
                                  onPressed: () {
                                    if (widget.token ==
                                        StaticMethods
                                            .vistor_token) {} else {
                                      setState(() async {
                                        await ApiProvider
                                            .addSalonToFavourite(
                                            widget.token,
                                            snapshot
                                                .data.id,
                                            sharedPrefs.getInt(
                                                'user_id'),
                                            context);
                                        await ApiProvider
                                            .getAllFavourits(
                                            widget.token,
                                            sharedPrefs.getInt(
                                                'user_id'),
                                            context);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                context) =>
                                                super.widget));
                                      });
                                    }
                                  },
                                ),
                              ))
                        ],
                      )
                    ],
                  );
                }
              } else {}
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
