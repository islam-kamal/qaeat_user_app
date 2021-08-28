import 'package:flutter/material.dart';
import 'package:Qaeat/Custom_Widgets/export_file.dart';

class SalonSlider extends StatefulWidget {
  List<Gallery> hallPictures;
  SalonSlider({this.hallPictures});
  @override
  State<StatefulWidget> createState() {
    ('salonSlider :${hallPictures}');
    // TODO: implement createState
    return SalonSliderState();
  }
}

class SalonSliderState extends State<SalonSlider> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CarouselSlider.builder(
      itemCount: widget.hallPictures.length,
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        aspectRatio: 2.5,
        initialPage: 0,
      ),
      itemBuilder: (BuildContext context, index) {
        if (widget.hallPictures.length != 0) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 5),
              child: Image.network(
                '${widget.hallPictures[index].photo}',
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 5),
              child: Image(
                image: AssetImage('images/offer/sa.jpg'),
                height: MediaQuery.of(context).size.width / 5,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),
          );
        }
      },
    );
  }
}
