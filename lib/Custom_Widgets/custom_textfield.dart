import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final Function value;
  final Function validate;
  final Function onTab;
  final Function onSubmitted;
  final Widget preIcon;
  final Widget suffixIcon;
  final double width;
  final double height;
  final TextInputType inputType;
  final String label;
  final String hint;
  final int lines;
  final bool secureText;
  final double raduis;
  final String initialText;

  const CustomTextField({
    Key key,
    this.value,
    this.validate,
    this.preIcon,
    this.suffixIcon,
    this.width,
    this.height,
    this.inputType,
    this.label,
    this.hint,
    this.lines,
    this.secureText,
    this.raduis,
    this.initialText,
    this.onTab,
    this.onSubmitted,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            width: widget.width,
            margin:
                EdgeInsets.only(left: 5.0, right: 5.0, top: 2.0, bottom: 2.0),
            height: widget.height,
            child: TextFormField(
              onFieldSubmitted: widget.onSubmitted,
              onTap: widget.onTab,
              initialValue: widget.initialText ?? "",
              maxLines: widget.lines ?? 1,
              style: TextStyle(color: Colors.black, fontSize: 14.0),
              obscureText: widget.secureText ?? false,
              cursorColor: Theme.of(context).accentColor,
              keyboardType: widget.inputType ?? TextInputType.multiline,
              validator: widget.validate,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.raduis ?? 5),
                    borderSide: BorderSide(
                      color: Color(0xFFF6F6F6),
                    ),
                  ),
                  errorStyle: TextStyle(color: Colors.white, fontSize: 10.0),
                  contentPadding: EdgeInsets.only(
                      right: 20.0, top: 10.0, bottom: 10.0, left: 20),
                  border: OutlineInputBorder(
                    borderRadius:
                        new BorderRadius.circular(widget.raduis ?? 5.0),
                    borderSide: new BorderSide(),
                  ),
                  filled: true,
                  fillColor: Color(0xFFF6F6F6),
                  prefixIcon: widget.preIcon,
                  suffixIcon: widget.suffixIcon,
                  labelText: widget.label,
                  labelStyle: TextStyle(
                      fontSize: 12, color: Theme.of(context).primaryColor),
                  hintStyle: TextStyle(
                      fontSize: 12, color: Theme.of(context).primaryColor),
                  hintText: widget.hint),
              onChanged: widget.value,
            ),
          ),
        ));
  }
}
