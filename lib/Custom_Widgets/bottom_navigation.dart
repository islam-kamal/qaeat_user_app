import 'package:flutter/material.dart';
import 'package:Massara/Custom_Widgets/export_file.dart';

class BottomNavigation extends StatefulWidget {
  int index;

  BottomNavigation({this.index});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BottomNavigation_State();
  }
}

class BottomNavigation_State extends State<BottomNavigation> {
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

  void onTabTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MorePage()));
          break;
        case 1:
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrdersPage(
                      token:
                          (sharedPrefs.getString('user_access_token') == null)
                              ? StaticMethods.vistor_token
                              : sharedPrefs.getString('user_access_token'),
                      user_id: sharedPrefs.getInt('user_id'))));
          break;
        case 2:
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Notifications(
                      token:
                          (sharedPrefs.getString('user_access_token') == null)
                              ? StaticMethods.vistor_token
                              : sharedPrefs.getString('user_access_token'),
                      user_id: sharedPrefs.getInt('user_id'))));
          break;
        case 3:
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OfferPage(
                        token:
                            (sharedPrefs.getString('user_access_token') == null)
                                ? StaticMethods.vistor_token
                                : sharedPrefs.getString('user_access_token'),
                      )));
          break;
        case 4:
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        token:
                            (sharedPrefs.getString('user_access_token') == null)
                                ? StaticMethods.vistor_token
                                : sharedPrefs.getString('user_access_token'),
                      )));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(248, 248, 248, 0.92),
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.index,
      selectedItemColor: Colors.black,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      onTap: onTabTapped,
      items: [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.more_horiz,
            color: MassaraColor.secondary_color,
          ),
          title: Text("المزيد", style: style),
          activeIcon: Icon(
            Icons.more_horiz,
            color: MassaraColor.primary_color,
          )
        ),
        BottomNavigationBarItem(
          icon: Image(
            image: AssetImage('images/home/shopping-cart.png'),
            color: MassaraColor.secondary_color,
          ),
          title: Text(
            "طلباتى",
            style: style,
          ),
          activeIcon:  Image(
            image: AssetImage('images/home/shopping-cart.png'),
            color: MassaraColor.primary_color,
          ),
        ),
        BottomNavigationBarItem(
          icon: Image(
            image: AssetImage('images/home/notification.png'),
            color: MassaraColor.secondary_color,
          ),
          title: Text(
            "الاشعارات",
            style: style,
          ),
          activeIcon: Image(
            image: AssetImage('images/home/notification.png'),
            color: MassaraColor.primary_color,
          ),
        ),
        BottomNavigationBarItem(
          icon: Image(
            image: AssetImage('images/home/bell.png'),
            color: MassaraColor.secondary_color,
          ),
          title: Text(
            "العروض",
            style: style,
          ),
          activeIcon: Image(
            image: AssetImage('images/home/bell.png'),
            color: MassaraColor.primary_color,
          ),
        ),
        BottomNavigationBarItem(
          icon: Image(
            image: AssetImage('images/home/home.png'),
            color: MassaraColor.secondary_color,
          ),
          title: Text(
            "الرئيسية",
            style: style,
          ),
          activeIcon: Image(
            image: AssetImage('images/home/home.png'),
            color: MassaraColor.primary_color,
          ),
        ),
      ],
    );
  }
}
