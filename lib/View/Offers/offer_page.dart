import 'package:Massara/Custom_Widgets/export_file.dart';
import 'package:Massara/Model/offer_model.dart';
import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';


class OfferPage extends StatefulWidget {
  final String token;
  OfferPage({this.token});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OfferPage_state();
  }
}

class OfferPage_state extends State<OfferPage> {
  int _currentIndex;
  var style = TextStyle(fontFamily: 'Cairo');
  SharedPreferences sharedPrefs;
  Future<List<OfferModel>> offerList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = 3;
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
      });
    });
    if (widget.token == StaticMethods.vistor_token) {
      offerList = null;
    } else {
      offerList = ApiProvider.getOfferList(widget.token, context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    offerList = null;
    ('offer page dispose');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              'العروض',
              style: TextStyle(fontFamily: 'Cairo',color: Colors.white),
            ),
            backgroundColor: MassaraColor.primary_color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigation(
            index: _currentIndex,
          ),
          body: (offerList == null )
              ? VistorMessage() : FutureBuilder<List<OfferModel>>(
            future: offerList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  if (snapshot.data.length != 0) {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, index) {
                          double rate = (snapshot.data[index].salons
                              .total_rate ==
                              null)
                              ? 0.0
                              : snapshot
                              .data[index].salons.total_rate.value
                              .toDouble();

                          return Container(
                              padding: EdgeInsets.only(
                                  top: 10,
                                  right: 10,
                                  left: 10,
                                  bottom: 0),
                              height:
                              MediaQuery.of(context).size.width / 1.8,
                              child: Card(
                                clipBehavior: Clip.hardEdge,
                                child: Stack(
                                  children: <Widget>[
                                    Image.network(
                                      '${snapshot.data[index].banner}',
                                      height: MediaQuery.of(context)
                                          .size
                                          .width /
                                          1.8,
                                      width:MediaQuery.of(context).size.width ,
                                      fit: BoxFit.none,
                                    ),
                                    Stack(
                                      children: <Widget>[
                                        Image(
                                          height: MediaQuery.of(context)
                                              .size
                                              .width /
                                              1.7,
                                          image: AssetImage(
                                              'images/offer/sa1.png'),
                                          fit: BoxFit.cover,
                                        ),
                                        Stack(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(
                                                      context)
                                                      .size
                                                      .width /
                                                      11),
                                              alignment:
                                              Alignment.bottomCenter,
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .center,
                                                children: <Widget>[
                                                  Text(
                                                    '${snapshot.data[index].salons.name}',
                                                    style: TextStyle(
                                                        color:
                                                        Colors.white,
                                                        fontFamily:
                                                        'Cairo',
                                                        fontWeight:
                                                        FontWeight
                                                            .bold),
                                                  ),
                                                  HelperWidgets
                                                      .ratingbar_fun(
                                                      5, rate, 15),
                                                  Container(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                      children: <Widget>[
                                                        Text(
                                                          '${snapshot.data[index].salons.address}',
                                                          style:
                                                          TextStyle(
                                                            color: Colors
                                                                .white,
                                                            fontFamily:
                                                            'Cairo',
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 15,
                                                        ),
                                                        Icon(
                                                          Icons
                                                              .location_on,
                                                          color: Colors
                                                              .white,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.only(
                                                      top: 5,
                                                    ),
                                                    child: Builder(
                                                      builder: (ctx) =>
                                                      new Container(
                                                          padding:
                                                          EdgeInsets
                                                              .only(
                                                            top: 5.0,
                                                            right: 10,
                                                            left: 10,
                                                          ),
                                                          alignment:
                                                          Alignment
                                                              .center,
                                                          child:
                                                          ButtonTheme(
                                                            child:
                                                            RaisedButton(
                                                              shape:
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(5.0),
                                                              ),
                                                              color: MassaraColor.primary_color,
                                                              child:
                                                              Text(
                                                                'اذهب الى الصالون   ',
                                                                style: TextStyle(
                                                                    color: Colors.white,
                                                                    fontFamily: 'Cairo',
                                                                    fontWeight: FontWeight.normal),
                                                                textAlign:
                                                                TextAlign.center,
                                                              ),
                                                              onPressed:
                                                                  () {
                                                                Navigator.pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => SalonicList(
                                                                          token: widget.token,
                                                                          salon_id: snapshot.data[index].salons.id,
                                                                        )));
                                                              },
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                                height:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                    6,
                                                width:
                                                MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                    6,
                                                padding: EdgeInsets.only(
                                                    top: 2,
                                                    bottom: 2,
                                                    right: 10,
                                                    left: 10),
                                                margin: EdgeInsets.only(
                                                    left: 15),
                                                decoration: BoxDecoration(
                                                    color:
                                                    MassaraColor.primary_color,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(5)),
                                                child: Column(
                                                  children: <Widget>[
                                                    Text(
                                                      'خصم',
                                                      style: TextStyle(
                                                          fontFamily:
                                                          'Cairo',
                                                          color:Colors.white),
                                                    ),
                                                    Text(
                                                      '%${snapshot.data[index].discount}',
                                                      style: TextStyle(
                                                          fontFamily:
                                                          'Cairo',
                                                          color:Colors.white),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ));
                        });
                  } else {
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              width:
                              MediaQuery.of(context).size.width / 2,

                              image: AssetImage(
                                  'images/splash_screen/massara_logo.png'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'لا يوجد عروض  حاليا ',
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
                            image: AssetImage(
                                'images/splash_screen/massara_logo.png'),
                            width:
                            MediaQuery.of(context).size.width / 2,
                            height:
                            MediaQuery.of(context).size.width / 2,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'لا يوجد عروض  حاليا ',
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
        ));
  }
}
