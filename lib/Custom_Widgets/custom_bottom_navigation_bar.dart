import 'package:Qaeat/Custom_Widgets/export_file.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';



class CustomBottomNavigationBar extends StatefulWidget {
  int index;

  CustomBottomNavigationBar({this.index});
  @override
  _CustomBottomNavigationBarState createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _currentIndex = 0;
  int _counter = 0;
  var style = TextStyle(fontFamily: 'Cairo');
  SharedPreferences sharedPrefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  BottomNavyBar(
        selectedIndex: widget.index,
        showElevation: true,
        itemCornerRadius: 100,
        curve: Curves.easeIn,
        backgroundColor: QaeatColor.white_color,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        containerHeight: MediaQuery.of(context).size.width * 0.13,
        onItemSelected: (index) => setState((){
          _currentIndex = index;
          switch (index) {
            case 0:
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return MorePage();
                  },
                  transitionsBuilder:
                      (context, animation8, animation15, child) {
                    return FadeTransition(
                      opacity: animation8,
                      child: child,
                    );
                  },
                  transitionDuration: Duration(milliseconds: 5),
                ),
              );
              break;
            case 1:
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return OrdersPage(
                        token:
                        (sharedPrefs.getString('user_access_token') == null)
                            ? StaticMethods.vistor_token
                            : sharedPrefs.getString('user_access_token'),
                        user_id: sharedPrefs.getInt('user_id'));
                  },
                  transitionsBuilder:
                      (context, animation8, animation15, child) {
                    return FadeTransition(
                      opacity: animation8,
                      child: child,
                    );
                  },
                  transitionDuration: Duration(milliseconds: 5),
                ),
              );
              break;
            case 2:
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return  Notifications(
                        token:
                        (sharedPrefs.getString('user_access_token') == null)
                            ? StaticMethods.vistor_token
                            : sharedPrefs.getString('user_access_token'),
                        user_id: sharedPrefs.getInt('user_id'));
                  },
                  transitionsBuilder:
                      (context, animation8, animation15, child) {
                    return FadeTransition(
                      opacity: animation8,
                      child: child,
                    );
                  },
                  transitionDuration: Duration(milliseconds: 5),
                ),
              );
              break;
            case 3:
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return OfferPage(
                      token:
                      (sharedPrefs.getString('user_access_token') == null)
                          ? StaticMethods.vistor_token
                          : sharedPrefs.getString('user_access_token'),
                    );
                  },
                  transitionsBuilder:
                      (context, animation8, animation15, child) {
                    return FadeTransition(
                      opacity: animation8,
                      child: child,
                    );
                  },
                  transitionDuration: Duration(milliseconds: 5),
                ),
              );
              break;
            case 4:
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) {
                    return HomePage(
                      token:
                      (sharedPrefs.getString('user_access_token') == null)
                          ? StaticMethods.vistor_token
                          : sharedPrefs.getString('user_access_token'),
                    );
                  },
                  transitionsBuilder:
                      (context, animation8, animation15, child) {
                    return FadeTransition(
                      opacity: animation8,
                      child: child,
                    );
                  },
                  transitionDuration: Duration(milliseconds: 5),
                ),
              );

              break;
          }
        }),
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(
              Icons.menu,
              color: widget.index==0? QaeatColor.white_color : QaeatColor.black_color,
            ),
            title: Text("المزيد",style: TextStyle(color: QaeatColor.white_color),),
            activeColor: QaeatColor.primary_color,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: Icon(
              Icons.shopping_cart,
              color: widget.index==1? QaeatColor.white_color : QaeatColor.black_color,

            ),/*Image(
              image: AssetImage('images/home/shopping-cart.png'),
              color: widget.index==1? QaeatColor.white_color : QaeatColor.black_color,
            ),*/
            title: Text("طلباتى",style: TextStyle(color: QaeatColor.white_color)),
            activeColor: QaeatColor.primary_color,
            textAlign: TextAlign.center,

          ),

          BottomNavyBarItem(
            icon: Icon(
              Icons.notifications,
              color: widget.index==2? QaeatColor.white_color : QaeatColor.black_color,

            ),/*Image(
              image: AssetImage('images/home/bell.png'),
              color: widget.index==2? QaeatColor.white_color : QaeatColor.black_color,
            ),*/
            title: Text(
              "الاشعارات",style: TextStyle(color: QaeatColor.white_color),
            ),
            activeColor: QaeatColor.primary_color,
            textAlign: TextAlign.center,

          ),
          BottomNavyBarItem(
            icon:Icon(
              Icons.campaign,
              color: widget.index==3? QaeatColor.white_color : QaeatColor.black_color,
            ), /*Image(
              image: AssetImage('images/home/notification.png',),
              color: widget.index==3? QaeatColor.white_color : QaeatColor.black_color,
            ),*/
            title: Text( "العروض",style: TextStyle(color: QaeatColor.white_color)),
            activeColor:QaeatColor.primary_color,
            textAlign: TextAlign.center,
          ),

          BottomNavyBarItem(
            title: Text( "الرئيسية",style: TextStyle(color: Colors.white)),
            icon: Icon(
              Icons.house,
              color: widget.index==4? Colors.white : QaeatColor.black_color,
            ),
            /*Image(
              image: AssetImage('images/home/home.png'),
              color: widget.index==4? Colors.white : QaeatColor.black_color,
            ),*/

            activeColor:QaeatColor.primary_color,
            textAlign: TextAlign.center,
          ),
        ],
      );
  }
}