import 'package:Massara/Custom_Widgets/export_file.dart';
import 'package:Massara/Model/offer_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


class OfferSlider extends StatefulWidget {
  final String token;
  OfferSlider({this.token});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OfferSliderState();
  }
}

class OfferSliderState extends State<OfferSlider> {
  SharedPreferences sharedPrefs;
  int _currentIndex = 0;
  Future<List<OfferModel>> offerList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
      });
    });
    offerList = ApiProvider.getOfferList(widget.token, context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    offerList = null;
    ('offer dispose');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FutureBuilder<List<OfferModel>>(
          future: offerList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return CarouselSlider.builder(
                  itemCount:
                  (snapshot.data.length > 4) ? 4 : snapshot.data.length,
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                    aspectRatio: 2.0,
                    initialPage: 0,
                  ),
                  itemBuilder: (BuildContext context, index) {
                    double rate =
                    (snapshot.data[index].salons.total_rate == null)
                        ? 0.0
                        : snapshot.data[index].salons.total_rate.value
                        .toDouble();
                    return Wrap(
                      children: [
                        Container(
                          //  padding: EdgeInsets.all(10),
                          // height: MediaQuery.of(context).size.width / 1.4,
                            child: Card(
                              clipBehavior: Clip.hardEdge,
                              child: Stack(
                                children: <Widget>[
                                  Image.network(
                                    '${snapshot.data[index].banner}',
                                    height: MediaQuery.of(context).size.width / 1.7,
                                    width:MediaQuery.of(context).size.width ,
                                    //   image: AssetImage('images/offer/sa.jpg'),
                                    fit: BoxFit.none,
                                  ),
                                  Stack(
                                    children: <Widget>[
                                      Image(
                                        height: MediaQuery.of(context).size.width / 1.7,
                                        width:MediaQuery.of(context).size.width ,
                                        image: AssetImage('images/offer/sa1.png'),
                                        fit: BoxFit.cover,
                                      ),
                                      Stack(
                                        children: <Widget>[
                                          Container(
                                              padding: EdgeInsets.only(
                                                  top: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                      16),
                                              alignment: Alignment.bottomCenter,
                                              child: Wrap(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Text(
                                                        '${snapshot.data[index].salons.name}',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: 'Cairo',
                                                            fontWeight: FontWeight.bold),
                                                      ),
                                                      HelperWidgets.ratingbar_fun(
                                                          5, rate, 15),

                                                      Container(
                                                        child: Wrap(
                                                          children: <Widget>[
                                                            Text(
                                                              '${snapshot.data[index].salons.address}',
                                                              style: TextStyle(
                                                                color: Colors.white,
                                                                fontFamily: 'Cairo',
                                                              ),
                                                            ),

                                                            Icon(
                                                              Icons.location_on,
                                                              color: Colors.white,
                                                            ),
                                                            SizedBox(
                                                              width: 15,
                                                            )

                                                          ],
                                                        ),
                                                      ),



                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            top: 3,
                                                            bottom: 10
                                                        ),
                                                        child: Builder(
                                                          builder: (ctx) => new Container(
                                                              padding: EdgeInsets.only(
                                                                top: 5.0,
                                                                right: 10,
                                                                left: 10,
                                                              ),
                                                              alignment: Alignment.center,
                                                              child: ButtonTheme(
                                                                child: RaisedButton(
                                                                  shape:
                                                                  RoundedRectangleBorder(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                        5.0),
                                                                  ),
                                                                  color: MassaraColor.primary_color,
                                                                  child: Text(
                                                                    'اذهب الى الصالون   ',
                                                                    style: TextStyle(
                                                                        color:
                                                                        Colors.white,
                                                                        fontFamily:
                                                                        'Cairo',
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                                    textAlign:
                                                                    TextAlign.center,
                                                                  ),
                                                                  onPressed: () {
                                                                    Navigator
                                                                        .pushReplacement(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                SalonicList(
                                                                                  token: (sharedPrefs.getString('user_access_token') == null)
                                                                                      ? StaticMethods.vistor_token
                                                                                      : sharedPrefs.getString('user_access_token'),
                                                                                  salon_id:
                                                                                  snapshot.data[index].salon_id,
                                                                                )));
                                                                  },
                                                                ),
                                                              )),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              )
                                          ),
                                          Container(
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  6,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                                  6,
                                              padding: EdgeInsets.only(
                                                  top: 0,
                                                  bottom: 0,
                                                  right: 10,
                                                  left: 10),
                                              margin: EdgeInsets.only(left: 15),
                                              decoration: BoxDecoration(
                                                  color:MassaraColor.primary_color,
                                                  borderRadius:
                                                  BorderRadius.circular(5)),
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    'خصم',
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    '%${snapshot.data[index].discount}',
                                                    style: TextStyle(
                                                        fontFamily: 'Cairo',
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ))
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ))
                      ],
                    );
                  },
                )
                ;
              } else {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    alignment: Alignment.center,
                    child:
                    Image(
                      width:
                      MediaQuery.of(context).size.width ,
                      image: AssetImage(
                          'images/splash_screen/massara_logo.png'),
                      fit: BoxFit.fill,
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
      ],
    );
  }
}
