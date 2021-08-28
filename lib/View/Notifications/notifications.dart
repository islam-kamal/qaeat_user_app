import 'file:///D:/Wothoq%20Tech/qaeat/code/qaeat_user_app/lib/Custom_Widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Qaeat/Custom_Widgets/export_file.dart';
import 'package:Qaeat/View/Notifications/notification_model.dart';

class Notifications extends StatefulWidget {
  final String token;
  final int user_id;
  Notifications({this.token, this.user_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Notifications_state();
  }
}

class Notifications_state extends State<Notifications> {
  bool notifications_found = true;
  var style = TextStyle(fontFamily: 'Cairo');
  int _currentIndex;
  Future<List<NotificationModel>> notificationsList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = 2;
    if (widget.token == StaticMethods.vistor_token) {
      notificationsList = null;
    } else {
      notificationsList = ApiProvider.getUserNotifications(
          widget.token, widget.user_id, context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    notificationsList = null;
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
              'الاشعارات',
              style: TextStyle(fontFamily: 'Cairo'),
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
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: (notificationsList == null)
                ? VistorMessage()
                : FutureBuilder<List<NotificationModel>>(
                    future: notificationsList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length != 0) {
                            return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Container(
                                      padding: EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width,
                                      //height:  MediaQuery.of(context).size.width/3,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                              flex: 2,
                                              child: Container(
                                                child: Image(
                                                  //width:MediaQuery.of(context).size.width/8 ,
                                                  image: AssetImage(
                                                      'images/splash_screen/Qaeat_logo.png'),
                                                  fit: BoxFit.fitHeight,
                                                  alignment: Alignment.topCenter,
                                                ),
                                              )
                                          ),
                                          Expanded(
                                              flex: 6,
                                              child: Container(
                                                padding:
                                                    EdgeInsets.only(right: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      '${(snapshot.data[index].hall == null) ? ' ' : snapshot.data[index].hall.name}',
                                                      style: TextStyle(
                                                          fontFamily: 'Cairo',
                                                          fontSize: 14),
                                                    ),
                                                    Text(
                                                      '${(snapshot.data[index].title == null) ? ' ' : snapshot.data[index].title}',
                                                      style: TextStyle(
                                                          fontFamily: 'Cairo',
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      '${(snapshot.data[index].message == null) ? ' ' : snapshot.data[index].message}',
                                                      style: TextStyle(
                                                          fontFamily: 'Cairo',
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          Expanded(
                                              flex: 3,
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                      padding: EdgeInsets.only(
                                                          top: 7),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons.access_time,
                                                              color: Color(
                                                                  0xFF292929),
                                                              size: 15,
                                                            ),
                                                            SizedBox(
                                                              width: 3,
                                                            ),
                                                            Text(
                                                              ' ${snapshot.data[index].time}',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF292929),
                                                                fontFamily:
                                                                    'Cairo',
                                                                fontSize: 12
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  InkWell(
                                                    child: Image(
                                                      image: AssetImage(
                                                          'images/notifications/delete1.png'),
                                                      fit: BoxFit.cover,
                                                      width: 20,
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        ApiProvider
                                                            .deleteNotification(
                                                                widget.token,
                                                                snapshot
                                                                    .data[index]
                                                                    .id,
                                                                context);
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    super
                                                                        .widget));
                                                      });

                                                      // delete one notification
                                                    },
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
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
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(60),
                                          color: QaeatColor.primary_color
                                      ),
                                      child: Icon(Icons.notifications,color: Colors.yellow,),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'لا يوجد اشعارات',
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
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(60),
                                        color: QaeatColor.primary_color
                                    ),
                                    child: Icon(Icons.notifications,color: Colors.yellow,),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'لا يوجد اشعارات',
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
          ),
        ));
  }
}
