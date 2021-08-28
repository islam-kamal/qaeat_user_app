import 'package:Qaeat/Custom_Widgets/export_file.dart';
import 'package:Qaeat/Model/offer_model.dart';
import 'package:Qaeat/View/Hall_Details/hall_details.dart';
import 'file:///D:/Wothoq%20Tech/qaeat/code/qaeat_user_app/lib/Custom_Widgets/custom_bottom_navigation_bar.dart';
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
            backgroundColor: QaeatColor.primary_color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomNavigationBar(
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
                          double rate = ( snapshot.data[index].hall
                              .totalRate ==
                              null)
                              ? 0.0
                              : snapshot.data[index].hall
                              .totalRate.value
                              .toDouble();

                          return Container(
                              padding: EdgeInsets.only(
                                  top: 10,
                                  right: 10,
                                  left: 10,
                                  bottom: 0),
                              height:
                              MediaQuery.of(context).size.width / 1.8,
                              child: InkWell(
                                onTap: (){
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => HallDetails(
                                            token: widget.token,
                                            hall_id: snapshot.data[index].hall.id,
                                            route: 2,
                                          )));
                                },
                                child:  Card(
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
                                            height: MediaQuery.of(context).size.width / 1.7,
                                            image: AssetImage('images/offer/sa1.png'),
                                            fit: BoxFit.cover,
                                          ),
                                          Stack(
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.only(
                                                    top: MediaQuery.of(context).size.width / 4),
                                                alignment:
                                                Alignment.bottomRight,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: EdgeInsets.only(right:MediaQuery.of(context).size.width / 14),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.end,
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          HelperWidgets
                                                              .ratingbar_fun(
                                                              5, rate, 15),
                                                          SizedBox(width:  MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width /
                                                              14,),
                                                          Text(
                                                            '${snapshot.data[index].hall.name}',
                                                            style: TextStyle(
                                                                color:
                                                                Colors.white,
                                                                fontFamily:
                                                                'Cairo',
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(right:MediaQuery.of(
                                                          context)
                                                          .size
                                                          .width /
                                                          14),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .end,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .end,
                                                        children: <Widget>[
                                                          Text(
                                                            '${snapshot.data[index].hall.address}',
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
                                                      QaeatColor.primary_color,
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
                                ),
                              )

                             );
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
                                  'images/splash_screen/Qaeat_logo.png'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'لا يوجد عروض  حاليا ',
                              style: TextStyle(
                                  fontFamily: 'Cairo',
                                  color: QaeatColor.primary_color,
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
                                'images/splash_screen/Qaeat_logo.png'),
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
                                color: QaeatColor.primary_color,
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
