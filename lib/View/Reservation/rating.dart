import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:Massara/Custom_Widgets/export_file.dart';

class Rating extends StatefulWidget {
  final String token;
  final int user_id;
  final int salon_id;
  final int employee_id;

  Rating({this.token, this.user_id, this.salon_id, this.employee_id});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RatingState();
  }
}

class RatingState extends State<Rating> {
  var rating_border = 1;
  var salon_rate = 0.0;
  var employee_rate = 0.0;
  TextEditingController salon_comment;
  TextEditingController employee_comment;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    salon_comment = new TextEditingController();
    employee_comment = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StatefulBuilder(
      builder: (context, setState) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          child: AlertDialog(
            contentPadding: EdgeInsets.all(0.0),
            content: SafeArea(
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: new Container(
                    width: width,
                    height: height / 1.7,
                    child: new Column(
                      children: <Widget>[
                        InkWell(
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Icon(
                              Icons.close,
                              size: 25,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            'نشكرك على حسن تعاونك معنا يمكنك \n          تقييم الصالون والخبير ايضا',
                            style: TextStyle(fontFamily: 'Cairo'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0xFFF6F6F6),
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                              children: <Widget>[
                                InkWell(
                                  child: Container(
                                    padding: EdgeInsets.only(right: 20),
                                    decoration: BoxDecoration(
                                      border: rating_border == 1
                                          ? Border(
                                              bottom: BorderSide(
                                                  color: Colors.black))
                                          : Border(
                                              bottom: BorderSide(
                                                  color: Color(0xFFF6F6F6))),
                                    ),
                                    child: Text(
                                      'تقييم الصالون',
                                      style: rating_border == 1
                                          ? TextStyle(
                                              fontFamily: 'Cairo',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)
                                          : TextStyle(
                                              fontFamily: 'Cairo',
                                              fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      rating_border = 1;
                                    });
                                  },
                                ),
                                Spacer(),
                                InkWell(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 20),
                                    decoration: BoxDecoration(
                                      border: rating_border == 2
                                          ? Border(
                                              bottom: BorderSide(
                                                  color: Colors.black))
                                          : Border(
                                              bottom: BorderSide(
                                                  color: Color(0xFFF6F6F6))),
                                    ),
                                    child: Text(
                                      'تقييم الخبير',
                                      style: rating_border == 2
                                          ? TextStyle(
                                              fontFamily: 'Cairo',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)
                                          : TextStyle(
                                              fontFamily: 'Cairo',
                                              fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      rating_border = 2;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        rating_border == 1
                            ? Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(top: 10),
                                      alignment: Alignment.center,
                                      child: RatingBar(
                                        onRatingChanged: (rate) {
                                          setState(() {
                                            salon_rate = rate;
                                          });
                                          ('salon_rate : ${salon_rate}');
                                        },
                                        initialRating: salon_rate,
                                        maxRating: 5,
                                        isHalfAllowed: true,
                                        halfFilledIcon: Icons.star_half,
                                        filledIcon: Icons.star,
                                        emptyIcon: Icons.star_border,
                                        size: 30,
                                        filledColor: (salon_rate >= 1)
                                            ? Colors.yellow.shade700
                                            : Colors.yellow.shade700,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: Color(0xFFC2C0C0))),
                                        child: TextField(
                                          controller: salon_comment,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              filled: true,
                                              fillColor: Colors.white,
                                              hintText: 'اكتب تعليقك هنا ',
                                              hintStyle: TextStyle(
                                                  fontFamily: 'Cairo',
                                                  color: MassaraColor.secondary_color,
                                                  fontSize: 12)),
                                          maxLines: 4,
                                          keyboardType: TextInputType.multiline,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(right: 20, top: 10),
                                      child: new Container(
                                        alignment: Alignment.centerRight,
                                        child: ButtonTheme(
                                          minWidth: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3,
                                          child: RaisedButton(
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
                                              'تقييم',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Cairo',
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                            onPressed: () {
                                              int value = salon_rate.toInt();
                                              String comment = (salon_comment
                                                          .text
                                                          .trim() ==
                                                      null)
                                                  ? ''
                                                  : salon_comment.text.trim();
                                              ApiProvider.senRateForSalon(
                                                  widget.token,
                                                  widget.salon_id,
                                                  widget.user_id,
                                                  value,
                                                  comment,
                                                  context);
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : StatefulBuilder(
                                builder: (context, setState) {
                                  return Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(top: 10),
                                          alignment: Alignment.center,
                                          child: RatingBar(
                                            initialRating: employee_rate,
                                            onRatingChanged: (rate) {
                                              setState(() {
                                                employee_rate = rate;
                                              });
                                              (
                                                  'employee_rate : ${employee_rate}');
                                            },
                                            maxRating: 5,
                                            isHalfAllowed: true,
                                            halfFilledIcon: Icons.star_half,
                                            filledIcon: Icons.star,
                                            emptyIcon: Icons.star_border,
                                            size: 30,
                                            filledColor: (employee_rate >= 1)
                                                ? Colors.yellow.shade700
                                                : Colors.yellow.shade700,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                    color: Color(0xFFC2C0C0))),
                                            child: TextField(
                                              controller: employee_comment,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  hintText: 'اكتب تعليقك هنا ',
                                                  hintStyle: TextStyle(
                                                      fontFamily: 'Cairo',
                                                      color: MassaraColor.secondary_color,
                                                      fontSize: 12)),
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: 4,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 20, top: 10),
                                          child: new Container(
                                            alignment: Alignment.centerRight,
                                            child: ButtonTheme(
                                              minWidth: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: RaisedButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                  side: BorderSide(
                                                    color: MassaraColor.primary_color,
                                                    width: 1.0,
                                                  ),
                                                ),
                                                color: MassaraColor.primary_color,
                                                child: Text(
                                                  'تقييم',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: 'Cairo',
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                                onPressed: () {
                                                  int emp_value =
                                                      employee_rate.toInt();
                                                  String emp_comment =
                                                      (employee_comment.text
                                                                  .trim() ==
                                                              null)
                                                          ? ''
                                                          : employee_comment
                                                              .text
                                                              .trim();

                                                  ApiProvider
                                                      .senRateForEmployee(
                                                          widget.token,
                                                          widget.employee_id,
                                                          widget.user_id,
                                                          emp_value,
                                                          emp_comment,
                                                          context);
                                                  // Navigator.of(context).pop();
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
