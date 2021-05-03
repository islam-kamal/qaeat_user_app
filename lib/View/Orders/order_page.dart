import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:Massara/Custom_Widgets/export_file.dart';
import 'package:Massara/Model/order_model.dart';

class OrdersPage extends StatefulWidget {
  final String token;
  final int user_id;
  OrdersPage({this.token, this.user_id});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrdersPage_State();
  }
}

class OrdersPage_State extends State<OrdersPage> {
  var latitude;
  var longitude;
  var salon_name;

  GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<Marker> _markers;
  int _currentIndex;
  SharedPreferences sharedPrefs;
  Future<List<OrderModel>> orderList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers = <Marker>[];
    _currentIndex = 1;
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
      });
    });
    if (widget.token == StaticMethods.vistor_token) {
      orderList = null;
    } else {
      orderList =
          ApiProvider.getOrdersList(widget.token, widget.user_id, context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    orderList = null;
    ('orderList dispose');
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'طلباتى',
              style: TextStyle(fontFamily: 'Cairo'),
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
          body: Directionality(
            textDirection: TextDirection.rtl,
            child: (orderList == null)
                ? VistorMessage()
                : FutureBuilder<List<OrderModel>>(
                    future: orderList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length != 0) {
                            return ListView.builder(
                                itemCount: snapshot.data.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  latitude = double.parse(
                                      snapshot.data[index].salon.Latitude);
                                  longitude = double.parse(
                                      snapshot.data[index].salon.Longitude);
                                  salon_name = snapshot.data[index].salon.name;

                                  return Card(
                                    shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5),
                                      borderSide:
                                          BorderSide(color: Color(0xFFDCDCDC)),
                                    ),
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Row(
                                            children: <Widget>[
                                              Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            6,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            6,
                                                    child: Image.network(
                                                      '${snapshot.data[index].salon.logo}',
                                                      fit: BoxFit.cover,
                                                      alignment:
                                                          Alignment.topCenter,
                                                    ),
                                                  )),
                                              Expanded(
                                                  flex: 3,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          '${snapshot.data[index].salon.name}',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Cairo',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 16),
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          10),
                                                              child: Text(
                                                                'الحاله',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Cairo'),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            order_status(
                                                                snapshot
                                                                    .data[index]
                                                                    .status),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 10, top: 5),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.location_on,
                                                    color: Color(0xFF959090),
                                                    size: 20,
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '${snapshot.data[index].salon.address}',
                                                    style: TextStyle(
                                                      color: Color(0xFF403E3E),
                                                      fontFamily: 'Cairo',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 5),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.date_range,
                                                      color: Color(0xFF959090),
                                                      size: 20,
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      '${snapshot.data[index].date}',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF403E3E),
                                                        fontFamily: 'Cairo',
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 15,
                                                    ),

                                                    SizedBox(
                                                      width: 15,
                                                    ),
                                                    Icon(
                                                      Icons.access_time,
                                                      color: Color(0xFF959090),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      ' ${snapshot.data[index].time}',
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF403E3E),
                                                        fontFamily: 'Cairo',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // container contain more details data
                                              Container(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Column(
                                                  children: <Widget>[
                                                    (snapshot.data[index].employee == null
                                                       || snapshot.data[index].employee.name=='')
                                                        ? Container()
                                                        : Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 5),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Image(
                                                                  image: AssetImage(
                                                                      'images/reservation/barber.png'),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  'الخبير',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFF292929),
                                                                    fontFamily:
                                                                        'Cairo',
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 15,
                                                                ),
                                                                Text(':'),
                                                                SizedBox(
                                                                  width: 15,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              10,
                                                                          left:
                                                                              10),
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        4,
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    decoration: BoxDecoration(
                                                                        color: Color(
                                                                            0xFFF6F6F6),
                                                                        borderRadius:
                                                                            BorderRadius.circular(5)),
                                                                    child: Text(
                                                                      '    ${snapshot.data[index].employee.name}    ',
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              'Cairo',
                                                                          color: Color(
                                                                              0xFF403E3E),
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Row(
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  'تفاصيل الحجز',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFF292929),
                                                                    fontFamily:
                                                                        'Cairo',
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Text(':'),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                              ],
                                                            ),
                                                         Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      Expanded(
                                                                        flex: 2,
                                                                        child: Container(
                                                                          padding: EdgeInsets.only(right: 10),
                                                                          child: Text('اسم الخدمة', style:
                                                                          TextStyle(
                                                                            color: Color(
                                                                                0xFF292929),
                                                                            fontFamily:
                                                                            'Cairo',
                                                                          ),),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                          child: Container(
                                                                          child: Text('سعر الخدمه', style:
                                                                          TextStyle(
                                                                            color: Color(
                                                                                0xFF292929),
                                                                            fontFamily:
                                                                            'Cairo',
                                                                          ),),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        flex: 1,
                                                                        child: Container(
                                                                          child: Text(' عدد الاشخاص', style:
                                                                          TextStyle(
                                                                            color: Color(
                                                                                0xFF292929),
                                                                            fontFamily:
                                                                            'Cairo',
                                                                          ),),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  ListView.builder(
                                                                    shrinkWrap:
                                                                    true,
                                                                    scrollDirection:
                                                                    Axis.vertical,
                                                                    itemCount: snapshot.data[index].services.length,
                                                                    itemBuilder:
                                                                        (context,
                                                                        i) {
                                                                      return Column(
                                                                        children: [
                                                                          Container(
                                                                              padding: EdgeInsets.only(
                                                                                  right:
                                                                                  2,
                                                                                  left:
                                                                                  2),
                                                                              child:Row(
                                                                                children: [
                                                                                  Expanded(
                                                                                      flex: 2,
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Container(
                                                                                              padding: EdgeInsets.only(right: 10),
                                                                                              decoration: BoxDecoration(
                                                                                                  color:
                                                                                                  Color(0xFFF6F6F6),
                                                                                                  borderRadius: BorderRadius.circular(5)),
                                                                                              child:
                                                                                              Text(
                                                                                                '${snapshot.data[index].services[i].name}',
                                                                                                style: TextStyle(
                                                                                                    fontFamily: 'Cairo',
                                                                                                    color: Color(0xFF403E3E),
                                                                                                    fontWeight: FontWeight.bold),
                                                                                              ),
                                                                                            ),
                                                                                          )
                                                                                          ,
                                                                                          SizedBox(width: 5,),
                                                                                        ],
                                                                                      )
                                                                                  ),
                                                                                  Expanded(
                                                                                      flex: 1,
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Expanded(
                                                                                            child: Container(
                                                                                              alignment:
                                                                                              Alignment.center,
                                                                                              decoration: BoxDecoration(
                                                                                                  color:
                                                                                                  Color(0xFFF6F6F6),
                                                                                                  borderRadius: BorderRadius.circular(5)),
                                                                                              child:
                                                                                              Text(
                                                                                                '${snapshot.data[index].services[i].price} ريال  ',
                                                                                                style: TextStyle(
                                                                                                    fontFamily: 'Cairo',
                                                                                                    color: Color(0xFF403E3E),
                                                                                                    fontWeight: FontWeight.bold),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          SizedBox(width: 5,)
                                                                                        ],
                                                                                      )
                                                                                  ),
                                                                                  Expanded(
                                                                                    flex: 1,
                                                                                    child: Container(
                                                                                      //   width: MediaQuery.of(context).size.width / 3,
                                                                                      alignment:
                                                                                      Alignment.center,
                                                                                      decoration: BoxDecoration(
                                                                                          color:
                                                                                          Color(0xFFF6F6F6),
                                                                                          borderRadius: BorderRadius.circular(5)),
                                                                                      child:
                                                                                      Text(
                                                                                        '${snapshot.data[index].services[i].person_num}',
                                                                                        style: TextStyle(
                                                                                            fontFamily: 'Cairo',
                                                                                            color: Color(0xFF403E3E),
                                                                                            fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                          ),
                                                                          SizedBox(height: 5,)
                                                                        ],
                                                                      );
                                                                    },
                                                                  ),
                                                                ],
                                                              )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 10, bottom: 5),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Text(
                                                            'تنفيذ الخدمة',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF292929),
                                                              fontFamily:
                                                                  'Cairo',
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(':'),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 2,
                                                                    left: 2),
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  3,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration: BoxDecoration(
                                                                  color: Color(
                                                                      0xFFF6F6F6),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              child: Text(
                                                                (snapshot.data[index]
                                                                            .type ==
                                                                        0)
                                                                    ? 'فى المركز'
                                                                    : 'فى البيت',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Cairo',
                                                                    color: Color(
                                                                        0xFF403E3E),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Divider(),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 0, left: 10),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right: 0),
                                                              child: Text(
                                                                'اجمالى التكلفه :',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Cairo',
                                                                    color: Color(
                                                                        0xFF292929)),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20),
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                '${snapshot.data[index].total_cost}  ريال',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Cairo',
                                                                    color: Color(
                                                                        0xFF292929),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Divider(),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 10, left: 10),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Icon(
                                                            Icons.location_on,
                                                            color: Color(
                                                                0xFF959090),
                                                            size: 20,
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            'الصالون على الخريطه',
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF292929),
                                                                fontFamily:
                                                                    'Cairo',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    salonLoction(salon_name,
                                                        latitude, longitude),
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          right: 10,
                                                          left: 10,
                                                          top: 30,
                                                          bottom: 20),
                                                      child: new Center(
                                                        child: (snapshot.data[index].payment==0)?   new SizedBox(
                                                          width: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width /
                                                              1.5,
                                                          height: MediaQuery.of(
                                                              context)
                                                              .size
                                                              .width /
                                                              7,
                                                          child:
                                                          new RaisedButton(
                                                            onPressed: () {
                                                              (
                                                                  'order-id: ${snapshot.data[index].id}');
                                                              ApiProvider.cancelOrder(
                                                                  widget
                                                                      .token,
                                                                  widget
                                                                      .user_id,
                                                                  snapshot
                                                                      .data[
                                                                  index]
                                                                      .id,
                                                                  3,
                                                                  context);
                                                            },
                                                            child: new Text(
                                                              "الغاء الحجز",
                                                              style: TextStyle(
                                                                  color: Colors.white,
                                                                  fontFamily:
                                                                  'Cairo',
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontSize:
                                                                  16),
                                                            ),
                                                            shape:
                                                            new RoundedRectangleBorder(
                                                              borderRadius:
                                                              new BorderRadius
                                                                  .circular(
                                                                  5.0),
                                                              side:
                                                              BorderSide(
                                                                color: Color(
                                                                    0xFF707070),
                                                              ),
                                                            ),
                                                            color:MassaraColor.primary_color,
                                                          ),
                                                        )
                                                            : Column(
                                                          children: <Widget>[
                                                            Padding(
                                                              padding: EdgeInsets.only(top: 10),
                                                              child: new SizedBox(
                                                                width: MediaQuery.of(context).size.width/1.5,
                                                                height: MediaQuery.of(context).size.width/7,
                                                                child: new RaisedButton(
                                                                  onPressed:()  {
                                                                    ApiProvider.makeOnlinePayment(widget.token,
                                                                        snapshot.data[index].total_cost.toDouble(),
                                                                        snapshot.data[index].id,
                                                                        context);

                                                                  },

                                                                  child: new Text(
                                                                    "الدفع اونلاين",
                                                                    style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontFamily: 'Cairo',
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 16
                                                                    ),
                                                                  ),
                                                                  //use to make circle border for button
                                                                  shape: new RoundedRectangleBorder(
                                                                    borderRadius: new BorderRadius.circular(5.0),

                                                                  ),
                                                                  color: MassaraColor.primary_color,
                                                                ),
                                                              ),
                                                            ),
                                                      Padding(
                                                        padding: EdgeInsets.only(top: 10),
                                                        child: new SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  1.5,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  7,
                                                              child:
                                                                  new RaisedButton(
                                                                onPressed: () {
                                                                  (
                                                                      'order-id: ${snapshot.data[index].id}');
                                                                  ApiProvider.cancelOrder(
                                                                      widget
                                                                          .token,
                                                                      widget
                                                                          .user_id,
                                                                      snapshot
                                                                          .data[
                                                                              index]
                                                                          .id,
                                                                      3,
                                                                      context);
                                                                },
                                                                child: new Text(
                                                                  "الغاء الحجز",
                                                                  style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontFamily:
                                                                          'Cairo',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                                shape:
                                                                    new RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                              .circular(
                                                                          5.0),
                                                                  side:
                                                                      BorderSide(
                                                                    color: Color(
                                                                        0xFF707070),
                                                                  ),
                                                                ),
                                                                color: MassaraColor.primary_color,
                                                              ),
                                                            )
                                                      )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
                                    Image(
                                      image: AssetImage(
                                          'images/splash_screen/massara_logo.png'),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'لا يوجد طلبات حاليا',
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
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    height:
                                        MediaQuery.of(context).size.width / 2,
                                    image: AssetImage(
                                        'images/splash_screen/massara_logo.png'),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'لا يوجد طلبات حاليا',
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
          ),
        ));
  }

  Widget order_status(int status) {
    switch (status) {
      case 0:
        return Row(
          children: <Widget>[
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.yellow.shade700,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              child: Text(
                'معلق',
                style: TextStyle(fontFamily: 'Cairo'),
              ),
            ),
          ],
        );
        break;
      case 1:
        return Row(
          children: <Widget>[
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.lightBlueAccent,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              child: Text(
                'تم قبول الطلب',
                style: TextStyle(fontFamily: 'Cairo'),
              ),
            ),
          ],
        );
        break;
      case 2:
        return Row(
          children: <Widget>[
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.red.shade500,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              child: Text(
                'تم رفض الطلب',
                style: TextStyle(fontFamily: 'Cairo'),
              ),
            ),
          ],
        );
        break;
      case 3:
        return Row(
          children: <Widget>[
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              child: Text(
                'تم الغاء الطلب',
                style: TextStyle(fontFamily: 'Cairo'),
              ),
            ),
          ],
        );
        break;
      case 4:
        return Row(
          children: <Widget>[
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.green,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              child: Text(
                'مكتمل',
                style: TextStyle(fontFamily: 'Cairo'),
              ),
            ),
          ],
        );
        break;
    }
  }

  Widget salonLoction(String name, double lat, double lang) {
    _markers.add(Marker(
        markerId: MarkerId(''),
        position: LatLng(lat, lang),
        infoWindow: InfoWindow(title: '${name}')));
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width / 2,
        child: GoogleMap(
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: _onMapCreated,
          markers: Set<Marker>.of(_markers),
          initialCameraPosition: CameraPosition(
            target: LatLng(lat, lang),
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}
