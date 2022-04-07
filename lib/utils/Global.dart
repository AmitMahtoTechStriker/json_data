import 'package:fetch_json_data/utils/CallBackInterface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Global{
  // Fetch content from the json file
  static Future<dynamic> readJson(String title,String jsonFile,BuildContext context,CallBackInterface callBackInterface) async {
    var response = await rootBundle.loadString(jsonFile);

    if(response!=null || response!=""){
      callBackInterface.callback(title, response, context);
    }
  }
}