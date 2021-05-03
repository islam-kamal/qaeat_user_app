import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:Massara/Custom_Widgets/export_file.dart';
import 'package:Massara/Model/order_model.dart';
import 'package:Massara/View/Reservation/rating.dart';

class MyReservation extends StatefulWidget {
  final String token;
  final int user_id;
  MyReservation({this.token, this.user_id});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyReservation_State();
  }
}

class MyReservation_State extends State<MyReservation> {
  bool more_details = true;
  var details = 'تفاصيل اقل';
  Future<List<OrderModel>> reservationList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.token == StaticMethods.vistor_token) {
      reservationList = null;
    } else {
      reservationList =
          ApiProvider.getReservationList(widget.token, widget.user_id, context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    reservationList = null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MorePage()));
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'حجوزاتى',
              style: TextStyle(fontFamily: 'Cairo'),
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
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MorePage()));
                }),
          ),
          body: Padding(
            padding: EdgeInsets.only(top: 10, left: 5, right: 5),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: (reservationList == null)
                  ? VistorMessage()
                  : FutureBuilder<List<OrderModel>>(
                      future: reservationList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            if (snapshot.data.length != 0) {
                              return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context, index) {
                                    return Column(
                                      children: <Widget>[
                                        Card(
                                          shape: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: BorderSide(
                                                color: Color(0xFFDCDCDC)),
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 1,
                                                      child: Image.network(
                                                        '${snapshot.data[index].salon.logo}',
                                                        fit: BoxFit.cover,
                                                        alignment:
                                                            Alignment.topCenter,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            4,
                                                      ),
                                                    ),
                                                    Expanded(
                                                        flex: 3,
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  right: 20),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Text(
                                                                '${snapshot.data[index].salon.name}',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Cairo',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                              new Container(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child:
                                                                    ButtonTheme(
                                                                  minWidth: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      2.5,
                                                                  child:
                                    (snapshot.data[index].status==3)?   RaisedButton(
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5.0),
                                                                      side:
                                                                          BorderSide(
                                                                        color: MassaraColor.primary_color,
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                    ),
                                                                    color: MassaraColor.primary_color,
                                                                    child: Text(
                                                                      'تقييم',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontFamily:
                                                                              'Cairo',
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          fontSize:
                                                                              16),
                                                                    ),
                                                                  )
                                                                      :  RaisedButton(
                                      shape:
                                      RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(
                                            5.0),
                                        side:
                                        BorderSide(
                                          color: MassaraColor.primary_color,
                                          width:
                                          1.0,
                                        ),
                                      ),
                                      color: MassaraColor.primary_color,
                                      child: Text(
                                        'تقييم',
                                        style: TextStyle(
                                            color: Colors
                                                .white,
                                            fontFamily:
                                            'Cairo',
                                            fontWeight: FontWeight
                                                .normal,
                                            fontSize:
                                            16),
                                      ),
                                      onPressed:
                                          () {
                                        rating();
                                      },
                                    ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right: 10, top: 5),
                                                child: Column(
                                                  children: <Widget>[
                                                    Row(
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
                                                             width: 10,
                                                           ),
                                                         ],
                                                       ),
                                                     ),
                                                        Expanded(
                                                          flex: 7,
                                                          child: Text(
                                                            '${snapshot.data[index].salon.address}',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF403E3E),
                                                              fontFamily: 'Cairo',
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 5),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.date_range,
                                                            color: Color(
                                                                0xFF959090),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            '${snapshot.data[index].date}',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF403E3E),
                                                              fontFamily:
                                                                  'Cairo',
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Text(
                                                            '-',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF292929),
                                                              fontFamily:
                                                                  'Cairo',
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 15,
                                                          ),
                                                          Icon(
                                                            Icons.access_time,
                                                            color: Color(
                                                                0xFF959090),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            ' ${snapshot.data[index].time}',
                                                            textDirection:
                                                                TextDirection
                                                                    .ltr,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF403E3E),
                                                              fontFamily:
                                                                  'Cairo',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    // container contain more details data
                                                    more_details
                                                        ? Container()
                                                        : Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 10),
                                                            child: Column(
                                                              children: <
                                                                  Widget>[
                                                                (snapshot.data[index]
                                                                            .employee ==
                                                                        null)
                                                                    ? Container()
                                                                    : Padding(
                                                                        padding:
                                                                            EdgeInsets.only(top: 5),
                                                                        child:
                                                                            Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          children: <
                                                                              Widget>[
                                                                            Image(
                                                                              image: AssetImage('images/reservation/barber.png'),
                                                                              fit: BoxFit.cover,
                                                                            ),
                                                                            SizedBox(
                                                                              width: 10,
                                                                            ),
                                                                            Text(
                                                                              'الخبير',
                                                                              style: TextStyle(
                                                                                color: Color(0xFF292929),
                                                                                fontFamily: 'Cairo',
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 15,
                                                                            ),
                                                                            Text(':'),
                                                                            SizedBox(
                                                                              width: 15,
                                                                            ),
                                                                            Container(
                                                                              padding: EdgeInsets.only(right: 10, left: 10),
                                                                              child: Container(
                                                                                width: MediaQuery.of(context).size.width / 4,
                                                                                alignment: Alignment.center,
                                                                                decoration: BoxDecoration(color: Color(0xFFF6F6F6), borderRadius: BorderRadius.circular(5)),
                                                                                child: Text(
                                                                                  ' ${snapshot.data[index].employee.name}  ',
                                                                                  style: TextStyle(fontFamily: 'Cairo', color: Color(0xFF403E3E), fontWeight: FontWeight.bold),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 5),
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Image(
                                                                        image: AssetImage(
                                                                            'images/reservation/dollar.png'),
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        'التكلفه ',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xFF292929),
                                                                          fontFamily:
                                                                              'Cairo',
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            15,
                                                                      ),
                                                                      Text(':'),
                                                                      SizedBox(
                                                                        width:
                                                                            15,
                                                                      ),
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                            right:
                                                                                10,
                                                                            left:
                                                                                10),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              MediaQuery.of(context).size.width / 4,
                                                                          alignment:
                                                                              Alignment.center,
                                                                          decoration: BoxDecoration(
                                                                              color: Color(0xFFF6F6F6),
                                                                              borderRadius: BorderRadius.circular(5)),
                                                                          child:
                                                                              Text(
                                                                            '  ${snapshot.data[index].total_cost} ريال  ',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Cairo',
                                                                                color: Color(0xFF403E3E),
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 5),
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Image(
                                                                        image: AssetImage(
                                                                            'images/reservation/money.png'),
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Text(
                                                                        'طريقه الدفع',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xFF292929),
                                                                          fontFamily:
                                                                              'Cairo',
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            15,
                                                                      ),
                                                                      Text(':'),
                                                                      SizedBox(
                                                                        width:
                                                                            15,
                                                                      ),
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                            right:
                                                                                10,
                                                                            left:
                                                                                10),
                                                                        child:
                                                                            Container(

                                                                          alignment:
                                                                              Alignment.center,
                                                                          decoration: BoxDecoration(
                                                                              color: Color(0xFFF6F6F6),
                                                                              borderRadius: BorderRadius.circular(5)),
                                                                          child:
                                                                              Text(
                                                                            '  ${(snapshot.data[index].payment == 0) ? 'الدفع في المركز' : 'اونلاين'}    ',
                                                                            style: TextStyle(
                                                                                fontFamily: 'Cairo',
                                                                                color: Color(0xFF403E3E),
                                                                                fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 10),
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child:
                                                                            Row(
                                                                          children: <
                                                                              Widget>[
                                                                            Text(
                                                                              'الخدمات',
                                                                              style: TextStyle(
                                                                                color: Color(0xFF292929),
                                                                                fontFamily: 'Cairo',
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            Text(':'),
                                                                            SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                          flex:
                                                                              4,
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                MediaQuery.of(context).size.width / 12,
                                                                            child:
                                                                                ListView.builder(
                                                                              shrinkWrap: true,
                                                                              scrollDirection: Axis.horizontal,
                                                                              itemCount: snapshot.data[index].services.length,
                                                                              itemBuilder: (context, i) {
                                                                                return Container(
                                                                                  padding: EdgeInsets.only(right: 2, left: 2),
                                                                                  child: Container(
                                                                                    width: MediaQuery.of(context).size.width / 3,
                                                                                    alignment: Alignment.center,
                                                                                    decoration: BoxDecoration(color: Color(0xFFF6F6F6), borderRadius: BorderRadius.circular(5)),
                                                                                    child: Text(
                                                                                      '${snapshot.data[index].services[i].name} * ${snapshot.data[index].services[i].person_num}  ',
                                                                                      style: TextStyle(fontFamily: 'Cairo', color: Color(0xFF403E3E), fontWeight: FontWeight.bold),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              },
                                                                            ),
                                                                          ))
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 10),
                                                                  child: Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        'حاله الطلب',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Color(0xFF292929),
                                                                          fontFamily:
                                                                              'Cairo',
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      Text(':'),
                                                                      SizedBox(
                                                                        width:
                                                                            5,
                                                                      ),
                                                                      order_status(snapshot
                                                                          .data[
                                                                              index]
                                                                          .status),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                    InkWell(
                                                      child: Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 20,
                                                                bottom: 20),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text(
                                                              '$details',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF707070),
                                                                fontFamily:
                                                                    'Cairo',
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .arrow_drop_down_circle,
                                                              color:
                                                                  Colors.black,
                                                              size: 20,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        setState(() {
                                                          if (more_details) {
                                                            more_details =
                                                                false;
                                                            details =
                                                                'تفاصيل اقل';
                                                          } else {
                                                            more_details = true;
                                                            details =
                                                                'المزيد من التفاصيل';
                                                          }
                                                        });
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  });
                            } else {
                              return Directionality(
                                textDirection: TextDirection.rtl,
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        image: AssetImage(
                                            'images/splash_screen/massara_logo.png'),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'لا يوجد حجوزات  حاليا ',
                                        style: TextStyle(
                                            fontFamily: 'Cairo',
                                            color: MassaraColor.secondary_color,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 21),
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
                                  children: <Widget>[
                                    Image(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      image: AssetImage(
                                          'images/splash_screen/massara_logo.png'),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'لا يوجد حجوزات  حاليا ',
                                      style: TextStyle(
                                          fontFamily: 'Cairo',
                                          color: MassaraColor.secondary_color,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 21),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        }
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
            ),
          ),
        ));
  }

  Future<Widget> rating() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Rating(
          token: widget.token,
          salon_id: 3,
          user_id: widget.user_id,
          employee_id: 24,
        );
      },
    );
  }

  Widget order_status(int status) {
    switch (status) {
      case 0:
        return Container(
          child: Text(
            'معلق',
            style: TextStyle(fontFamily: 'Cairo'),
          ),
        );
        break;
      case 1:
        return Container(
          child: Text(
            'تم قبول الطلب',
            style: TextStyle(fontFamily: 'Cairo'),
          ),
        );
        break;
      case 2:
        return Container(
          child: Text(
            'تم رفض الطلب',
            style: TextStyle(fontFamily: 'Cairo'),
          ),
        );
        break;
      case 3:
        return Container(
          child: Text(
            'تم الغاء الطلب',
            style: TextStyle(fontFamily: 'Cairo'),
          ),
        );
        break;
      case 4:
        return Container(
          child: Text(
            'مكتمل',
            style: TextStyle(fontFamily: 'Cairo'),
          ),
        );
        break;
    }
  }
}
