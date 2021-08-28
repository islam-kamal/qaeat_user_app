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
  int _current = 0;
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
                return Stack(
                  children: [
                    CarouselSlider.builder(
                      itemCount:
                      (snapshot.data.length > 4) ? 4 : snapshot.data.length,
                      options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        height: MediaQuery.of(context).size.height * 0.4,
                        viewportFraction: 1,

                        aspectRatio: 1.5,
                        initialPage: 0,
                        onPageChanged: (index, reason){
                          setState(() {
                            _current = index;
                          });
                        }
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
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(35)
                                      ),
                                      child: Image.network(
                                        '${snapshot.data[index].banner}',
                                        width:MediaQuery.of(context).size.width ,
                                        height: MediaQuery.of(context).size.height * 0.4,
                                        fit: BoxFit.fill,
                                      ),

                                    ),

                                    Stack(
                                      children: <Widget>[
                                        Container(
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35)
                        ),
                        child:Image(
                          height: MediaQuery.of(context).size.height * 0.4,
                                          width:MediaQuery.of(context).size.width ,
                                          image: AssetImage('images/offer/sa1.png'),
                                          fit: BoxFit.fill,
                        ) ),
                                        Stack(

                                          children: <Widget>[
                                            Container(
                                                padding: EdgeInsets.only(
                                                    top: MediaQuery.of(context).size.width / 2.1),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: MediaQuery.of(context).size.width / 15),
                                                      child: Builder(
                                                        builder: (ctx) => new Container(
                                                            padding: EdgeInsets.only(top: 5.0, right: 5, left: 5,
                                                            ),
                                                            alignment: Alignment.center,
                                                            child: ButtonTheme(

                                                              child: RaisedButton(
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(5.0),),
                                                                color: QaeatColor.primary_color,
                                                                child: Text(
                                                                  'المزيد  ',
                                                                  style: TextStyle(color:
                                                                  Colors.white, fontFamily:
                                                                  'Cairo', fontWeight: FontWeight.normal),
                                                                  textAlign: TextAlign.center,
                                                                ),

                                                                onPressed: () {
                                                                  Navigator
                                                                      .pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) => OfferPage(
                                                                            token: widget.token,
                                                                          )
                                                                      ));
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

                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(35.0),bottomRight:Radius.circular(35.0)),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25)
                              ),
                            )
                          ],
                        );
                      },
                    ),
                    Positioned(
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: snapshot.data.map((url) {
                        int index = snapshot.data.indexOf(url);
                        return Container(
                          width: 12.0,
                          height: 6.0,
                          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == index
                                ? QaeatColor.primary_color
                                : QaeatColor.white_color,
                          ),
                        );
                      }).toList(),
                    ),
                      bottom: 35,
                      right: 20,
                      left: 20,
                    )
                  ],
                );
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
