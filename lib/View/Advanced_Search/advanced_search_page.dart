import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Massara/Custom_Widgets/export_file.dart';
import 'package:Massara/Model/Search/advanced_search_salon_model.dart';
import 'package:Massara/Model/Search/filter_model.dart';
import 'package:Massara/View/Advanced_Search/advanced_search_class.dart';
import 'package:Massara/View/Advanced_Search/city_expansion_panel.dart';
import 'package:Massara/View/Advanced_Search/service_expamsion_panel.dart';
import 'package:Massara/View/Helper/helper_widgets.dart';
import 'package:Massara/View/Reservation/reserve_now.dart';

class AdvancedSearchPage extends StatefulWidget {
  final String token;
  SalonDetailsModel item;
  Future<List<FilterModel>> filter_salon;
  AdvancedSearchPage({this.token, this.item, this.filter_salon});
  @override
  State<StatefulWidget> createState() {
    ('--------- AdvancedSearchPage --------');
    // TODO: implement createState
    return AdvancedSearchPage_State();
  }
}

class AdvancedSearchPage_State extends State<AdvancedSearchPage> {
  TextEditingController _searchController = new TextEditingController();
  int valueHolder = 1;
  Future<List<SalonDetailsModel>> advanced_search_salon_list;
  List<int> fav_salon_id;
  SharedPreferences sharedPrefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fav_salon_id = new List<int>();
    advanced_search_salon_list = ApiProvider.getAllSalons(
        (widget.token == null) ? StaticMethods.vistor_token : widget.token,
        context);
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    advanced_search_salon_list = null;
    widget.filter_salon = null;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.token == StaticMethods.vistor_token) {
      fav_salon_id = [];
    } else {
      List<String> savedStrList = sharedPrefs.getStringList('salon_list');
      fav_salon_id = savedStrList.map((i) => int.parse(i)).toList();
    }
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MorePage()));
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
            padding: EdgeInsets.only(right: 5, left: 5, top: 10),
            child: AdvancedSearchClass(
              token: widget.token,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor:  MassaraColor.primary_color,
          elevation: 5.0,
          bottom: PreferredSize(
              child: Container(), preferredSize: Size.fromHeight(15.0)),
        ),
        body: GestureDetector (
    child:Directionality(
            textDirection: TextDirection.rtl,
            child: (widget.filter_salon == null)
                ? FutureBuilder<List<SalonDetailsModel>>(
                    future: advanced_search_salon_list,
                    builder: (context, snapshot) {
                      ('AdvancedSearchPage - SalonDetailsModel ');
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length != 0) {
                            if (widget.item == null) {
                              (
                                  '****** AdvancedSearchPage --- widget.item == null--------');
                              return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, index) {
                                  double rate = (snapshot
                                              .data[index].total_rate==
                                          null)
                                      ? 0.0
                                      : snapshot.data[index].total_rate.value
                                          .toDouble();
                                  return Wrap(
                                      children: [
                                        Stack(
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
                                                    SalonSlider(
                                                      salonPictures: snapshot
                                                          .data[index].gallery,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                            flex: 3,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              children: <Widget>[
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                      right:
                                                                      20),
                                                                  child: Text(
                                                                    '${snapshot.data[index].name.isEmpty ? ' ' : snapshot.data[index].name}',
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
                                                                Container(
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  //  padding: EdgeInsets.only(right: 20),
                                                                  child: HelperWidgets
                                                                      .ratingbar_fun(
                                                                      5,
                                                                      rate,
                                                                      18),
                                                                ),
                                                              ],
                                                            )),
                                                        Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding:
                                                              EdgeInsets.only(
                                                                  left: 20),
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
                                                                          MassaraColor.primary_color,
                                                                          width:
                                                                          1.0,
                                                                        ),
                                                                      ),
                                                                      color: MassaraColor.primary_color,
                                                                      child:
                                                                      Text(
                                                                        'احجز الان',
                                                                        style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize: 16.0,
                                                                            fontFamily: 'Cairo',
                                                                            fontWeight: FontWeight.normal),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => RerservationNow(
                                                                                token: widget.token,
                                                                                salon_id: snapshot.data[index].id,
                                                                                logo: snapshot.data[index].logo,
                                                                                name: snapshot.data[index].name,
                                                                                rate: rate,
                                                                                home_services: snapshot.data[index].home_service,
                                                                                payment: snapshot.data[index].payment,
                                                                                salonPictures: snapshot.data[index].gallery,
                                                                                item: widget.item,
                                                                                salon_list_type: 4, //advanced_search_page contain search results
                                                                              ),
                                                                            ));
                                                                        (
                                                                            '------------- salon_list_type (4)-----------------');
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
                                                              right: 20,
                                                              top: 5),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                flex: 1,
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons.location_on,
                                                                      color: Color(
                                                                          0xFF959090),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 7,
                                                                child:  Text(
                                                                  '${snapshot.data[index].address.isEmpty ? '' : snapshot.data[index].address}',
                                                                  style: TextStyle(
                                                                    color: Color(
                                                                        0xFF403E3E),
                                                                    fontFamily:
                                                                    'Cairo',
                                                                  ),
                                                                ) ,
                                                              )


                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                          EdgeInsets.only(
                                                              top: 10),
                                                          child: Row(
                                                            children: <Widget>[
                                                            Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                      right: 20,
                                                                      left: 10),
                                                                  child: Text(
                                                                    'طريقه الدفع :',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        'Cairo',
                                                                        color: Color(
                                                                            0xFF292929)),
                                                                  ),
                                                                ),

                                                              (snapshot.data[index]
                                                                  .payment ==
                                                                  2)
                                                                  ? Row(
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                        10,
                                                                        left:
                                                                        10),
                                                                    child:
                                                                    Container(
                                                                      alignment:
                                                                      Alignment.center,
                                                                      decoration: BoxDecoration(
                                                                          color: Color(0xFFDCDCDC),
                                                                          borderRadius: BorderRadius.circular(5)),
                                                                      child:
                                                                      Text(
                                                                        '  الدفع في المركز  ',
                                                                        style: TextStyle(
                                                                            fontFamily: 'Cairo',
                                                                            color: Color(0xFF292929),
                                                                            fontWeight: FontWeight.normal),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                        10,
                                                                        left:
                                                                        10),
                                                                    child:
                                                                    Container(
                                                                      alignment:
                                                                      Alignment.center,
                                                                      decoration: BoxDecoration(
                                                                          color: Color(0xFFDCDCDC),
                                                                          borderRadius: BorderRadius.circular(5)),
                                                                      child:
                                                                      Text(
                                                                        '    اونلاين    ',
                                                                        style: TextStyle(
                                                                            fontFamily: 'Cairo',
                                                                            color: Color(0xFF292929),
                                                                            fontWeight: FontWeight.normal),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                                  : Container(
                                                                padding: EdgeInsets.only(
                                                                    right:
                                                                    10,
                                                                    left:
                                                                    10),
                                                                child:
                                                                Container(
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  decoration: BoxDecoration(
                                                                      color: Color(
                                                                          0xFFDCDCDC),
                                                                      borderRadius:
                                                                      BorderRadius.circular(5)),
                                                                  child:
                                                                  Text(
                                                                    (snapshot.data[index].payment ==
                                                                        1)
                                                                        ? '  اونلاين'
                                                                        : '   الدفع في المركز   ',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        'Cairo',
                                                                        color:
                                                                        Color(0xFF292929),
                                                                        fontWeight: FontWeight.normal),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                          EdgeInsets.only(
                                                              top: 10,bottom: 10),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    right: 20,
                                                                    left: 10),
                                                                child: Text(
                                                                  'خدمات الحجز :',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                      'Cairo',
                                                                      color: Color(
                                                                          0xFF292929)),
                                                                ),
                                                              ),
                                                              (snapshot.data[index]
                                                                  .home_service ==
                                                                  2)
                                                                  ? Row(
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                        10,
                                                                        left:
                                                                        10),
                                                                    child:
                                                                    Container(
                                                                      width:
                                                                      MediaQuery.of(context).size.width / 4,
                                                                      alignment:
                                                                      Alignment.center,
                                                                      decoration: BoxDecoration(
                                                                          color: Color(0xFFDCDCDC),
                                                                          borderRadius: BorderRadius.circular(5)),
                                                                      child:
                                                                      Text(
                                                                        '  فى المركز  ',
                                                                        style: TextStyle(
                                                                            fontFamily: 'Cairo',
                                                                            color: Color(0xFF292929),
                                                                            fontWeight: FontWeight.normal),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding: EdgeInsets.only(
                                                                        right:
                                                                        10,
                                                                        left:
                                                                        10),
                                                                    child:
                                                                    Container(
                                                                      width:
                                                                      MediaQuery.of(context).size.width / 4,
                                                                      alignment:
                                                                      Alignment.center,
                                                                      decoration: BoxDecoration(
                                                                          color: Color(0xFFDCDCDC),
                                                                          borderRadius: BorderRadius.circular(5)),
                                                                      child:
                                                                      Text(
                                                                        'فى المنزل',
                                                                        style: TextStyle(
                                                                            fontFamily: 'Cairo',
                                                                            color: Color(0xFF292929),
                                                                            fontWeight: FontWeight.normal),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                                  : Container(
                                                                padding: EdgeInsets.only(
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
                                                                          0xFFDCDCDC),
                                                                      borderRadius:
                                                                      BorderRadius.circular(5)),
                                                                  child:
                                                                  Text(
                                                                    (snapshot.data[index].home_service ==
                                                                        1)
                                                                        ? 'فى المنزل'
                                                                        : ' فى المركز ',
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                        'Cairo',
                                                                        color:
                                                                        Color(0xFF292929),
                                                                        fontWeight: FontWeight.normal),
                                                                  ),
                                                                ),
                                                              ),
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
                                                  child:
                                                  (fav_salon_id.contains(
                                                      snapshot.data[index]
                                                          .id))
                                                      ? IconButton(
                                                    icon: Icon(
                                                      Icons.favorite,
                                                      size: 30,
                                                      color: MassaraColor.primary_color,
                                                    ),
                                                    onPressed: () {
                                                      setState(
                                                              () async {
                                                            await ApiProvider.removeSalonFromFavourite(
                                                                widget
                                                                    .token,
                                                                snapshot
                                                                    .data[
                                                                index]
                                                                    .id,
                                                                sharedPrefs
                                                                    .getInt(
                                                                    'user_id'),
                                                                context);
                                                            await ApiProvider.getAllFavourits(
                                                                widget
                                                                    .token,
                                                                sharedPrefs
                                                                    .getInt(
                                                                    'user_id'),
                                                                context);
                                                            Navigator.pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (BuildContext context) =>
                                                                    super.widget));
                                                          });
                                                    },
                                                  )
                                                      : IconButton(
                                                    icon: Icon(
                                                      Icons
                                                          .favorite_border,
                                                      size: 30,
                                                      color: MassaraColor.primary_color,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        if (widget
                                                            .token ==
                                                            StaticMethods
                                                                .vistor_token) {
                                                        } else {
                                                          setState(
                                                                  () async {
                                                                await ApiProvider.addSalonToFavourite(
                                                                    widget
                                                                        .token,
                                                                    snapshot
                                                                        .data[
                                                                    index]
                                                                        .id,
                                                                    sharedPrefs
                                                                        .getInt('user_id'),
                                                                    context);
                                                                await ApiProvider.getAllFavourits(
                                                                    widget
                                                                        .token,
                                                                    sharedPrefs
                                                                        .getInt('user_id'),
                                                                    context);
                                                                Navigator.pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (BuildContext context) =>
                                                                        super.widget));
                                                              });
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ))
                                          ],
                                        )
                                      ],);
                                },
                              );
                            } else {
                              (
                                  '****** AdvancedSearchPage --- widget.item != null--------');
                              return SafeArea(
                                child: SingleChildScrollView(
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: Wrap(
                                      children: [
                                        Stack(
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
                                                    SalonSlider(
                                                      salonPictures:
                                                      widget.item.gallery,
                                                    ),
                                                    Row(
                                                      children: <Widget>[
                                                        Expanded(
                                                            flex: 3,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                      right:
                                                                      20),
                                                                  child: Text(
                                                                    '${widget.item.name}',
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
                                                                Container(
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  //  padding: EdgeInsets.only(right: 20),
                                                                  child: HelperWidgets.ratingbar_fun(
                                                                      5,
                                                                      (widget.item.total_rate==null)?0.0:
                                                                      widget
                                                                          .item
                                                                          .total_rate
                                                                          .value
                                                                          .toDouble(),
                                                                      18),
                                                                ),
                                                              ],
                                                            )),
                                                        Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                  left: 20),
                                                              child:
                                                              new Container(
                                                                  padding: EdgeInsets.only(
                                                                      top:
                                                                      15.0),
                                                                  alignment:
                                                                  Alignment
                                                                      .center,
                                                                  child:
                                                                  ButtonTheme(
                                                                    minWidth: MediaQuery.of(context)
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
                                                                          color: MassaraColor.primary_color,
                                                                          width: 1.0,
                                                                        ),
                                                                      ),
                                                                      color:
                                                                      MassaraColor.primary_color,
                                                                      child:
                                                                      Text(
                                                                        'احجز الان',
                                                                        style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize: 16.0,
                                                                            fontFamily: 'Cairo',
                                                                            fontWeight: FontWeight.normal),
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        if (widget.token ==
                                                                            StaticMethods.vistor_token) {
                                                                          VistorMessage();
                                                                        } else {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => RerservationNow(
                                                                                  token: widget.token,
                                                                                  salon_id: widget.item.id,
                                                                                  logo: widget.item.logo,
                                                                                  name: widget.item.name,
                                                                                  rate: (widget.item.total_rate==null)?0.0: widget.item.total_rate.value.toDouble(),
                                                                                  home_services: widget.item.home_service,
                                                                                  payment: widget.item.payment,
                                                                                  salonPictures: widget.item.gallery,
                                                                                  item: widget.item,
                                                                                  salon_list_type: 5,
                                                                                ),
                                                                              ));
                                                                        }
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
                                                              right: 20,
                                                              top: 5),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Expanded(
                                                                flex: 1,
                                                                child: Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .location_on,
                                                                      color: Color(
                                                                          0xFF959090),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                flex: 7,
                                                                  child: Wrap(
                                                                    children: [
                                                                      Text(
                                                                        '${widget.item.address}',
                                                                        style:
                                                                        TextStyle(
                                                                          color: Color(
                                                                              0xFF403E3E),
                                                                          fontFamily:
                                                                          'Cairo',
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                              )


                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                          EdgeInsets.only(
                                                              top: 10),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    right:
                                                                    20,
                                                                    left:
                                                                    10),
                                                                child: Text(
                                                                  'طريقه الدفع :',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                      'Cairo',
                                                                      color: Color(
                                                                          0xFF292929)),
                                                                ),
                                                              ),
                                                              (widget.item.payment ==
                                                                  2)
                                                                  ? Row(
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    padding: EdgeInsets.only(
                                                                        right: 10,
                                                                        left: 10),
                                                                    child:
                                                                    Container(

                                                                      alignment:
                                                                      Alignment.center,
                                                                      decoration:
                                                                      BoxDecoration(color: Color(0xFFDCDCDC), borderRadius: BorderRadius.circular(5)),
                                                                      child:
                                                                      Text(
                                                                        '  الدفع في المركز  ',
                                                                        style: TextStyle(fontFamily: 'Cairo', color: Color(0xFF292929), fontWeight: FontWeight.normal),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding: EdgeInsets.only(
                                                                        right: 10,
                                                                        left: 10),
                                                                    child:
                                                                    Container(
                                                                      alignment:
                                                                      Alignment.center,
                                                                      decoration:
                                                                      BoxDecoration(color: Color(0xFFDCDCDC), borderRadius: BorderRadius.circular(5)),
                                                                      child:
                                                                      Text(
                                                                        '    اونلاين    ',
                                                                        style: TextStyle(fontFamily: 'Cairo', color: Color(0xFF292929), fontWeight: FontWeight.normal),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                                  : Container(
                                                                padding: EdgeInsets.only(
                                                                    right:
                                                                    10,
                                                                    left:
                                                                    10),
                                                                child:
                                                                Container(

                                                                  alignment:
                                                                  Alignment.center,
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                      Color(0xFFDCDCDC),
                                                                      borderRadius: BorderRadius.circular(5)),
                                                                  child:
                                                                  Text(
                                                                    (widget.item.payment == 1)
                                                                        ? '    اونلاين    '
                                                                        : '   الدفع في المركز   ',
                                                                    style: TextStyle(
                                                                        fontFamily: 'Cairo',
                                                                        color: Color(0xFF292929),
                                                                        fontWeight: FontWeight.normal),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          padding:
                                                          EdgeInsets.only(
                                                              top: 10,bottom: 10),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    right:
                                                                    20,
                                                                    left:
                                                                    10),
                                                                child: Text(
                                                                  'خدمات الحجز :',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                      'Cairo',
                                                                      color: Color(
                                                                          0xFF292929)),
                                                                ),
                                                              ),
                                                              (widget.item.home_service ==
                                                                  2)
                                                                  ? Row(
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    padding: EdgeInsets.only(
                                                                        right: 10,
                                                                        left: 10),
                                                                    child:
                                                                    Container(
                                                                      width:
                                                                      MediaQuery.of(context).size.width / 4,
                                                                      alignment:
                                                                      Alignment.center,
                                                                      decoration:
                                                                      BoxDecoration(color: Color(0xFFDCDCDC), borderRadius: BorderRadius.circular(5)),
                                                                      child:
                                                                      Text(
                                                                        '  فى المركز  ',
                                                                        style: TextStyle(fontFamily: 'Cairo', color: Color(0xFF292929), fontWeight: FontWeight.normal),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    padding: EdgeInsets.only(
                                                                        right: 10,
                                                                        left: 10),
                                                                    child:
                                                                    Container(
                                                                      width:
                                                                      MediaQuery.of(context).size.width / 4,
                                                                      alignment:
                                                                      Alignment.center,
                                                                      decoration:
                                                                      BoxDecoration(color: Color(0xFFDCDCDC), borderRadius: BorderRadius.circular(5)),
                                                                      child:
                                                                      Text(
                                                                        'فى المنزل',
                                                                        style: TextStyle(fontFamily: 'Cairo', color: Color(0xFF292929), fontWeight: FontWeight.normal),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                                  : Container(
                                                                padding: EdgeInsets.only(
                                                                    right:
                                                                    10,
                                                                    left:
                                                                    10),
                                                                child:
                                                                Container(
                                                                  width:
                                                                  MediaQuery.of(context).size.width /
                                                                      4,
                                                                  alignment:
                                                                  Alignment.center,
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                      Color(0xFFDCDCDC),
                                                                      borderRadius: BorderRadius.circular(5)),
                                                                  child:
                                                                  Text(
                                                                    (widget.item.home_service == 1)
                                                                        ? 'فى المنزل'
                                                                        : ' فى المركز ',
                                                                    style: TextStyle(
                                                                        fontFamily: 'Cairo',
                                                                        color: Color(0xFF292929),
                                                                        fontWeight: FontWeight.normal),
                                                                  ),
                                                                ),
                                                              ),
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
                                                  child:
                                                  (fav_salon_id.contains(
                                                      widget.item.id))
                                                      ? IconButton(
                                                    icon: Icon(
                                                      Icons.favorite,
                                                      size: 30,
                                                      color: MassaraColor.primary_color,
                                                    ),
                                                    onPressed: () {
                                                      setState(
                                                              () async {
                                                            await ApiProvider.removeSalonFromFavourite(
                                                                widget
                                                                    .token,
                                                                widget
                                                                    .item
                                                                    .id,
                                                                sharedPrefs
                                                                    .getInt(
                                                                    'user_id'),
                                                                context);
                                                            await ApiProvider.getAllFavourits(
                                                                widget
                                                                    .token,
                                                                sharedPrefs
                                                                    .getInt(
                                                                    'user_id'),
                                                                context);
                                                            Navigator.pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (BuildContext context) =>
                                                                    super.widget));
                                                          });
                                                    },
                                                  )
                                                      : IconButton(
                                                    icon: Icon(
                                                      Icons
                                                          .favorite_border,
                                                      size: 30,
                                                      color: MassaraColor.primary_color,
                                                    ),
                                                    onPressed: () {
                                                      setState(
                                                              () async {
                                                            await ApiProvider.addSalonToFavourite(
                                                                widget
                                                                    .token,
                                                                widget
                                                                    .item
                                                                    .id,
                                                                sharedPrefs
                                                                    .getInt(
                                                                    'user_id'),
                                                                context);
                                                            await ApiProvider.getAllFavourits(
                                                                widget
                                                                    .token,
                                                                sharedPrefs
                                                                    .getInt(
                                                                    'user_id'),
                                                                context);
                                                            Navigator.pushReplacement(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (BuildContext context) =>
                                                                    super.widget));
                                                          });
                                                    },
                                                  ),
                                                ))
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          } else {
                            return Container(
                              alignment: Alignment.center,
                              child: Text(
                                'لا يوجد نتائج بحث',
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    color: MassaraColor.secondary_color,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21),
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
                                        'images/splash_screen/massara_logo.png'),
                                    width:
                                    MediaQuery.of(context).size.width / 2,
                                    color: MassaraColor.primary_color,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'لا يوجد مراكز متاحة حاليا',
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
                  )
                : FutureBuilder<List<FilterModel>>(
                    future: widget.filter_salon,
                    builder: (context, snapshot) {
                      ('AdvancedSearchPage - filter_salon ');
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length != 0) {
                            return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, index) {
                                double rate =
                                    (snapshot.data[index].total_rate.value ==
                                            null)
                                        ? 0.0
                                        : snapshot.data[index].total_rate.value
                                            .toDouble();
                                if (widget.token ==
                                    StaticMethods.vistor_token) {
                                  fav_salon_id = [];
                                } else {
                                  List<String> savedStrList =
                                      sharedPrefs.getStringList('salon_list');
                                  fav_salon_id = savedStrList
                                      .map((i) => int.parse(i))
                                      .toList();
                                }
                                List gallery_photo = new List();
                                gallery_photo = snapshot.data[index].gallery;
                                ('gallery_photo : ${gallery_photo}');
                                return Wrap(
                                    children: [
                                      Stack(
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
                                                  CarouselSlider.builder(
                                                    itemCount:
                                                    gallery_photo.length,
                                                    options: CarouselOptions(
                                                      autoPlay: true,
                                                      enlargeCenterPage: true,
                                                      viewportFraction: 0.9,
                                                      aspectRatio: 2.5,
                                                      initialPage: 0,
                                                    ),
                                                    itemBuilder:
                                                        (BuildContext context,
                                                        index) {
                                                      if (gallery_photo.length !=
                                                          0) {
                                                        return Container(
                                                          decoration:
                                                          BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                          ),
                                                          child: Container(
                                                            padding:
                                                            EdgeInsets.only(
                                                                top: 10,
                                                                bottom: 5),
                                                            child: Image.network(
                                                              '${gallery_photo[index].photo}',
                                                              width:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        return Container(
                                                          decoration:
                                                          BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                          ),
                                                          child: Container(
                                                            padding:
                                                            EdgeInsets.only(
                                                                top: 10,
                                                                bottom: 5),
                                                            child: Image(
                                                              image: AssetImage(
                                                                  'images/offer/sa.jpg'),
                                                              height: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width /
                                                                  5,
                                                              width:
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Expanded(
                                                          flex: 3,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                            children: <Widget>[
                                                              Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    right:
                                                                    20),
                                                                child: Text(
                                                                  '${snapshot.data[index].name.isEmpty ? ' ' : snapshot.data[index].name}',
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
                                                              Container(
                                                                alignment:
                                                                Alignment
                                                                    .center,
                                                                //  padding: EdgeInsets.only(right: 20),
                                                                child: HelperWidgets
                                                                    .ratingbar_fun(
                                                                    5,
                                                                    rate,
                                                                    18),
                                                              ),
                                                            ],
                                                          )),
                                                      Expanded(
                                                          flex: 2,
                                                          child: Padding(
                                                            padding:
                                                            EdgeInsets.only(
                                                                left: 20),
                                                            child: new Container(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                    top:
                                                                    15.0),
                                                                alignment:
                                                                Alignment
                                                                    .center,
                                                                child:
                                                                ButtonTheme(
                                                                  minWidth:
                                                                  MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .width,
                                                                  child:
                                                                  RaisedButton(
                                                                    shape:
                                                                    RoundedRectangleBorder(
                                                                      borderRadius:
                                                                      BorderRadius.circular(
                                                                          5.0),
                                                                      side:
                                                                      BorderSide(
                                                                        color: MassaraColor.primary_color,
                                                                        width:
                                                                        1.0,
                                                                      ),
                                                                    ),
                                                                    color: MassaraColor.primary_color,
                                                                    child: Text(
                                                                      'احجز الان',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                          16.0,
                                                                          fontFamily:
                                                                          'Cairo',
                                                                          fontWeight:
                                                                          FontWeight.normal),
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      if (widget
                                                                          .token ==
                                                                          StaticMethods
                                                                              .vistor_token) {
                                                                        VistorMessage();
                                                                      } else {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) =>
                                                                                  RerservationNow(
                                                                                    token: widget.token,
                                                                                    salon_id: snapshot.data[index].id,
                                                                                    logo: snapshot.data[index].logo,
                                                                                    name: snapshot.data[index].name,
                                                                                    rate: rate,
                                                                                    home_services: snapshot.data[index].home_service,
                                                                                    payment: snapshot.data[index].payment,
                                                                                    salon_list_type: 6, // where result of filter go to reservation now
                                                                                    galleries: snapshot.data[index].gallery,
                                                                                    filter_salon: widget.filter_salon,
                                                                                  ),
                                                                            ));
                                                                        (
                                                                            '------------- salon_list_type (5)-----------------');
                                                                      }
                                                                    },
                                                                  ),
                                                                )),
                                                          )),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            right: 20, top: 5),
                                                        child: Wrap(
                                                          children: <Widget>[
                                                         Expanded(
                                                           flex: 1,
                                                           child: Row(
                                                             children: [
                                                               Icon(
                                                                 Icons.location_on,
                                                                 color: Color(
                                                                     0xFF959090),
                                                               ),
                                                               SizedBox(
                                                                 width: 5,
                                                               ),
                                                             ],
                                                           ),
                                                         ),
                                                            Expanded(
                                                              flex: 7,
                                                              child:
                                                                  Text(
                                                                    '${snapshot.data[index].address.isEmpty ? '' : snapshot.data[index].address}',
                                                                    style: TextStyle(
                                                                      color: Color(
                                                                          0xFF403E3E),
                                                                      fontFamily:
                                                                      'Cairo',
                                                                    ),
                                                              ),
                                                            )

                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            top: 10),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              padding:
                                                              EdgeInsets.only(
                                                                  right: 20,
                                                                  left: 10),
                                                              child: Text(
                                                                'طريقه الدفع :',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    'Cairo',
                                                                    color: Color(
                                                                        0xFF292929)),
                                                              ),
                                                            ),
                                                            (snapshot.data[index].payment == 2)
                                                                ? Row(
                                                              children: <Widget>[
                                                                Container(
                                                                  padding: EdgeInsets.only(right: 10, left:
                                                                  10),
                                                                  child: Container(
                                                                    alignment:
                                                                    Alignment.center,
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                        Color(0xFFDCDCDC),
                                                                        borderRadius: BorderRadius.circular(5)),
                                                                    child:
                                                                    Text(
                                                                      '  الدفع في المركز  ',
                                                                      style: TextStyle(
                                                                          fontFamily: 'Cairo',
                                                                          color: Color(0xFF292929),
                                                                          fontWeight: FontWeight.normal),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.only(
                                                                      right:
                                                                      10,
                                                                      left:
                                                                      10),
                                                                  child:
                                                                  Container(
                                                                    alignment:
                                                                    Alignment.center,
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                        Color(0xFFDCDCDC),
                                                                        borderRadius: BorderRadius.circular(5)),
                                                                    child:
                                                                    Text(
                                                                      '    اونلاين    ',
                                                                      style: TextStyle(
                                                                          fontFamily: 'Cairo',
                                                                          color: Color(0xFF292929),
                                                                          fontWeight: FontWeight.normal),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                                : Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                  right:
                                                                  10,
                                                                  left:
                                                                  10),
                                                              child:
                                                              Container(
                                                                alignment:
                                                                Alignment
                                                                    .center,
                                                                decoration: BoxDecoration(
                                                                    color: Color(
                                                                        0xFFDCDCDC),
                                                                    borderRadius:
                                                                    BorderRadius.circular(5)),
                                                                child: Text(
                                                                  (snapshot.data[index].payment ==
                                                                      1)
                                                                      ? '    اونلاين    '
                                                                      : 'الدفع في المركز',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                      'Cairo',
                                                                      color: Color(
                                                                          0xFF292929),
                                                                      fontWeight:
                                                                      FontWeight.normal),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.only(
                                                            top: 10,bottom: 10),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              padding:
                                                              EdgeInsets.only(
                                                                  right: 20,
                                                                  left: 10),
                                                              child: Text(
                                                                'خدمات الحجز :',
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                    'Cairo',
                                                                    color: Color(
                                                                        0xFF292929)),
                                                              ),
                                                            ),
                                                            (snapshot.data[index]
                                                                .home_service ==
                                                                2)
                                                                ? Row(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  padding: EdgeInsets.only(
                                                                      right:
                                                                      10,
                                                                      left:
                                                                      10),
                                                                  child:
                                                                  Container(
                                                                    width:
                                                                    MediaQuery.of(context).size.width /
                                                                        4,
                                                                    alignment:
                                                                    Alignment.center,
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                        Color(0xFFDCDCDC),
                                                                        borderRadius: BorderRadius.circular(5)),
                                                                    child:
                                                                    Text(
                                                                      '  فى المركز  ',
                                                                      style: TextStyle(
                                                                          fontFamily: 'Cairo',
                                                                          color: Color(0xFF292929),
                                                                          fontWeight: FontWeight.normal),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.only(
                                                                      right:
                                                                      10,
                                                                      left:
                                                                      10),
                                                                  child:
                                                                  Container(
                                                                    width:
                                                                    MediaQuery.of(context).size.width /
                                                                        4,
                                                                    alignment:
                                                                    Alignment.center,
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                        Color(0xFFDCDCDC),
                                                                        borderRadius: BorderRadius.circular(5)),
                                                                    child:
                                                                    Text(
                                                                      'فى المنزل',
                                                                      style: TextStyle(
                                                                          fontFamily: 'Cairo',
                                                                          color: Color(0xFF292929),
                                                                          fontWeight: FontWeight.normal),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                                : Container(
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
                                                                        0xFFDCDCDC),
                                                                    borderRadius:
                                                                    BorderRadius.circular(5)),
                                                                child: Text(
                                                                  (snapshot.data[index].home_service ==
                                                                      1)
                                                                      ? 'فى المنزل'
                                                                      : ' فى المركز ',
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                      'Cairo',
                                                                      color: Color(
                                                                          0xFF292929),
                                                                      fontWeight:
                                                                      FontWeight.normal),
                                                                ),
                                                              ),
                                                            ),
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
                                              padding: EdgeInsets.only(left: 30),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.circular(
                                                        30)),
                                                child: (fav_salon_id.contains(
                                                    snapshot.data[index].id))
                                                    ? IconButton(
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    size: 30,
                                                    color:
                                                    MassaraColor.primary_color,
                                                  ),
                                                  onPressed: () {
                                                    setState(() async {
                                                      await ApiProvider
                                                          .removeSalonFromFavourite(
                                                          widget.token,
                                                          snapshot
                                                              .data[
                                                          index]
                                                              .id,
                                                          sharedPrefs
                                                              .getInt(
                                                              'user_id'),
                                                          context);
                                                      await ApiProvider
                                                          .getAllFavourits(
                                                          widget.token,
                                                          sharedPrefs
                                                              .getInt(
                                                              'user_id'),
                                                          context);
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                              context) =>
                                                              super
                                                                  .widget));
                                                    });
                                                  },
                                                )
                                                    : IconButton(
                                                  icon: Icon(
                                                    Icons.favorite_border,
                                                    size: 30,
                                                    color:
                                                    MassaraColor.primary_color,
                                                  ),
                                                  onPressed: () {
                                                    setState(() async {
                                                      await ApiProvider
                                                          .addSalonToFavourite(
                                                          widget.token,
                                                          snapshot
                                                              .data[
                                                          index]
                                                              .id,
                                                          sharedPrefs
                                                              .getInt(
                                                              'user_id'),
                                                          context);
                                                      await ApiProvider
                                                          .getAllFavourits(
                                                          widget.token,
                                                          sharedPrefs
                                                              .getInt(
                                                              'user_id'),
                                                          context);
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                              context) =>
                                                              super
                                                                  .widget));
                                                    });
                                                  },
                                                ),
                                              ))
                                        ],
                                      ),
                                    ],);
                               },
                            );
                          } else {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    'لا يوجد نتائج بحث',
                                    style: TextStyle(
                                        fontFamily: 'Cairo',
                                        color: MassaraColor.secondary_color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21),
                                  ),
                                ),
                              ],
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
                                        'images/splash_screen/massara_logo.png'),
                                    width:
                                    MediaQuery.of(context).size.width / 2,
                                    color: MassaraColor.primary_color,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'لا يوجد مراكز متاحة حاليا',
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
                  )),
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        ),

      ),
    );
  }
}
