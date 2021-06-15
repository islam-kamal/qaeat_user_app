import 'package:flutter/material.dart';
import 'package:Qaeat/Custom_Widgets/export_file.dart';

class ResetPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ResetPasswordState();
  }
}

class ResetPasswordState extends State<ResetPassword> {
  final _formResetPwKey = GlobalKey<FormState>();
  TextEditingController _emailAddress = new TextEditingController();
  TextStyle style =
      TextStyle(color: Colors.black, fontFamily: 'Cairo', fontSize: 16);
  ProgressDialog _progressDialog;
  bool valid_code;
  @override
  void initState() {
    _progressDialog = ProgressDialog(context);
    valid_code=false;
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return ' البريد الالكترونى ليس مسجل من قبل!';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog.style(
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.bounceInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          alignment: Alignment.centerRight,
          child: Text(
            'نسيت كلمة المرور',
            style: TextStyle(fontFamily: 'Cairo',color: Colors.white,fontSize: 16),
          ),
        ),
        actions: [
          InkWell(
            onTap: (){
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context)=> UserSignIn()));
            },
            child: Icon(Icons.arrow_forward_ios),
          )
        ],
        backgroundColor: QaeatColor.primary_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body:SafeArea(
        child: SingleChildScrollView(
    child: Directionality(
            textDirection: TextDirection.rtl,
            child:  Form(
                  key: _formResetPwKey,
                  child: new Container(
                    padding: EdgeInsets.only(
                        right: 10, left: 5, top: 10),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 10,
                              bottom: 20),
                          child: Text(
                            'تعديل كلمه السر الخاص بك؟',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Cairo',
                                fontSize: 16),
                          ),
                        ),
                        Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10),
                              child: Text(
                                'البريد الالكترونى',
                                style: TextStyle(
                                    fontFamily: 'Cairo',
                                    fontWeight:
                                    FontWeight.normal),
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
                                  keyboardType: TextInputType
                                      .emailAddress,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                    Color(0xFFF6F6F6),
                                    hintText:
                                    'Example@example.com',
                                    border: InputBorder.none,
                                    enabledBorder:
                                    OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          5.0),
                                      borderSide:
                                      const BorderSide(
                                        color:
                                        Color(0xFFF6F6F6),
                                        width: 1.0,
                                      ),
                                    ),
                                  ),
                                  validator: emailValidator,
                                ),
                              ),
                            ),
                            valid_code?Padding(
                              padding: EdgeInsets.only(
                                  top: 5,
                                  left: 10,
                                  right: 10,
                                  bottom: 5),
                              child: Text(
                                'البريد الالكترونى غير مسجل مسبقا !',
                                style: TextStyle(color: Colors.red,fontWeight: FontWeight.normal,fontFamily: 'Cairo',fontSize: 14),
                              ),
                            ):Container(),
                          ],
                        ),
                        // use Builder to solve Scaffold.of() called with a context that does not contain a Scaffold Exception

                        Padding(
                          padding: EdgeInsets.only(
                              top: 10,
                              left: 10,
                              right: 10,
                              bottom: 5),
                          child: Builder(
                            builder: (ctx) => new Container(
                                padding:
                                EdgeInsets.only(top: 10.0),
                                alignment: Alignment.center,
                                child: ButtonTheme(
                                  minWidth:
                                  MediaQuery.of(context)
                                      .size
                                      .width /
                                      2,
                                  child: RaisedButton(
                                    padding:
                                    const EdgeInsets.all(
                                        3.0),
                                    shape:
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          5.0),
                                      side: BorderSide(
                                        color:
                                        QaeatColor.primary_color,
                                        width: 1.0,
                                      ),
                                    ),
                                    color: QaeatColor.primary_color,
                                    child: Text(
                                      'ارسال',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0,
                                          fontWeight:
                                          FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      if (_formResetPwKey
                                          .currentState
                                          .validate()) {
                                        sendOtpToEmail(
                                            _emailAddress.text
                                                .trim());
                                      }
                                    },
                                  ),
                                )),
                          ),
                        ),
                      ],
                    ),
                  )),
            ))
    ));
  }


  sendOtpToEmail(String email) async {
    _progressDialog.show();
    String sendOtp_Url = ApiProvider.APP_URL + "/api/users/sendNotification";
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'email': '${email}',
      });
      final response = await dio.post(sendOtp_Url, data: _formData);
      (response);
      if (response.data['success'] == 'success') {
        _progressDialog.hide();
        setState(() {
          valid_code=false;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ResetPassword2(
                      email: email,
                    )));
      } else {
        _progressDialog.hide();
        setState(() {
          valid_code=true;
        });
      }
    } catch (e) {
      _progressDialog.hide();
      errorDialog(context: context, text: e.toString());
    }
  }



  Widget page_header() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'ارسال كلمه السر',
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Cairo', fontSize: 20),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    alignment: Alignment.centerLeft,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 25,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserSignIn()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
