import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Qaeat/Custom_Widgets/export_file.dart';


class UserSignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserSignInState();
  }
}

class UserSignInState extends State<UserSignIn> {
  final _formSiginKey = GlobalKey<FormState>();
  TextEditingController _username;
  TextEditingController _password;
  bool _passwordVisible;
  TextStyle style =
      TextStyle(color: Colors.black, fontFamily: 'Cairo', fontSize: 16);
  String email, password;

  ProgressDialog _progressDialog;
  String deviceToken;
  SharedPreferences sharedPrefs;
  @override
  void initState() {
    ('1');
    _passwordVisible = false;
    _username = new TextEditingController();
    _password = new TextEditingController();
    ('2');
    _progressDialog = new ProgressDialog(context);
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
      });
    });
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return ' الرقم السرى غير صحيح';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    _progressDialog.style(
        message: 'جارى تحميل البيانات',
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
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Container(
              alignment: Alignment.centerRight,
              child: Text(
                'تسجيل الدخول',
                style: TextStyle(fontFamily: 'Cairo',color: Colors.white,fontSize: 16),
              ),
            ),
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
              child: Container(
                padding: EdgeInsets.only(top:width * 0.1),
                child: Form(
                    key: _formSiginKey,
                    child: new Container(
                      padding: EdgeInsets.only(
                          right: 10, left: 5, top: 10),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 15,
                                    left: 10,
                                    right: 10),
                                child: Text(
                                  'البريد الإلكتروني',
                                  style: style,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    top: 5),
                                child: new Container(
                                  child: TextFormField(
                                    controller: _username,
                                    keyboardType:
                                    TextInputType
                                        .emailAddress,
                                    decoration:
                                    InputDecoration(
                                      filled: true,
                                      fillColor: Color(
                                          0xFFF6F6F6),
                                      hintText:
                                      'example@Example.com',
                                      border: InputBorder
                                          .none,
                                      enabledBorder:
                                      OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            5.0),
                                        borderSide:
                                        const BorderSide(
                                          color: Color(
                                              0xFFF6F6F6),
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'اسم المستخدم غير صحيح ';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10),
                                child: Text(
                                  'الرقم السرى',
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
                                      keyboardType:
                                      TextInputType
                                          .text,
                                      controller:
                                      _password,
                                      obscureText:
                                      !_passwordVisible, //This will obscure text dynamically
                                      decoration:
                                      InputDecoration(
                                        filled: true,
                                        fillColor: Color(
                                            0xFFF6F6F6),
                                        border:
                                        InputBorder
                                            .none,
                                        hintText:
                                        '***********',
                                        enabledBorder:
                                        OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                              5.0),
                                          borderSide:
                                          const BorderSide(
                                            color: Color(
                                                0xFFF6F6F6),
                                            width: 1.0,
                                          ),
                                        ),
                                        // Here is key idea
                                        suffixIcon:
                                        IconButton(
                                          icon: Icon(
                                            // Based on passwordVisible state choose the icon
                                              _passwordVisible
                                                  ? Icons
                                                  .visibility
                                                  : Icons
                                                  .visibility_off,
                                              color: Colors
                                                  .black),
                                          onPressed: () {
                                            // Update the state i.e. toogle the state of passwordVisible variable
                                            setState(() {
                                              _passwordVisible =
                                              !_passwordVisible;
                                            });
                                          },
                                        ),
                                      ),
                                      validator:
                                      pwdValidator),
                                ),
                              ),
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
                              builder: (ctx) =>
                              new Container(
                                  padding:
                                  EdgeInsets.only(
                                      top: 15.0),
                                  alignment: Alignment
                                      .center,
                                  child: ButtonTheme(
                                    minWidth: MediaQuery.of(
                                        context)
                                        .size
                                        .width /
                                        1.5,
                                    child:
                                    RaisedButton(
                                      padding:
                                      const EdgeInsets
                                          .all(
                                          10.0),
                                      shape:
                                      RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            5.0),
                                        side:
                                        BorderSide(
                                          color: QaeatColor.primary_color,
                                          width: 1.0,
                                        ),
                                      ),
                                      color: QaeatColor.primary_color,
                                      child: Text(
                                        'دخول',
                                        style: TextStyle(
                                            color: Colors
                                                .white,
                                            fontSize:
                                            18.0,
                                            fontWeight:
                                            FontWeight
                                                .bold),
                                      ),
                                      onPressed:
                                          () async {
                                        deviceToken =
                                            sharedPrefs
                                                .getString(
                                                'msgToken');
                                        (
                                            'devicetoken : ${deviceToken}');
                                        if (_formSiginKey
                                            .currentState
                                            .validate()) {
                                          await signIn(
                                              _username
                                                  .text
                                                  .trim(),
                                              _password
                                                  .text
                                                  .trim(),
                                              deviceToken,
                                              context);
                                        }
                                      },
                                    ),
                                  )),
                            ),
                          ),

                          Padding(
                              padding: EdgeInsets.only(
                                  top: 10,
                                  left: 20,
                                  right: 20,
                                  bottom: 25),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .center,
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .center,
                                children: <Widget>[
                                  Center(
                                    child: InkWell(
                                      child: Text(
                                        'هل نسيت كلمه السر؟',
                                        style: style,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                    ResetPassword()));
                                      },
                                    ),
                                  ),
                                  Center(
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .center,
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        Text(
                                          ' ليس لديك حساب؟  ',
                                          style: style,
                                        ),
                                        InkWell(
                                          child: Text(
                                            'سجل الان ',
                                            style: TextStyle(
                                                color: Colors
                                                    .black,
                                                fontFamily:
                                                'Cairo',
                                                fontSize:
                                                16,
                                                decoration:
                                                TextDecoration
                                                    .underline),
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UserSignUp()));
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment
                                          .center,
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                      children: <Widget>[
                                        InkWell(
                                          child: Text(
                                            'المتابعة كزائر ',
                                            style:
                                            TextStyle(
                                              color: Colors
                                                  .black,
                                              fontFamily:
                                              'Cairo',
                                              fontSize:
                                              16,
                                            ),
                                          ),
                                          onTap:
                                              () async {
                                            //we use here to getSalonsByName
                                            StaticMethods
                                                .search_salons_list =
                                                ApiProvider.getAllSalons(
                                                    StaticMethods
                                                        .vistor_token,
                                                    context);

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => HomePage(
                                                      token: StaticMethods.vistor_token,
                                                    )));
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    )),
              )))),
        )
    );
  }


  signIn(String email, String password, String deviceToken,
      BuildContext context) async {
    _progressDialog.show();
    print('signIn 1');
    String signIn_Url = 'https://qaat.wothoq.co/api/users/login';
    Dio dio = new Dio();
    print('signIn 2');
    print('sigin email : ${email}');
    print('sigin password : ${password}');
    print('sigin deviceToken : ${deviceToken}');
    try {
      print ('signIn 3');
      FormData _formData = FormData.fromMap({
        'email': '${email}',
        'password': '${password}',
        'deviceToken': '${deviceToken}',
      });
      print('signIn 4');
      final response = await dio.post(signIn_Url, data: _formData);
      print('signIn response  : ${response}');

      print('signIn 5');
      if (response.data['status']) {
        ('signIn 6');
        sharedPrefs.setInt('user_id', response.data['user']['id']);
        sharedPrefs.setString('user_name', response.data['user']['name']);
        sharedPrefs.setString('user_email', response.data['user']['email']);
        sharedPrefs.setString('user_mobile', response.data['user']['mobile']);
        sharedPrefs.setString(
            'user_access_token', response.data['user']['access_token']);

        print('signIn 7');
        print('user-id  ${response.data['user']['id']}');
        //we use here to get nearest salons
        await ApiProvider.getNearestSalons(
            sharedPrefs.getString('user_access_token'), 1.235, 2.254, context);

        //we use here to getSalonsByName
        StaticMethods.search_salons_list = ApiProvider.getAllSalons(
            sharedPrefs.getString('user_access_token'), context);

        //we use here to get favourites salons to get its id to detect favourits salons in salonList
        await ApiProvider.getAllFavourits(
            sharedPrefs.getString('user_access_token'),
            sharedPrefs.getInt('user_id'),
            context);
        print ('signIn 8');
        _progressDialog.hide();

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(
                      user_id: sharedPrefs.getInt('user_id'),
                      token: sharedPrefs.getString('user_access_token'),
                      email: sharedPrefs.getString('user_email'),
                      mobile: sharedPrefs.getString('user_mobile'),
                      name: sharedPrefs.getString('user_name'),
                    )));

        print('signIn 9');
      } else {
        print('signIn 10');
        _progressDialog.hide();
        errorDialog(context: context, text: response.data['errNum']);
      }
    } catch (e) {
      print('signIn 11');
      _progressDialog.hide();
      errorDialog(context: context, text: e.toString());
    }
  }
}
