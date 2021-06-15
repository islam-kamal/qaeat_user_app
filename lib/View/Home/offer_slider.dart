import 'package:Qaeat/Custom_Widgets/export_file.dart';
import 'package:Qaeat/Model/offer_model.dart';
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
                print("offers : ${snapshot.data[0].banner}");
                return CarouselSlider.builder(
                  itemCount:
                  (snapshot.data.length > 4) ? 4 : snapshot.data.length,
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1.0,
                    aspectRatio: 1.5,
                    initialPage: 0,
                  ),
                  itemBuilder: (BuildContext context, index) {
                    double rate =
                    (snapshot.data[index].hall.totalRate == null)
                        ? 0.0
                        : snapshot.data[index].hall.totalRate.value
                        .toDouble();
                    return Wrap(
                      children: [
                        Container(
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              child: Stack(
                                children: <Widget>[
                                  Image.network(
                                    '${snapshot.data[index].banner}',
                                    width:MediaQuery.of(context).size.width ,
                                    height: MediaQuery.of(context).size.height /2,
                                    fit: BoxFit.fill,
                                  ),
                                  Stack(
                                    children: <Widget>[
                                      Image(
                                        height: MediaQuery.of(context).size.height /2,
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
                                                      3),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                            15),
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
                                                              color: QaeatColor.primary_color,
                                                              child: Text(
                                                                'المزيد  ',
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
                                                                        builder: (context) => OfferPage(
                                                                          token: widget.token,
                                                                        )
                                                                          /*  SalonicList(
                                                                              token: (sharedPrefs.getString('user_access_token') == null)
                                                                                  ? StaticMethods.vistor_token
                                                                                  : sharedPrefs.getString('user_access_token'),
                                                                              hall_id:
                                                                              snapshot.data[index].hall.id,
                                                                            )*/));
                                                              },
                                                            ),
                                                          )),
                                                    ),
                                                  ),
                                                      Spacer(),
                                                  Container(
                                                      padding: EdgeInsets.only(
                                                          right: MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                              15),
                                                      child:Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.center,
                                                        children: <Widget>[
                                                          Text(
                                                            '${ snapshot.data[index].hall.name}',
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontFamily: 'Cairo',
                                                                fontWeight: FontWeight.bold),
                                                          ),
                                                          HelperWidgets.ratingbar_fun(
                                                              5, rate, 15),

                                                          /*  Container(
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
                                                      ),*/

                                                        ],
                                                      )),


                                                ],
                                              )



                                          ),

                                        /*  Container(
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
                                                  color:QaeatColor.primary_color,
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
                                              ))*/
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius
                                .circular(30)
                          ),
                        )
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
                          'images/splash_screen/Qaeat_logo.png'),
                      fit: BoxFit.fill,
                    ),


                  ),
                );
              }
            }
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                strokeWidth: 0,
              ),
            );
          },
        ),
      ],
    );
  }
}
