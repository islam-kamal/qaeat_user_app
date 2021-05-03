import 'dart:async';

import 'package:flutter/material.dart';
import 'package:Massara/Custom_Widgets/export_file.dart';

class PaymentResponse extends StatefulWidget {
  final String token;
  final int status; // sucess =>1 or faield =>.0
  final int user_id;
  final String salon_name;
  final String bill_number;
  final String city;
  final String bill_cost;
  final String opertion_date;
  PaymentResponse({this.token, this.status = 1, this.user_id,this.salon_name,this.city,this.bill_cost,this.bill_number,this.opertion_date});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PaymentResponseState();
  }
}

class PaymentResponseState extends State<PaymentResponse> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*
    Timer(Duration(seconds: 3), () {
      if(widget.status==1){
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext contex) => MyReservation(
              token: widget.token,
              user_id: widget.user_id,
            )));
      }else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext contex) => OrdersPage(
              token: widget.token,
              user_id: widget.user_id,
            )));
      }

    });

     */
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    /*
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          '',
          style: TextStyle(fontFamily: 'Cairo'),
        ),
        backgroundColor: MassaraColor.primary_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.payment,
                size: 50,
              ),
              SizedBox(
                height: 20,
              ),
              (widget.status == 0)
                  ? Text(
                'توجد مشكلة تعوق عملية الدفع \n              رجاء كرر المحاولة  ',
                style: TextStyle(
                    fontFamily: 'Cairo',
                    color: MassaraColor.secondary_color,
                    fontWeight: FontWeight.bold,
                    fontSize: 21),
              )
                  : Text(
                'لقد تمت عملية الدفع بنجاح ',
                style: TextStyle(
                    fontFamily: 'Cairo',
                    color: MassaraColor.secondary_color,
                    fontWeight: FontWeight.bold,
                    fontSize: 21),
              ),
            ],
          ),
        ),
      ),
    );

     */

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'الفاتورة',
            style: TextStyle(fontFamily: 'Cairo'),
          ),
          backgroundColor: MassaraColor.primary_color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
        ),
        body: (widget.status==0) ?
        Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.payment,
                  size: 50,
                ),
                SizedBox(
                  height: 20,
                ),
                 Text(
                  'توجد مشكلة تعوق عملية الدفع \n              رجاء كرر المحاولة  ',
                  style: TextStyle(
                      fontFamily: 'Cairo',
                      color: MassaraColor.secondary_color,
                      fontWeight: FontWeight.bold,
                      fontSize: 21),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.width / 7,
                    child: new RaisedButton(
                      onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                              builder: (BuildContext contex) => OrdersPage(
                                token: widget.token,
                                user_id: widget.user_id,
                              )));
                        
                      },
                      child: new Text(
                        "أنهاء ",
                        style: TextStyle(
                            color: MassaraColor.primary_color,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        side: BorderSide(
                          color: Color(0xFF707070),
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
            : Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15,right: 0,left: 10),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 5,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'المدينة',
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Cairo',
                                fontSize: 18),
                          ),
                          Text(
                            '${widget.city}',
                            style: TextStyle(
                                color: MassaraColor.primary_color,
                                fontFamily: 'Cairo',
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15,right: 0,left: 10),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 5,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'رقم الفاتورة',
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Cairo',
                                fontSize: 18),
                          ),
                          Text(
                            '${widget.bill_number}',
                            style: TextStyle(
                                color: MassaraColor.primary_color,
                                fontFamily: 'Cairo',
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20,right: 0,left: 10),
                  child: Table(
                    textDirection: TextDirection.ltr,
                    border: TableBorder.all(width: 1.0, color: Colors.grey),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                          children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "${widget.salon_name}  ",
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
                                "${widget.status==1?'ناجحة':'فشلت'}  ",
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
                                "${widget.bill_cost} ريال  ",
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
                                "${widget.opertion_date}  ",
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
                Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.width / 7,
                    child: new RaisedButton(
                      onPressed: () {
                        if (widget.status == 1) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext contex) =>
                                      MyReservation(
                                        token: widget.token,
                                        user_id: widget.user_id,
                                      )));
                        } else {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (BuildContext contex) => OrdersPage(
                                        token: widget.token,
                                        user_id: widget.user_id,
                                      )));
                        }
                      },
                      child: new Text(
                        "أنهاء ",
                        style: TextStyle(
                            color: MassaraColor.primary_color,
                            fontFamily: 'Cairo',
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        side: BorderSide(
                          color: Color(0xFF707070),
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
