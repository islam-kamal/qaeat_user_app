
import 'package:Qaeat/View/Hall_Details/hall_details.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:Qaeat/Custom_Widgets/export_file.dart';
import 'package:Qaeat/Model/Search/search_by_location_model.dart';

class NearestSalonic extends StatefulWidget {
  final String token;
  final int map_details_route;
  NearestSalonic({this.token,this.map_details_route});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NearestSalonic_State();
  }
}

class NearestSalonic_State extends State<NearestSalonic> {
  SharedPreferences sharedPrefs;
  GoogleMapController mapController;
  final LatLng _center = const LatLng(24.774265, 46.738586);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<Marker> _markers;
  Future<List<SearchByLocationModel>> nearest_listOfSalons;

  final Location location = Location();

  LocationData _location;
  String _error;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   print ('--1--');
    getApiData();
    print ('--2--');
    _markers = <Marker>[];
    print ('--3--');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nearest_listOfSalons = null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
        child:WillPopScope(
      onWillPop: (){
        Navigator
            .pushReplacement(
            context,
            MaterialPageRoute(
            builder: (context) =>HomePage(
              token: (widget.token == StaticMethods.vistor_token)
                  ? StaticMethods.vistor_token
                  : widget.token,
        )));
      },
      child: Scaffold(
        appBar:  AppBar(
          automaticallyImplyLeading: false,
          title: Padding(
              padding: EdgeInsets.only(right: 5, left: 5, top: 10),
              child: SearchClass(
                token: (widget.token == StaticMethods.vistor_token)
                    ? StaticMethods.vistor_token
                    : widget.token,
                map: true,
              )),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          backgroundColor:  QaeatColor.primary_color,
          elevation: 5.0,
          bottom: PreferredSize(
              child: Container(), preferredSize: Size.fromHeight(15.0)),
        ),
        body: FutureBuilder<List<SearchByLocationModel>>(
          future: nearest_listOfSalons,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                print('nearest : ${snapshot.data}');
                print('nearest length : ${snapshot.data.length}');
                salons_data(snapshot.data);
                return Padding(
                  padding: EdgeInsets.all(0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: GoogleMap(
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      onMapCreated: _onMapCreated,
                      markers: Set<Marker>.of(_markers),
                      initialCameraPosition: CameraPosition(
                        target: _center,
                        zoom: 4.0,
                      ),
                    ),
                  ),
                );
              } else {}
            }
            return Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(QaeatColor.secondary_color),
              ),
            );
          },
        ),
      ),
    ),
    onTap: (){
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    },);
  }

  void salons_data(List<SearchByLocationModel> nearest_salons_list) {
    nearest_salons_list.forEach((f) {
      double lat = double.parse((f.Latitude.isEmpty) ? '25.9616242' : f.Latitude);
      double lng = double.parse((f.Longitude.isEmpty) ? '44.7585477' : f.Longitude);
      _markers.add(Marker(
          markerId: MarkerId(f.name),
          position: LatLng(lat, lng),
          onTap: () {
            bottomSheetWidget(f);
          }));
    });
  }

  Future<void> _getLocation() async {
    setState(() {
      _error = null;
    });
    try {
      await location.requestService();
      final LocationData _locationResult = await location.getLocation();
      setState(() {
        _location = _locationResult;
       print ('latitude : ${_location.latitude} , longitude ${_location.longitude}');
      });
    } catch (err) {
      setState(() {
        _error = err.code;
      });
    }
  }

  Future<void> getApiData() async {
    await _getLocation();
    nearest_listOfSalons = ApiProvider.getNearestSalons(
        (widget.token == StaticMethods.vistor_token)
            ? StaticMethods.vistor_token
            : widget.token,
        _location.longitude,
        _location.latitude,
        context);
    print('nearest_listOfSalons : ${nearest_listOfSalons}');
  }

  void bottomSheetWidget(SearchByLocationModel f) {
    print("f.logo : ${f.logo}");
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
            height: MediaQuery.of(context).size.height / 1.5,
            color: Color(0xFFF6F6F6),
            child: Padding(
              padding: EdgeInsets.only(top: 0),
              child: Column(
                children: [
                   Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20)
                     ),   
                     child: Image.network(
                        '${f.logo}',
                          height: MediaQuery.of(context).size.width / 2,
                          width: MediaQuery.of(context).size.width ,
                          fit: BoxFit.fill,
                        ),
                  ),
                  SizedBox(height: 20,),
                   Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 5),
                            child: Text(
                              f.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 5),
                            child: Text(
                              '${f.address}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 5),
                            child: Row(
                              children: [
                                Text(
                                  'المسافة : ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${f.distance.toStringAsFixed(2)}  كيلو متر',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: new Container(
                        padding: EdgeInsets.only(top: 15.0),
                        alignment: Alignment.center,
                        child: ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width / 2,
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(
                                color: QaeatColor.primary_color,
                                width: 1.0,
                              ),
                            ),
                            color: QaeatColor.primary_color,
                            child: Text(
                              'اذهب الى مقدم الخدمة',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.normal),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HallDetails(
                                            token: widget.token,
                                            hall_id: f.id,
                                            route: 1,
                                          )));
                            },
                          ),
                        )),
                  )
                ],
              ),
            ));
      },
    );
  }
}
