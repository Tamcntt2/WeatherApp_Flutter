import 'package:flutter/cupertino.dart';

class UIUtils {
  static Size getScreenSize(BuildContext context){
    return MediaQuery.of(context).size;
  }

}