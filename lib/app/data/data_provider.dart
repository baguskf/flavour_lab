import 'package:get/get.dart';

class DataProvider extends GetConnect {
  final String url = 'https://www.themealdb.com/api/json/v1';

  Future<Response> getCategori(String categori) =>
      get("$url/1/filter.php?c=$categori");
}
