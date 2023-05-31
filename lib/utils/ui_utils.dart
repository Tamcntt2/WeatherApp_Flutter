import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class UIUtils {
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static String capitalizeAllWord(String value) {
    if (value.isEmpty) return '';
    var result = value[0].toUpperCase();
    for (int i = 1; i < value.length; i++) {
      if (value[i - 1] == " ") {
        result = result + value[i].toUpperCase();
      } else {
        result = result + value[i];
      }
    }
    return result;
  }

  static String convertNameCity(String value) {
    String name =
        capitalizeAllWord(value.toLowerCase().replaceAll('thành phố ', ''));

    return name;
  }

  static String keyGoogleMap = 'AIzaSyC4w2mDNzjs2tkCp5f_EO_n6BNBa3erKxE';

  // static showToast(String msg) {
  //   Fluttertoast.showToast(
  //       msg: msg,
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.black.withOpacity(0.8),
  //       textColor: Colors.white,
  //       fontSize: 14);
  // }
}
