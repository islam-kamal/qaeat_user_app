import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Massara/Custom_Widgets/export_file.dart';

class SearchResult extends StatefulWidget {
  final String token;
  final SalonDetailsModel item;
  SearchResult({this.token, this.item});
  @override
  State<StatefulWidget> createState() {
    ('--------- SearchResult --------');

    // TODO: implement createState
    return SearchResultState();
  }
}

class SearchResultState extends State<SearchResult> {
  List<int> fav_salon_id;
  List<String> savedStrList;
  SharedPreferences sharedPrefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ('home- SearchResult');
    fav_salon_id = new List<int>();
    savedStrList = new List<String>();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.token == StaticMethods.vistor_token) {
      fav_salon_id = [];
    } else {
      savedStrList = sharedPrefs.getStringList('salon_list');
      fav_salon_id = savedStrList.map((i) => int.parse(i)).toList();
    }
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
              backgroundColor: MassaraColor.primary_color,
              automaticallyImplyLeading: false,
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
            body: SafeArea(
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Wrap(
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
                                    salonPictures: widget.item.gallery,
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
                                                padding:
                                                EdgeInsets.only(right: 20),
                                                child: Text(
                                                  '${widget.item.name}',
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      color: Color(0xFF707070),
                                                      fontWeight:
                                                      FontWeight.bold,
                                                      fontSize: 18),
                                                ),
                                              ),
                                              Container(
                                                alignment: Alignment.center,
                                                //  padding: EdgeInsets.only(right: 20),
                                                child:
                                                HelperWidgets.ratingbar_fun(
                                                    5,
                                                    (widget.item.total_rate==null)?0.0:widget.item.total_rate
                                                        .value
                                                        .toDouble(),
                                                    18),
                                              ),
                                            ],
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 20),
                                            child: new Container(
                                                padding:
                                                EdgeInsets.only(top: 15.0),
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
                                                      BorderRadius.circular(
                                                          5.0),
                                                      side: BorderSide(
                                                        color:
                                                        MassaraColor.primary_color,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    color: MassaraColor.primary_color,
                                                    child: Text(
                                                      'احجز الان',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                          fontFamily: 'Cairo',
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                RerservationNow(
                                                                  token:
                                                                  widget.token,
                                                                  salon_id: widget
                                                                      .item.id,
                                                                  logo: widget
                                                                      .item.logo,
                                                                  name: widget
                                                                      .item.name,
                                                                  rate: (widget
                                                                      .item
                                                                      .total_rate==null)?0.0:widget
                                                                      .item
                                                                      .total_rate
                                                                      .value
                                                                      .toDouble(),
                                                                  home_services: widget
                                                                      .item
                                                                      .home_service,
                                                                  payment: widget
                                                                      .item.payment,
                                                                  salonPictures:
                                                                  widget.item
                                                                      .gallery,
                                                                  salon_list_type:
                                                                  3, //home-search-result-class
                                                                  item: widget.item,
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
                                        padding:
                                        EdgeInsets.only(right: 20, top: 5),
                                        child: Row(
                                          children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child:   Row(
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
                                                '${widget.item.address}',
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
                                                    color: Color(0xFF292929)),
                                              ),
                                            ),
                                            (widget.item.payment == 2)
                                                ? Row(
                                              children: <Widget>[
                                                Container(
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
                                                    Alignment.center,
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
                                              padding: EdgeInsets.only(
                                                  right: 10, left: 10),
                                              child: Container(

                                                alignment:
                                                Alignment.center,
                                                decoration: BoxDecoration(
                                                    color:
                                                    Color(0xFFDCDCDC),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(5)),
                                                child: Text(
                                                  (widget.item.payment ==
                                                      1)
                                                      ? '    اونلاين    '
                                                      : '   الدفع في المركز   ',
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
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
                                                    color: Color(0xFF292929)),
                                              ),
                                            ),
                                            (widget.item.home_service == 2)
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
                                                    Alignment.center,
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
                                                    Alignment.center,
                                                    decoration: BoxDecoration(
                                                        color: Color(
                                                            0xFFDCDCDC),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
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
                                              padding: EdgeInsets.only(
                                                  right: 10, left: 10),
                                              child: Container(
                                                width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                    4,
                                                alignment:
                                                Alignment.center,
                                                decoration: BoxDecoration(
                                                    color:
                                                    Color(0xFFDCDCDC),
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(5)),
                                                child: Text(
                                                  (widget.item.home_service ==
                                                      1)
                                                      ? 'فى البيت'
                                                      : ' فى المركز ',
                                                  style: TextStyle(
                                                      fontFamily: 'Cairo',
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
                                    borderRadius: BorderRadius.circular(30)),
                                child: (fav_salon_id.contains(widget.item.id))
                                    ? IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    size: 30,
                                    color: MassaraColor.primary_color,
                                  ),
                                  onPressed: () async {
                                    setState(() async {
                                      await ApiProvider
                                          .removeSalonFromFavourite(
                                          widget.token,
                                          widget.item.id,
                                          sharedPrefs
                                              .getInt('user_id'),
                                          context);
                                      await ApiProvider.getAllFavourits(
                                          widget.token,
                                          sharedPrefs.getInt('user_id'),
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
                                    color: MassaraColor.primary_color,
                                  ),
                                  onPressed: () {
                                    setState(() async {
                                      await ApiProvider
                                          .addSalonToFavourite(
                                          widget.token,
                                          widget.item.id,
                                          sharedPrefs
                                              .getInt('user_id'),
                                          context);
                                      await ApiProvider.getAllFavourits(
                                          widget.token,
                                          sharedPrefs.getInt('user_id'),
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
                  )
                ),
              ),
            )));
  }
}
