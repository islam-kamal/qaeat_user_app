import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Massara/Custom_Widgets/export_file.dart';
import 'package:Massara/Model/invoices_model.dart';
import 'package:Massara/Model/order_model.dart';

class Invoices extends StatefulWidget{
  final String token;
  final int user_id;
  Invoices({this.token, this.user_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Bills_State();
  }

}
class Bills_State extends State<Invoices>{
  Future<List<InvoicesModel>> invoicesList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.token == StaticMethods.vistor_token) {
      invoicesList = null;
    } else {
      invoicesList =
          ApiProvider.getUserInvoices(widget.token, widget.user_id, context);
      ('invoicesList :: ${invoicesList}');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    invoicesList = null;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'فواتيري',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        backgroundColor: MassaraColor.primary_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: (){
    Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => MorePage()));
    },
    child: Padding(
        padding: EdgeInsets.only(top: 10, left: 5, right: 5),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: (invoicesList == null)
              ? VistorMessage()
              : FutureBuilder<List<InvoicesModel>>(
            future: invoicesList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  if (snapshot.data.length != 0) {


                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, index) {
                          return Column(
                            children: <Widget>[
                             Padding(
                               padding: EdgeInsets.all(5),
                               child:  Card(
                                 shape: OutlineInputBorder(
                                   borderRadius:
                                   BorderRadius.circular(5),
                                   borderSide: BorderSide(
                                       color: Color(0xFFDCDCDC)),
                                 ),
                                 child:  Padding(
                                   padding: EdgeInsets.all(0),
                                   child: Table(
                                     textDirection: TextDirection.ltr,
                                     border: TableBorder.all(width: 1.0, color: Colors.grey),
                                     defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                     columnWidths: {
                                       0: FlexColumnWidth(2),
                                       1: FlexColumnWidth(1),
                                     },
                                     children: [
                                       TableRow(
                                           children: [
                                             Padding(
                                               padding: EdgeInsets.all(8),
                                               child: Text(
                                                 "${snapshot.data[index].salon.city.name} ",
                                                 textScaleFactor: 1,
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     color: MassaraColor.primary_color,
                                                     fontFamily: 'Cairo',
                                                     fontSize: 16,
                                                     fontWeight: FontWeight.bold
                                                 ),
                                               ),
                                             ),
                                             Padding(
                                               padding: EdgeInsets.all(8),
                                               child: Text(
                                                 "المدينة ",
                                                 textScaleFactor: 1,
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     color: Colors.grey,
                                                     fontFamily: 'Cairo',
                                                     fontSize: 16),
                                               ),
                                             ),
                                           ]),
                                       TableRow(
                                           children: [
                                             Padding(
                                               padding: EdgeInsets.all(8),
                                               child: Text(
                                                 "${snapshot.data[index].paymentId} ",
                                                 textScaleFactor: 1,
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     color: MassaraColor.primary_color,
                                                     fontFamily: 'Cairo',
                                                     fontSize: 16,
                                                     fontWeight: FontWeight.bold
                                                 ),
                                               ),
                                             ),
                                             Padding(
                                               padding: EdgeInsets.all(8),
                                               child: Text(
                                                 "رقم الفاتورة ",
                                                 textScaleFactor: 1,
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     color: Colors.grey,
                                                     fontFamily: 'Cairo',
                                                     fontSize: 16),
                                               ),
                                             ),
                                           ]),

                                       TableRow(
                                           children: [
                                             Padding(
                                               padding: EdgeInsets.all(8),
                                               child: Text(
                                                 "${snapshot.data[index].salon.name} ",
                                                 textScaleFactor: 1,
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     color: MassaraColor.primary_color,
                                                     fontFamily: 'Cairo',
                                                     fontSize: 16,
                                                     fontWeight: FontWeight.bold
                                                 ),
                                               ),
                                             ),
                                             Padding(
                                               padding: EdgeInsets.all(8),
                                               child: Text(
                                                 "اسم المركز",
                                                 textScaleFactor: 1,
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     color: Colors.grey,
                                                     fontFamily: 'Cairo',
                                                     fontSize: 16),
                                               ),
                                             ),
                                           ]),
                                       TableRow(
                                           children: [
                                             Padding(
                                               padding: EdgeInsets.all(8),
                                               child: Text(
                                                 "${snapshot.data[index].status=='Successful'?'ناجحة':'فشلت'}  ",
                                                 textScaleFactor: 1,
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     color: MassaraColor.primary_color,
                                                     fontFamily: 'Cairo',
                                                     fontSize: 16,
                                                     fontWeight: FontWeight.bold
                                                 ),
                                               ),
                                             ),
                                             Padding(
                                               padding: EdgeInsets.all(8),
                                               child: Text(
                                                 "حالة الدفع ",
                                                 textScaleFactor: 1,
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     color: Colors.grey,
                                                     fontFamily: 'Cairo',
                                                     fontSize: 16),
                                               ),
                                             ),
                                           ]),
                                       TableRow(
                                           children: [
                                             Padding(
                                               padding: EdgeInsets.all(8),
                                               child: Text(
                                                 "${snapshot.data[index].amount}  ريال  ",
                                                 textScaleFactor: 1,
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     color: MassaraColor.primary_color,
                                                     fontFamily: 'Cairo',
                                                     fontSize: 16,
                                                     fontWeight: FontWeight.bold
                                                 ),
                                               ),
                                             ),
                                             Padding(
                                               padding: EdgeInsets.all(8),
                                               child: Text(
                                                 "قيمة الفاتورة ",
                                                 textScaleFactor: 1,
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     color: Colors.grey,
                                                     fontFamily: 'Cairo',
                                                     fontSize: 16),
                                               ),
                                             ),
                                           ]),
                                       TableRow(
                                           children: [
                                             Padding(
                                               padding: EdgeInsets.all(8),
                                               child: Text(
                                                 "${snapshot.data[index].createdAt} ",
                                                 textScaleFactor: 1,
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     color: MassaraColor.primary_color,
                                                     fontFamily: 'Cairo',
                                                     fontSize: 16,
                                                     fontWeight: FontWeight.bold
                                                 ),
                                               ),
                                             ),
                                             Padding(
                                               padding: EdgeInsets.all(8),
                                               child: Text(
                                                 "تاريخ العملية ",
                                                 textScaleFactor: 1,
                                                 textAlign: TextAlign.center,
                                                 style: TextStyle(
                                                     color: Colors.grey,
                                                     fontFamily: 'Cairo',
                                                     fontSize: 16),
                                               ),
                                             ),
                                           ]),
                                     ],
                                   ),
                                 ),
                               ),
                             )
                            ],
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
                              width:
                              MediaQuery.of(context).size.width /
                                  3,
                              height:
                              MediaQuery.of(context).size.height /
                                  4,
                              image: AssetImage(
                                  'images/splash_screen/massara_logo.png'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              'لا يوجد فواتير  حاليا ',
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
                            MediaQuery.of(context).size.width / 3,
                            height:
                            MediaQuery.of(context).size.height /
                                4,
                            image: AssetImage(
                                'images/splash_screen/massara_logo.png'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'لا يوجد فواتير  حاليا ',
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
      ),
    ));
  }

}