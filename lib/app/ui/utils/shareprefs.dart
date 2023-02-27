import 'package:shared_preferences/shared_preferences.dart';
import "dart:convert";

class SharePrefs {
  static SharedPreferences? sharedPreferences;

  static Future initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static saveDataList(List data) {
    print("Inside shared prefs");
    String dataString = jsonEncode(data);
    sharedPreferences?.setString("expList", dataString);
    String? datast = sharedPreferences?.getString("expList");
    String datas = datast.toString();
    print("fetched after saving data:" + datas);

    print("data saved to shared prefs");
  }

  static saveAmountList(List data) {
    print("Inside amt shared prefs");
    String dataString = jsonEncode(data);
    sharedPreferences?.setString("amtList", dataString);
    String? datast = sharedPreferences?.getString("amtList");
    String datas = datast.toString();
    print("fetched after amt saving data:" + datas);
    print("amt saved to shared prefs");
  }

  static List getData() {
    List data = [];
    print("before check null");
    if (sharedPreferences != null) {
      print("in not null");

      String? dataString = sharedPreferences?.getString("expList");
      String datas = dataString.toString();
      print("shared prefs data is:" + datas);
      if (datas != "") {
        data = jsonDecode(datas);
      }
    } else {
      print("in null");
    }
    return data;
  }

  static List getAmtData() {
    List data = [];
    if (sharedPreferences != null) {
      String? dataString = sharedPreferences?.getString("amtList");
      String datas = dataString.toString();
      print("shared prefs amt data is:" + datas);
      if (datas != "" && datas != null) {
        data = jsonDecode(datas);
      }
    }
    return data;
  }
}
