import 'package:flutter/cupertino.dart';

class UIUtils {
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static DateTime convertTimestampToDateTime(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return dateTime;
  }

  static String capitalizeAllWord(String value) {
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
}
