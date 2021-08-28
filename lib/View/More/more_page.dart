import 'file:///D:/Wothoq%20Tech/qaeat/code/qaeat_user_app/lib/Custom_Widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:Qaeat/Custom_Widgets/export_file.dart';
import 'package:Qaeat/View/More/invoices.dart';
import 'package:Qaeat/View/More/mycards.dart';

import 'contact_us.dart';
import 'customer_service_complain.dart';
import 'customer_services.dart';

class MorePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MorePageState();
  }
}

class MorePageState extends State<MorePage> {
  int _currentIndex;
  static var style = TextStyle(fontFamily: 'Cairo');
  SharedPreferences sharedPrefs;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = 0;
    SharedPreferences.getInstance().then((prefs) {
      sharedPrefs = prefs;
    });

  }

  List data = [
  //  ['بحث متقدم', 'images/more/search_icon.png'],
    ['تحديث الحساب', 'images/more/user.png'],
    ['حجوزاتي', 'images/more/calendar.png'],
    ['المفضلة', 'images/favourite/favourite.png'],
    ['فواتيري','images/more/invoices.png'],
    ['بطاقاتي','images/more/credit-card.png'],
    ['الدعم الفني', 'images/more/sport-team.png'],
    ['تسجيل خروج', 'images/more/logout.png'],
  ];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
             Padding(padding: EdgeInsets.only(right: 20,top: 10),
             child:  Text(
               'المزيد',
               style: TextStyle(fontFamily: 'Cairo',fontWeight: FontWeight.normal,fontSize: 16),
             ),)
            ],

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
          body: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                children: [
                  ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[

                                      Container(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Text(
                                          data[index][0],
                                          style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),

                                      index == 6 ?Container():  Icon(Icons.arrow_forward_ios)
                                    ],
                                  ),
                                  onTap: () async {
                                    switch (index) {
                                    /*   case 0:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdvancedSearchPage(
                                                token: (sharedPrefs.getString(
                                                    'user_access_token') ==
                                                    null)
                                                    ? StaticMethods.vistor_token
                                                    : sharedPrefs.getString(
                                                    'user_access_token'))));
                                    break;*/
                                      case 0:
                                        int shared_id = sharedPrefs.getInt('user_id');
                                        String shared_name =
                                        sharedPrefs.getString('user_name');
                                        String shared_email =
                                        sharedPrefs.getString('user_email');
                                        String shared_mobile =
                                        sharedPrefs.getString('user_mobile');
                                        String shared_token =
                                        sharedPrefs.getString('user_access_token');
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => EditUser(
                                                  shared_id: shared_id,
                                                  shared_name: shared_name,
                                                  shared_email: shared_email,
                                                  shared_mobile: shared_mobile,
                                                  shared_token: shared_token,
                                                )));

                                        break;
                                      case 1:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MyReservation(
                                                    token: (sharedPrefs.getString(
                                                        'user_access_token') ==
                                                        null)
                                                        ? StaticMethods.vistor_token
                                                        : sharedPrefs.getString(
                                                        'user_access_token'),
                                                    user_id:
                                                    sharedPrefs.getInt('user_id'))));
                                        break;
                                      case 2:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => FavouriteList(
                                                    token: (sharedPrefs.getString(
                                                        'user_access_token') ==
                                                        null)
                                                        ? StaticMethods.vistor_token
                                                        : sharedPrefs.getString(
                                                        'user_access_token'),
                                                    user_id:
                                                    sharedPrefs.getInt('user_id'))));
                                        break;
                                      case 3:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Invoices(
                                                    token: (sharedPrefs.getString(
                                                        'user_access_token') ==
                                                        null)
                                                        ? StaticMethods.vistor_token
                                                        : sharedPrefs.getString(
                                                        'user_access_token'),
                                                    user_id: sharedPrefs.getInt('user_id'))));
                                        break;
                                      case 4:
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => MyCards(
                                                    token: (sharedPrefs.getString(
                                                        'user_access_token') ==
                                                        null)
                                                        ? StaticMethods.vistor_token
                                                        : sharedPrefs.getString(
                                                        'user_access_token'),
                                                    user_id:
                                                    sharedPrefs.getInt('user_id'))));
                                        break;
                                    /*   case 5:
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ContactUs(
                                              token: (sharedPrefs.getString(
                                                  'user_access_token') ==
                                                  null)
                                                  ? StaticMethods.vistor_token
                                                  : sharedPrefs.getString(
                                                  'user_access_token'),
                                            )));
                                    break;*/
                                      case 5:
                                        if (StaticMethods.customer_care_value == 0) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CustomerServiceComplain(
                                                          token: (sharedPrefs.getString(
                                                              'user_access_token') ==
                                                              null)
                                                              ? StaticMethods.vistor_token
                                                              : sharedPrefs.getString(
                                                              'user_access_token'),
                                                          user_id: sharedPrefs
                                                              .getInt('user_id'))));
                                        } else if (StaticMethods.customer_care_value ==
                                            1) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => CustomerServices(
                                                      token: (sharedPrefs.getString(
                                                          'user_access_token') ==
                                                          null)
                                                          ? StaticMethods.vistor_token
                                                          : sharedPrefs.getString(
                                                          'user_access_token'),
                                                      user_id: sharedPrefs
                                                          .getInt('user_id'))));
                                        }

                                        break;
                                      case 6:
                                        ('logout : ${sharedPrefs.getString('user_access_token')}');
                                        if (sharedPrefs.getString('user_access_token') == null) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => UserSignIn()));
                                        } else {
                                          await ApiProvider.sigOut(
                                              sharedPrefs.getString('user_access_token'),
                                              context);
                                        }

                                        break;
                                    }
                                  },
                                ),
                                index == 6 ?Container():    Padding(padding: EdgeInsets.all(5),
                                child: Divider(
                                  height: 5,
                                  indent: 5,
                                  endIndent: 5,
                                ),)
                              ],
                            ));
                      }),
                  SizedBox(height: MediaQuery.of(context).size.width /10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.only(right: 10, left: 10,top: 15, bottom: 15),
                          child:    Card(
                            color: Color(0xFFF6F6F6),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Icon(Icons.email_outlined,
                                color: QaeatColor.primary_color,
                                size: MediaQuery.of(context).size.width / 14,
                              )
                            ),
                          ),
                        ),
                        onTap: () {
                          _launchURL(
                              'mailto:qaeats@gmail.com');

                        },
                      ),
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.only(right: 10, left: 10,top: 15, bottom: 15),

                          child:    Card(
                            color: Color(0xFFF6F6F6),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Image.asset(
                                'images/more/phone.png',
                                color: QaeatColor.primary_color,
                                width: MediaQuery.of(context).size.width / 14,
                                height: MediaQuery.of(context).size.width / 14,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          _launchURL(
                              'tel:+966532963553');

                        },
                      ),
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.only(right: 10, left: 10,top: 15, bottom: 15),

                          child:    Card(
                            color: Color(0xFFF6F6F6),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Image.asset(
                                'images/more/whatsapp.png',
                                color: QaeatColor.primary_color,

                                width: MediaQuery.of(context).size.width / 14,
                                height: MediaQuery.of(context).size.width / 14,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          _launchURL(
                              'whatsapp://send?phone=+966532963553');

                        },
                      ),
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.only(right: 10, left: 10,top: 15, bottom: 15),

                          child:    Card(
                            color: Color(0xFFF6F6F6),
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Image.asset(
                                'images/more/twitter.png',
                                color: QaeatColor.primary_color,

                                width: MediaQuery.of(context).size.width / 14,
                                height: MediaQuery.of(context).size.width / 14,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          _launchURL("https://twitter.com/qaeats?s=09");

                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
