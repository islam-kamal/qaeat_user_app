import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:Massara/Custom_Widgets/export_file.dart';
import 'package:intl/intl.dart' as intl;

class Date_Picker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DatePicker_State();
  }
}

class DatePicker_State extends State<Date_Picker> {
  HelperWidgets _helperWidgets = new HelperWidgets();
  var date = '25/7/2020';
  DateTime selectedDate = DateTime.now();
  var date_hint = 'اختر التاريخ من هنا';

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: MassaraColor.primary_color,
            accentColor:  MassaraColor.secondary_color,
            colorScheme: ColorScheme.light(primary:  MassaraColor.primary_color),
            buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme.primary
            ),
          ),
          child: child,
        );
      },
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),);
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        date = "${selectedDate.toLocal()}".split(' ')[0];
        sharedPrefs.setString('date', date);
        date_hint = intl.DateFormat('EEEE').format(selectedDate);
        ('date_hint : $date');
        ('date_day : $date_hint');
      });
  }

  SharedPreferences sharedPrefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    //final String formatted = formatter.format(now);
    final String formatted = 'اختر التاريخ من هنا';
    date = formatted;
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 10, left: 10, top: 10),
            child: Text(
              'اختيار التاريخ',
              style: TextStyle(
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF262626)),
            ),
          ),
          InkWell(
            child: _helperWidgets.spinner_show_time_and_date(date),
            onTap: () {
              setState(() {
                selectDate(context);
                date = date;
              });
            },
          )
        ],
      ),
    );
  }
}
