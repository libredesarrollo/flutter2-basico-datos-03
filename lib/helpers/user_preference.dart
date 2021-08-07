import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
   static late SharedPreferences _prefers;



  initPrefers() async {
    UserPreference._prefers = await SharedPreferences.getInstance();
  }

  String get name {
    return _prefers.getString('name') ?? "" ;
  }

  set name(String value) {
    _prefers.setString('name', value);
  }


  String get surname {
    return _prefers.getString('surname') ?? '';
  }

  set surname(String value) {
    _prefers.setString('surname', value);
  }

  int get age {
    return _prefers.getInt('age') ?? 0;
  }

  set age(int value) {
    _prefers.setInt('age', value);
  }

  bool get married {
    return _prefers.getBool('married') ?? false;
  }

  set married(bool value) {
    _prefers.setBool('married', value);
  }

  List<String> get favoriteMusic {
    return _prefers.getStringList('music') ?? ['pop'];
  }

  set favoriteMusic(List<String> value) {
    _prefers.setStringList('music', value);
  }

  clean() {
    name = "";
    surname = "";
    age = 0;
    married = false;
    favoriteMusic = [];
  }
}
