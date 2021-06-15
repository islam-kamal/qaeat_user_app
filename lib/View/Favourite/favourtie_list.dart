import 'package:flutter/material.dart';
import 'package:Qaeat/Custom_Widgets/export_file.dart';
import 'package:Qaeat/Model/favourite_model.dart';
import 'package:Qaeat/View/Favourite/favourite_slider.dart';

class FavouriteList extends StatefulWidget {
  final String token;
  final int user_id;
  FavouriteList({this.token, this.user_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FavouriteListState();
  }
}

class FavouriteListState extends State<FavouriteList> {
  bool internet = true;
  Future<List<FavouriteModel>> favourits;
  SharedPreferences sharedPrefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
      });
    });
    if (widget.token == StaticMethods.vistor_token) {
      favourits = null;
    } else {
      favourits =
          ApiProvider.getAllFavourits(widget.token, widget.user_id, context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    favourits = null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MorePage()));
      },
      child: Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            alignment: Alignment.centerRight,
            child: Text(
              'المفضله',
              style: TextStyle(
                  fontFamily: 'Cairo', color: Colors.white, fontSize: 16),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => MorePage()));
              },
              child: Icon(Icons.arrow_forward_ios),
            )
          ],
          backgroundColor: QaeatColor.primary_color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
        ),
        body: (favourits == null)
            ? VistorMessage()
            : FutureBuilder<List<FavouriteModel>>(
                future: favourits = ApiProvider.getAllFavourits(
                    widget.token, widget.user_id, context),
                builder: (BuildContext context, snapshot) {
                  ('test 1');
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length != 0) {
                        return Directionality(
                            textDirection: TextDirection.rtl,
                            child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, index) {
                                  List<String> galleries = new List<String>();
                                  double rate = (snapshot.data[index].halls
                                              .total_rate==
                                          null)
                                      ? 0.0
                                      : snapshot
                                          .data[index].halls.total_rate.value
                                          .toDouble();
                                  snapshot.data[index].halls.gallery
                                      .forEach((element) {
                                    galleries.add(element.photo);
                                  });
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              2,
                                      child: Stack(
                                        alignment: Alignment.topLeft,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 20, left: 5, right: 5),
                                            child: Card(
                                              shape: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                borderSide: BorderSide(
                                                    color: Color(0xFFDCDCDC)),
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  MyFavouriteSlider(galleries),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Expanded(
                                                          flex: 4,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right:
                                                                            20),
                                                                child: Text(
                                                                  '${snapshot.data[index].halls.name}',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          'Cairo',
                                                                      color: Color(
                                                                          0xFF707070),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ),
                                                              Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      padding: EdgeInsets.only(
                                                                          right:
                                                                              20),
                                                                      child: HelperWidgets
                                                                          .ratingbar_fun(
                                                                              5,
                                                                              rate,
                                                                              20),
                                                                    )
                                                                  ])
                                                            ],
                                                          )),
                                                      Expanded(
                                                          flex: 3,
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10),
                                                            child:
                                                                new Container(
                                                                    padding: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                15.0),
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child:
                                                                        ButtonTheme(
                                                                      minWidth: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      child:
                                                                          RaisedButton(
                                                                        shape:
                                                                            RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(5.0),
                                                                          side:
                                                                              BorderSide(
                                                                            color:
                                                                                QaeatColor.primary_color,
                                                                            width:
                                                                                1.0,
                                                                          ),
                                                                        ),
                                                                        color: QaeatColor.primary_color,
                                                                        child:
                                                                            Text(
                                                                          'المزيد',
                                                                          style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 14.0,
                                                                              fontFamily: 'Cairo',
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pushReplacement(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => SalonicList(
                                                                                        token: widget.token,
                                                                                        hall_id: snapshot.data[index].halls.id,
                                                                                      )));
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
                                                            EdgeInsets.only(
                                                                right: 20),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Expanded(
                                                              flex: 1,
                                                              child:  Icon(
                                                                Icons.location_on,
                                                                color: Color(
                                                                    0xFF292929),
                                                              ) ,
                                                            ),
                                                            Expanded(
                                                              flex: 6,
                                                              child:  Text(
                                                                '${snapshot.data[index].halls.address}',
                                                                style: TextStyle(
                                                                  color: Color(
                                                                      0xFF292929),
                                                                  fontFamily:
                                                                  'Cairo',
                                                                ),
                                                              ),
                                                            )

                                                           ,
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
                                              padding:
                                                  EdgeInsets.only(left: 30),
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.favorite,
                                                      size: 30,
                                                      color: QaeatColor.primary_color,
                                                    ),
                                                    onPressed: () {
                                                      (
                                                          'user: ${widget.user_id}');
                                                      ApiProvider
                                                          .removeSalonFromFavourite(
                                                              widget.token,
                                                              snapshot
                                                                  .data[index]
                                                                  .halls
                                                                  .id,
                                                              widget.user_id,
                                                              context);
                                                      (
                                                          'favourite 1111111111');
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  super
                                                                      .widget));
                                                    },
                                                  )))
                                        ],
                                      ));
                                }));
                      } else {
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.favorite,
                                  size: 80,
                                  color: QaeatColor.secondary_color,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  'لا يوجد شئ فى المفضله',
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
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
      ),
    );
  }
}
