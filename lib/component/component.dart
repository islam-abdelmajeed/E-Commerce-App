import 'package:e_commerce_app/component/constant.dart';
import 'package:flutter/material.dart';

Widget customTextField({
  @required String hint,
   IconData icon,
   Function validate,
  Function onClick,
  bool isPassword = false,
  double radius = 20.0,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        validator: validate,
        obscureText: isPassword,
        onSaved:onClick ,
        cursorColor: kMainColor,
        cursorWidth: 3,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: kMainColor,
          ),
          hintText: hint,
          filled: true,
          fillColor: kSecondaryColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );

Widget customButton({
  @required String text,
  @required Function function,
  Color color = Colors.black,
  Color textColor = Colors.white,
  double radius = 20.0,
}) =>
    MaterialButton(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold
        ),
      ),
    );

void navigateTo({
  @required context,
  @required widget,
}) =>
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndRemove({@required context, @required widget}) =>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);
