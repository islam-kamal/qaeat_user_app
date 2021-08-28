import 'package:flutter/material.dart';
import 'package:Qaeat/Custom_Widgets/export_file.dart';

class ResetPassword2 extends StatefulWidget {
  final String email;
  ResetPassword2({this.email});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ResetPassword2State();
  }
}

class ResetPassword2State extends State<ResetPassword2> {
  final _formResetPwKey = GlobalKey<FormState>();
  TextEditingController otp_controller;
  ProgressDialog _progressDialog;
  TextStyle style =
      TextStyle(color: Colors.black, fontFamily: 'Cairo', fontSize: 16);
  bool valid_code = false;
  String otp;
  int pinLength = 4;
  bool hasError = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _progressDialog = new ProgressDialog(context);
    otp_controller = new TextEditingController();
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
              'كود التفعيل',
              style: TextStyle(
                  fontFamily: 'Cairo', color: Colors.white, fontSize: 16),
            ),
          ),
          actions: [
            Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.03),
                child:  InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ResetPassword()));
              },
              child: Icon(Icons.arrow_forward_ios),
            ))
          ],
          backgroundColor: QaeatColor.primary_color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child:Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.width / 7),
              child: Form(
                  key: _formResetPwKey,
                  child: new Container(
                    padding: EdgeInsets.only(right: 10, left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10, left: 10, right: 20, bottom: 5),
                          child: Text(
                            'ادخل رمز التفعيل الذى تم ارساله اليك',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Cairo',
                                fontSize: 18),
                          ),
                        ),

                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(30),
                          child: PinCodeTextField(
                            autofocus: true,
                            controller: otp_controller,
                            hideCharacter: false,
                            highlight: true,
                            highlightColor: Colors.blue,
                            defaultBorderColor: QaeatColor.gray_color,
                            hasTextBorderColor: QaeatColor.primary_color,
                            maxLength: pinLength,
                            hasError: hasError,
                            //  maskCharacter: "😎",
                            onTextChanged: (text) {
                              setState(() {
                                hasError = false;
                              });
                            },
                            onDone: (text) {
                              otp = text;
                              ("DONE $text");
                              ("DONE CONTROLLER ${otp_controller.text}");
                            },
                            pinBoxWidth: 50,
                            pinBoxHeight: 50,
                            hasUnderline: false,
                            wrapAlignment: WrapAlignment.spaceAround,
                            pinBoxDecoration: ProvidedPinBoxDecoration
                                .defaultPinBoxDecoration,
                            pinTextStyle: TextStyle(fontSize: 22.0),
                            pinTextAnimatedSwitcherTransition:
                                ProvidedPinBoxTextAnimation.scalingTransition,
                            //                    pinBoxColor: Colors.green[100],
                            pinTextAnimatedSwitcherDuration:
                                Duration(milliseconds: 300),
                            //                    highlightAnimation: true,
                            highlightAnimationBeginColor: Colors.black,
                            highlightAnimationEndColor: Colors.white12,
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        valid_code
                            ? Padding(
                                padding: EdgeInsets.only(
                                    top: 5, left: 10, right: 10, bottom: 5),
                                child: Text(
                                  ' الكود الذى ادخلته خطأ !',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.normal,
                                      fontFamily: 'Cairo',
                                      fontSize: 14),
                                ),
                              )
                            : Container(),

                        // use Builder to solve Scaffold.of() called with a context that does not contain a Scaffold Exception
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10, left: 10, right: 10, bottom: 5),
                          child: Builder(
                            builder: (ctx) => new Container(
                                padding: EdgeInsets.only(top: 25.0),
                                alignment: Alignment.center,
                                child: ButtonTheme(
                                  minWidth:
                                      MediaQuery.of(context).size.width / 1.5,
                                  child: RaisedButton(
                                    padding: const EdgeInsets.all(10.0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                      side: BorderSide(
                                        color: QaeatColor.primary_color,
                                        width: 1.0,
                                      ),
                                    ),
                                    color: QaeatColor.primary_color,
                                    child: Text(
                                      'التالى',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    onPressed: () {
                                      String otp_text = otp;
                                      String email = widget.email;
                                      setState(() {
                                        checkOtp(email, otp);
                                      });
                                    },
                                  ),
                                )),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10, left: 20, right: 20, bottom: 5),
                          child: Center(
                            child: InkWell(
                              child: Text(
                                'اعادة ارسال رمز التفعيل؟',
                                style: style,
                              ),
                              onTap: () {
                                reSendOtpToEmail(widget.email);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            )))));
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
                              builder: (context) => ResetPassword()));
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

  checkOtp(String email, String otp) async {
    _progressDialog.show();
    String CheckOtp_Url = ApiProvider.APP_URL + '/api/users/checkOtp';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'email': '${email}',
        'otp': '${otp}',
      });
      final response = await dio.post(CheckOtp_Url, data: _formData);
      if (response.data['status']) {
        setState(() {
          valid_code = false;
          _progressDialog.hide();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ResetPassword3(
                        email: email,
                      )));
        });
      } else {
        setState(() {
          _progressDialog.hide();
          valid_code = true;
        });
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }

  reSendOtpToEmail(String email) async {
    _progressDialog.show();
    String sendOtp_Url = ApiProvider.APP_URL + "/api/users/resend";
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'email': '${email}',
      });
      final response = await dio.post(sendOtp_Url, data: _formData);
      (response);
      if (response.data['success'] == 'success') {
        _progressDialog.hide();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResetPassword2(
                      email: email,
                    )));
      } else {
        errorDialog(context: context, text: response.data['success']);
      }
    } catch (e) {
      _progressDialog.hide();
      errorDialog(context: context, text: e.toString());
    }
  }
}
