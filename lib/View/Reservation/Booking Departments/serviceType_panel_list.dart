import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Massara/Custom_Widgets/export_file.dart';
import 'package:Massara/Model/Booking/service_type_model.dart';
import 'package:Massara/Presenter/static_methods.dart';

class ServiceTypeExpansionPanel extends StatefulWidget {
  final String token;
  final int salon_id;
  final int home_service;

  ServiceTypeExpansionPanel({this.token, this.salon_id, this.home_service});

  @override
  _ServiceTypeExpansionPanelState createState() {
    return _ServiceTypeExpansionPanelState();
  }
}

class _ServiceTypeExpansionPanelState extends State<ServiceTypeExpansionPanel> {
  int _currentIndex = 1;
  int catogery_id;
  SharedPreferences sharedPrefs;

  List<Item> generateItems(int numberOfItems) {
    ('generateItems---');
    return List.generate(numberOfItems, (int index) {
      ('header index : ${index}');
      return Item(
        headerValue: header_item[index],
      );
    });
  }

  List header_item = ['اختيار القسم'];
  List<Item> _data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _data = generateItems(1);
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
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _data[index].isExpanded = !isExpanded;
          });
        },
        children: _data.map<ExpansionPanel>((Item item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              ('1111');
              return ListTile(
                title: Text(item.headerValue),
              );
            },
            body: Container(
              height: MediaQuery.of(context).size.width / 3,
              child: FutureBuilder<List<ServiceTypeModel>>(
                future: ApiProvider.getAllCategories(
                    widget.token, widget.salon_id, context),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length != 0) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data[0].categories.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Directionality(
                              textDirection: TextDirection.ltr,
                              child: Container(
                                  padding: EdgeInsets.only(right: 10, left: 10),
                                  child: Column(
                                    children: <Widget>[
                                      RadioListTile(
                                        groupValue: _currentIndex,
                                        title: Text(
                                          "${snapshot.data[0].categories[index].name}",
                                          textDirection: TextDirection.rtl,
                                        ),
                                        value: snapshot
                                            .data[0].categories[index].id,
                                        onChanged: (val) {
                                          setState(() {
                                            _currentIndex = val;
                                            ('index : ${_currentIndex}');
                                            catogery_id = snapshot
                                                .data[0].categories[index].id;
                                            sharedPrefs.setInt(
                                                'catogery_id', catogery_id);
                                            (
                                                "catogery_id : ${catogery_id}");
                                            StaticMethods.bookServiceList =
                                                ApiProvider.getBookService(
                                                    widget.token,
                                                    widget.salon_id,
                                                    catogery_id,
                                                    widget.home_service,
                                                    context);
                                            item.isExpanded = false;
                                            ('3333333');

                                            header_item.add(snapshot.data[0]
                                                .categories[index].name);
                                            (
                                                'header_item : ${header_item}');
                                            item.headerValue = header_item.last;
                                            ('44444444444');
                                          });
                                        },
                                      ),
                                      Divider(
                                        color: Color(0xFFDADADA),
                                      )
                                    ],
                                  )),
                            );
                          },
                        );
                      } else {
                        return Container(
                          child: Text('لم يضيف المركز أي أقسام حتى الآن'),
                        );
                      }
                    } else {
                      return Container(
                        child: Text('لم يضيف المركز أي أقسام حتى الآن'),
                      );
                    }
                  }
                  // By default, show a loading spinner.
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            //data_list(item),
            isExpanded: item.isExpanded,
          );
        }).toList(),
      ),
    );
  }
}

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
