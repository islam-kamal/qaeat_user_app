import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Massara/Custom_Widgets/export_file.dart';

class SalonicList extends StatefulWidget {
  final String token;
  final int salon_id;
  final int route; // if route =1 you must return to map page else return to offer page
  SalonicList({this.token, this.salon_id, this.route});
  @override
  State<StatefulWidget> createState() {
    ('SalonicList');
    ('salon_id : ${salon_id}');
    // TODO: implement createState
    return SalonicList_state();
  }
}

class SalonicList_state extends State<SalonicList> {
  bool favourite_icon = false;
  List<int> fav_salon_id;
  List<String> savedStrList;
  SharedPreferences sharedPrefs;
  Future<List<SalonDetailsModel>> salonic_list;
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
    salonic_list = ApiProvider.getAllSalons(widget.token, context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    salonic_list = null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        if (widget.route == 1) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NearestSalonic(
                        token: widget.token,
                    map_details_route: 1,
                      )));
        } else {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OfferPage(
                        token: widget.token,
                      )));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MassaraColor.primary_color,
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
              if (widget.route == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NearestSalonic(
                              token: widget.token,
                          map_details_route: 1,
                            )));
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => OfferPage(
                              token: widget.token,
                            )));
              }
            },
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: FutureBuilder<List<SalonDetailsModel>>(
            future: salonic_list,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (widget.token == StaticMethods.vistor_token) {
                  fav_salon_id = [];
                } else {
                  savedStrList = sharedPrefs.getStringList('salon_list');
                  fav_salon_id = savedStrList.map((i) => int.parse(i)).toList();
                }
                if (widget.salon_id == null) {
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, index) {
                      double rate = (snapshot.data[index].total_rate ==
                              null)
                          ? 0.0
                          : snapshot.data[index].total_rate.value.toDouble();

                      (snapshot.data[index].gallery[0].photo);
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
                                        salonPictures:
                                        snapshot.data[index].gallery,
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
                                                      '${snapshot.data[index].name.isEmpty ? '' : snapshot.data[index].name}',
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
                                                      MediaQuery.of(context)
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
                                                            color: MassaraColor.primary_color,
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        color:
                                                        MassaraColor.primary_color,
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
                                                                      token: widget
                                                                          .token,
                                                                      salon_id: snapshot
                                                                          .data[
                                                                      index]
                                                                          .id,
                                                                      logo: snapshot
                                                                          .data[
                                                                      index]
                                                                          .logo,
                                                                      name: snapshot
                                                                          .data[
                                                                      index]
                                                                          .name,
                                                                      rate: rate,
                                                                      home_services:
                                                                      snapshot
                                                                          .data[
                                                                      index]
                                                                          .home_service,
                                                                      payment: snapshot
                                                                          .data[
                                                                      index]
                                                                          .payment,
                                                                      salonPictures:
                                                                      snapshot
                                                                          .data[
                                                                      index]
                                                                          .gallery,
                                                                      salon_list_type:
                                                                      1,
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
                                                      color: Color(0xFF959090),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                                Expanded(
                                                  flex: 7,
                                                  child:  Text(
                                                    '${snapshot.data[index].address.isEmpty ? '' : snapshot.data[index].address}',
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
                                                (snapshot.data[index].payment ==
                                                    2)
                                                    ? Row(
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
                                                          '  الدفع في المركز  ',
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
                                                      (snapshot.data[index]
                                                          .payment ==
                                                          1)
                                                          ? '    اونلاين    '
                                                          : '   الدفع في المركز   ',
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
                                          Container(
                                            padding: EdgeInsets.only(top: 10,bottom: 10),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 20, left: 10),
                                                  child: Text(
                                                    'خدمات الحجز :',
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        color:
                                                        Color(0xFF292929)),
                                                  ),
                                                ),
                                                (snapshot.data[index]
                                                    .home_service ==
                                                    2)
                                                    ? Row(
                                                  children: <Widget>[
                                                    Container(
                                                      padding:
                                                      EdgeInsets.only(
                                                          right: 10,
                                                          left: 10),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width /
                                                            4,
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
                                                          '  فى المركز  ',
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
                                                    Container(
                                                      padding:
                                                      EdgeInsets.only(
                                                          right: 10,
                                                          left: 10),
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                            context)
                                                            .size
                                                            .width /
                                                            4,
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
                                                          'في المنزل',
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
                                                    width: MediaQuery.of(
                                                        context)
                                                        .size
                                                        .width /
                                                        4,
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
                                                      (snapshot.data[index]
                                                          .home_service ==
                                                          1)
                                                          ? 'فى البيت'
                                                          : ' فى المركز ',
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
                                        .contains(snapshot.data[index].id))
                                        ? IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        size: 30,
                                        color: MassaraColor.primary_color,
                                      ),
                                      onPressed: () {
                                        if (widget.token ==
                                            StaticMethods.vistor_token) {
                                        } else {
                                          setState(() async {
                                            await ApiProvider
                                                .removeSalonFromFavourite(
                                                widget.token,
                                                snapshot
                                                    .data[index].id,
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
                                        color: MassaraColor.primary_color,
                                      ),
                                      onPressed: () {
                                        if (widget.token ==
                                            StaticMethods.vistor_token) {
                                        } else {
                                          setState(() async {
                                            await ApiProvider
                                                .addSalonToFavourite(
                                                widget.token,
                                                snapshot
                                                    .data[index].id,
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
                    },
                  );
                } else {
                  ('sssssssssssssss');
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, index) {
                      if (snapshot.data[index].id == widget.salon_id) {
                        double rate = (snapshot.data[index].total_rate ==
                                null)
                            ? 0.0
                            : snapshot.data[index].total_rate.value.toDouble();

                        if (widget.token == StaticMethods.vistor_token) {
                          fav_salon_id = [];
                        } else {
                          savedStrList =
                              sharedPrefs.getStringList('salon_list');
                          fav_salon_id =
                              savedStrList.map((i) => int.parse(i)).toList();
                        }

                        return Wrap(
                          children: [
                            Stack(
                              alignment: Alignment.topLeft,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: 20, left: 5, right: 5),
                                  child: Card(
                                    shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                      BorderSide(color: Color(0xFFDCDCDC)),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        SalonSlider(
                                          salonPictures:
                                          snapshot.data[index].gallery,
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
                                                        '${snapshot.data[index].name}',
                                                        style: TextStyle(
                                                            fontFamily: 'Cairo',
                                                            color: Color(
                                                                0xFF707070),
                                                            fontWeight:
                                                            FontWeight.bold,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                    Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      children: [
                                                        Container(
                                                          padding:
                                                          EdgeInsets.only(
                                                              right: 20),
                                                          child: HelperWidgets
                                                              .ratingbar_fun(
                                                              5, rate, 18),
                                                        ),
                                                      ],
                                                    )
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
                                                      alignment:
                                                      Alignment.center,
                                                      child: ButtonTheme(
                                                        minWidth: MediaQuery.of(
                                                            context)
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
                                                              color: MassaraColor.primary_color,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          color:
                                                          MassaraColor.primary_color,
                                                          child: Text(
                                                            'احجز الان',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
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
                                                                        token: widget
                                                                            .token,
                                                                        salon_id:
                                                                        snapshot
                                                                            .data[index]
                                                                            .id,
                                                                        logo: snapshot
                                                                            .data[
                                                                        index]
                                                                            .logo,
                                                                        name: snapshot
                                                                            .data[
                                                                        index]
                                                                            .name,
                                                                        rate: rate,
                                                                        home_services: snapshot
                                                                            .data[
                                                                        index]
                                                                            .home_service,
                                                                        payment: snapshot
                                                                            .data[
                                                                        index]
                                                                            .payment,
                                                                        salonPictures: snapshot
                                                                            .data[
                                                                        index]
                                                                            .gallery,
                                                                        salon_list_type:
                                                                        1,
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
                                                        color: Color(0xFF959090),
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
                                                      '${snapshot.data[index].address}',
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
                                                          color: Color(
                                                              0xFF292929)),
                                                    ),
                                                  ),
                                                  (snapshot.data[index]
                                                      .payment == 2)
                                                      ? Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                        flex: 2,
                                                          child: Text(
                                                            'الدفع في المركز',
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
                                                   Expanded(
                                                     flex: 1,
                                                     child:Text(
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

                                                    ],
                                                  )
                                                      : Container(
                                                    padding:
                                                    EdgeInsets.only(
                                                        right: 10,
                                                        left: 10),
                                                    child: Container(
                                                      alignment: Alignment
                                                          .center,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFFDCDCDC),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              5)),
                                                      child: Text(
                                                        (snapshot.data[index]
                                                            .payment ==
                                                            1)
                                                            ? '    اونلاين    '
                                                            : '   الدفع في المركز   ',
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
                                            Container(
                                              padding: EdgeInsets.only(top: 10,bottom: 10),
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        right: 20, left: 10),
                                                    child: Text(
                                                      'خدمات الحجز :',
                                                      style: TextStyle(
                                                          fontFamily: 'Cairo',
                                                          color: Color(
                                                              0xFF292929)),
                                                    ),
                                                  ),
                                                  (snapshot.data[index]
                                                      .home_service ==
                                                      2)
                                                      ? Row(
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets
                                                            .only(
                                                            right: 10,
                                                            left: 10),
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width /
                                                              4,
                                                          alignment:
                                                          Alignment
                                                              .center,
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xFFDCDCDC),
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  5)),
                                                          child: Text(
                                                            '  فى المركز  ',
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
                                                      Container(
                                                        padding: EdgeInsets
                                                            .only(
                                                            right: 10,
                                                            left: 10),
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width /
                                                              4,
                                                          alignment:
                                                          Alignment
                                                              .center,
                                                          decoration: BoxDecoration(
                                                              color: Color(
                                                                  0xFFDCDCDC),
                                                              borderRadius:
                                                              BorderRadius.circular(
                                                                  5)),
                                                          child: Text(
                                                            'فى البيت',
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
                                                      width: MediaQuery.of(
                                                          context)
                                                          .size
                                                          .width /
                                                          4,
                                                      alignment: Alignment
                                                          .center,
                                                      decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFFDCDCDC),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              5)),
                                                      child: Text(
                                                        (snapshot.data[index]
                                                            .home_service ==
                                                            1)
                                                            ? 'فى البيت'
                                                            : ' فى المركز ',
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
                                      child: (fav_salon_id.contains(
                                          snapshot.data[index].id))
                                          ? IconButton(
                                        icon: Icon(
                                          Icons.favorite,
                                          size: 30,
                                          color: MassaraColor.primary_color,
                                        ),
                                        onPressed: () {
                                          if (widget.token ==
                                              StaticMethods
                                                  .vistor_token) {
                                          } else {
                                            setState(() async {
                                              await ApiProvider
                                                  .removeSalonFromFavourite(
                                                  widget.token,
                                                  snapshot
                                                      .data[index].id,
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
                                          color: MassaraColor.primary_color,
                                        ),
                                        onPressed: () {
                                          if (widget.token ==
                                              StaticMethods
                                                  .vistor_token) {
                                          } else {
                                            setState(() async {
                                              await ApiProvider
                                                  .addSalonToFavourite(
                                                  widget.token,
                                                  snapshot
                                                      .data[index].id,
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
                      } else {
                        return Container();
                      }
                    },
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
