import 'package:flavour_lab/app/data/data_provider.dart';
import 'package:flavour_lab/app/data/model_categori.dart';
import 'package:get/get.dart';

class SeeAllController extends GetxController {
  String categori = '';
  var isLoading = false.obs;
  var dataCategori = <Meal>[].obs;

  @override
  void onInit() {
    super.onInit();
    var data = Get.arguments;
    if (data is String) {
      categori = data;
    }
    fetchData(categori);
  }

  void fetchData(String categori) async {
    isLoading.value = true;
    try {
      final response = await DataProvider().getCategori(categori);
      isLoading.value = false;

      if (response.statusCode == 200) {
        if (response.bodyString != null) {
          ListCategoryModel dataModel =
              listCategoryModelFromJson(response.bodyString!);
          dataCategori.value = dataModel.meals;
        } else {
          print('Response body is null');
        }
      } else {
        print('Failed to fetch users: ${response.statusCode}');
      }
    } catch (e) {
      print('ini error nya $e');
      print('An error occurred: $e');
    }
  }
}
