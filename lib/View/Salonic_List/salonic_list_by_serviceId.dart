import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Qaeat/Custom_Widgets/export_file.dart';
import 'package:Qaeat/View/Home/Services/all_services.dart';

class SalonicListByServiceId extends StatefulWidget {
  final String token;
  final int category_id;
  final int service_type;
  SalonicListByServiceId({
    this.token,
    this.category_id,
    this.service_type,
  });
  @override
  State<StatefulWidget> createState() {
  print  ('SalonicListByServiceId page');
  print ('--- category_id ----- : ${category_id}');
  print  ('--- service_type ----- : ${service_type}');
  print  ('--- token ----- : ${token}');
    // TODO: implement createState
    return SalonicListByServiceId_State();
  }
}

class SalonicListByServiceId_State extends State<SalonicListByServiceId> {
  bool favourite_icon = false;
//  int fav_salon_id;
  List<int> fav_salon_id;
  List<String> savedStrList;
  Future<List<SalonDetailsModel>> salonsList;
  SharedPreferences sharedPrefs;
  int category;
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
    salonsList = ApiProvider.getAllSalonsByService_id(
        widget.token, widget.category_id, context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    salonsList = null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                  token: widget.token,
                )));
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomePage(
                        token: widget.token,
                      )));
            },
          ),
        ),
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: FutureBuilder<List<SalonDetailsModel>>(
            future: salonsList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.length != 0) {
                  print("snap : ${snapshot.data[0].name}");
                  if (widget.token == StaticMethods.vistor_token) {
                    fav_salon_id = [];
                  } else {
                    print("snap : 1");
                    savedStrList = sharedPrefs.getStringList('salon_list');
                    print("snap savedStrList: ${savedStrList}");
                    fav_salon_id =savedStrList ==null?[]: savedStrList.map((i) => int.parse(i)).toList();
                    print("snap : 2");
                  }
                  return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, index) {
                      print("snap : 3");
                      double rate = (snapshot.data[index].total_rate == null)
                          ? 0.0
                          : snapshot.data[index].total_rate.value.toDouble();
                      for (int i = 0; i < snapshot.data[index].services.length; i++){
                        if (snapshot.data[index].services[i].id == widget.category_id) {
                          category = snapshot.data[index].services[i].category_id;
                        }
                      }
                      print("snap : 4");
                      snapshot.data[index].services.forEach((element) {
                        payment_method_list.add(element.payment);
                      });
                      print("-------- payment_method_list ------------ : ${payment_method_list}");
                      payment_method_list.toList().toSet();
                      print("--------sorted  payment_method_list ------------ : ${payment_method_list}");

                      return Wrap(
                        children: [
                          Stack(
                            alignment: Alignment.topLeft,
                            children: <Widget>[
                              Padding(
                                padding:
                                EdgeInsets.only(top: 15, left: 5, right: 5),
                                child: Card(
                                  shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide:
                                    BorderSide(color: Color(0xFFDCDCDC)),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      SalonSlider(
                                        hallPictures:
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
                                                      '${snapshot.data[index].username.isEmpty ? '' : snapshot.data[index].username}',
                                                      style: TextStyle(
                                                          fontFamily: 'Cairo',
                                                          color:
                                                          Color(0xFF707070),
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
                                                    MainAxisAlignment.start,
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
                                                            color: QaeatColor.primary_color,
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        color:
                                                        QaeatColor.primary_color,
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
                                                                      salon_id: snapshot.data[index].id,
                                                                      logo: snapshot.data[index].logo,
                                                                      name: snapshot.data[index].name,
                                                                      rate: rate,
                                                                      home_services: widget.service_type,
                                                                      payment:  payment_method_list.contains(2)?
                                                                      2 :  payment_method_list.contains(1) ? 1 : 0,
                                                                      salonPictures:
                                                                      snapshot.data[index].gallery,
                                                                      salon_list_type: 2,
                                                                      category_id: snapshot.data[index].categoryId,
                                                                      service_id: widget.category_id,
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
                                                        '${snapshot.data[index].address.isEmpty ? '' : snapshot.data[index].address}',
                                                        style: TextStyle(
                                                          color: Color(0xFF403E3E),
                                                          fontFamily: 'Cairo',
                                                        ),
                                                      ) ,
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
                                          (snapshot.data[index].categoryId == 1) // ----------------- if category id represent hall will shoe number of indivdaual
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
                                                        ' ${snapshot.data[index].hallMaxNumber} ', //---------------------- hall individuals number .....................
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
                                        .contains(snapshot.data[index].id))
                                        ? IconButton(
                                      icon: Icon(
                                        Icons.favorite,
                                        size: 30,
                                        color: QaeatColor.primary_color,
                                      ),
                                      onPressed: () {
                                        setState(() async {
                                          await ApiProvider
                                              .removeSalonFromFavourite(
                                              widget.token,
                                              snapshot.data[index].id,
                                              sharedPrefs
                                                  .getInt('user_id'),
                                              context);
                                          await ApiProvider
                                              .getAllFavourits(
                                              widget.token,
                                              sharedPrefs
                                                  .getInt('user_id'),
                                              context);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                  context) =>
                                                  super.widget));
                                        });
                                      },
                                    )
                                        : IconButton(
                                      icon: Icon(
                                        Icons.favorite_border,
                                        size: 30,
                                        color: QaeatColor.primary_color,
                                      ),
                                      onPressed: () {
                                        setState(() async {
                                          await ApiProvider
                                              .addSalonToFavourite(
                                              widget.token,
                                              snapshot.data[index].id,
                                              sharedPrefs
                                                  .getInt('user_id'),
                                              context);
                                          await ApiProvider
                                              .getAllFavourits(
                                              widget.token,
                                              sharedPrefs
                                                  .getInt('user_id'),
                                              context);
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                  context) =>
                                                  super.widget));
                                        });
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
                            ' مقدم الخدمة غير متوفرة فى الوقت الحالى ',
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
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }
}
