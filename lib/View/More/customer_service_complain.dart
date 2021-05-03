import 'package:flutter/material.dart';
import 'package:Massara/Custom_Widgets/export_file.dart';
import 'customer_services.dart';

class CustomerServiceComplain extends StatefulWidget {
  final String token;
  final int user_id;
  CustomerServiceComplain({this.token, this.user_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomerServiceComplain_state();
  }
}

class CustomerServiceComplain_state extends State<CustomerServiceComplain> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailAddress;
  TextEditingController _PhoneNumber;
  TextEditingController _username;
  TextEditingController _message;
  TextStyle style =
      TextStyle(color: Colors.black, fontFamily: 'Cairo', fontSize: 16);
  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'قم بكتابه البريد الالكترونى!';
    } else {
      return null;
    }
  }

  ProgressDialog _progressDialog;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _progressDialog = new ProgressDialog(context);
    _emailAddress = new TextEditingController();
    _PhoneNumber = new TextEditingController();
    _username = new TextEditingController();
    _message = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog.style(
        message: 'جارى ارسال الشكوى',
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'الدعم الفنى',
          style: TextStyle(
            fontFamily: 'Cairo',
            color: Color(0xFFFFFFFF),
          ),
        ),
        backgroundColor: MassaraColor.primary_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFFFFFFF),
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MorePage()));
          },
        ),
      ),
      body: (widget.token == StaticMethods.vistor_token)
          ? VistorMessage()
          : SafeArea(
              child: SingleChildScrollView(
                child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Form(
                        key: _formKey,
                        child: new Container(
                          padding: EdgeInsets.only(right: 10, left: 5, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Text(
                                      'الاسم بالكامل',
                                      style: style,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10, right: 10, top: 5),
                                    child: new Container(
                                      child: TextFormField(
                                        controller: _username,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Color(0xFFF6F6F6),
                                          hintText: 'اكتب اسمك هنا',
                                          border: InputBorder.none,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                              borderSide: BorderSide(
                                                color: Color(0xFFF6F6F6),
                                              )),
                                        ),
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'قم بكتابه الاسم بالكامل اولا !';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Text(
                                      'رقم الجوال',
                                      style: style,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        left: 10,
                                        right: 10,
                                        bottom: 10),
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Color(0xFFF6F6F6),
                                          width: 1.0,
                                        ),
                                        color: Color(0xFFF6F6F6),
                                      ),
                                      child: new Row(
                                        children: <Widget>[
                                          Expanded(
                                              flex: 1,
                                              child: Row(
                                                children: <Widget>[
                                                  Image(
                                                    image: AssetImage(
                                                        'images/user_sign/flag.png'),
                                                  ),
                                                  Text(
                                                    '   966+',
                                                    style: style,
                                                  )
                                                ],
                                              )),
                                          Expanded(
                                            flex: 2,
                                            child: TextFormField(
                                              controller: _PhoneNumber,
                                              keyboardType: TextInputType.phone,
                                              decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Color(0xFFF6F6F6),
                                                hintText: 'xxxxxxxx',
                                                border: InputBorder.none,
                                              ),
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return 'رقم الجوال غير صحيح!';
                                                }
                                                return null;
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: Text(
                                      'البريد الالكترونى',
                                      style: style,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        left: 10,
                                        right: 10,
                                        bottom: 10),
                                    child: new Container(
                                      child: TextFormField(
                                        controller: _emailAddress,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Color(0xFFF6F6F6),
                                          border: InputBorder.none,
                                          hintText: 'Example@gmail.com',
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            borderSide: const BorderSide(
                                              color: Color(0xFFF6F6F6),
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                        validator: emailValidator,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                  ),
                                  child: Container(
                                    child: Text('الملاحظات', style: style),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 10,
                                  left: 10,
                                  right: 10,
                                ),
                                child: new Container(
                                  child: TextFormField(
                                    controller: _message,
                                    maxLines: 4,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color(0xFFF6F6F6),
                                      border: InputBorder.none,
                                      hintText: 'اكتب ملاحظاتك هنا..',
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                          color: Color(0xFFF6F6F6),
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'قم بادخال ملاحظاتك !';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),

                              // use Builder to solve Scaffold.of() called with a context that does not contain a Scaffold Exception
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 10, right: 10, bottom: 5),
                                child: Builder(
                                  builder: (ctx) => new Container(
                                      padding: EdgeInsets.only(
                                          top: 15.0, bottom: 10),
                                      alignment: Alignment.center,
                                      child: ButtonTheme(
                                        minWidth:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: RaisedButton(
                                          padding: const EdgeInsets.all(5.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            side: BorderSide(
                                              color: MassaraColor.primary_color,
                                              width: 1.0,
                                            ),
                                          ),
                                          color: MassaraColor.primary_color,
                                          child: Text(
                                            'ارسال',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          onPressed: () {
                                            _progressDialog.show();
                                            if (_formKey.currentState
                                                .validate()) {
                                              ApiProvider
                                                  .sendNewTicketToSupport(
                                                      widget.token,
                                                      _username.text.trim(),
                                                      _emailAddress.text.trim(),
                                                      _PhoneNumber.text.trim(),
                                                      _message.text.trim(),
                                                      widget.user_id,
                                                      context);
                                            }

                                            _progressDialog.hide();
                                          },
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
            ),
    );
  }
}
