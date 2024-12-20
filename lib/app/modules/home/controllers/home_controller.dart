import 'package:flavour_lab/app/data/data_provider.dart';
import 'package:flavour_lab/app/data/model_categori.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedCategory = 'Beef'.obs;
  var dataCategori = <Meal>[].obs;
  var dataRecomen = <Meal>[].obs;

  var isLoading = false.obs;
  var isLoadingRecomen = false.obs;

  @override
  void onInit() {
    super.onInit();
    recomendations();
    fetchData(selectedCategory.value);
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
          Get.snackbar('Error', 'Response body is null');
        }
      } else {
        Get.snackbar('Error', 'Failed to fetch users: ${response.statusCode}');
      }
    } catch (e) {
      print('ini error nya $e');
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  void recomendations() async {
    isLoadingRecomen.value = true;
    try {
      List<Future<Response>> futures =
          List.generate(10, (_) => DataProvider().recommendations());
      List<Response> responses = await Future.wait(futures);

      List<Meal> allMeals = responses
          .where((response) =>
              response.statusCode == 200 && response.bodyString != null)
          .expand((response) {
        ListCategoryModel dataModel =
            listCategoryModelFromJson(response.bodyString!);
        return dataModel.meals;
      }).toList();

      isLoadingRecomen.value = false;

      dataRecomen.value = allMeals;
    } catch (e) {
      print('ini error nya $e');
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void setSelectedCategory(String category) {
    selectedCategory.value = category;
    fetchData(category);
  }

  List<Map<String, dynamic>> categories = [
    {"name": "Beef", "icon": 'assets/images/beef.png'},
    {"name": "Breakfast", "icon": 'assets/images/breakfast.png'},
    {"name": "Chicken", "icon": 'assets/images/chicken.png'},
    {"name": "Dessert", "icon": 'assets/images/dessert.png'},
    {"name": "Goat", "icon": 'assets/images/goat.png'},
    {"name": "Lamb", "icon": 'assets/images/lamb.png'},
    {"name": "Pasta", "icon": 'assets/images/pasta.png'},
    {"name": "Pork", "icon": 'assets/images/pork.png'},
    {"name": "Seafood", "icon": 'assets/images/seafood.png'},
    {"name": "Side", "icon": 'assets/images/side.png'},
    {"name": "Starter", "icon": 'assets/images/starter.png'},
    {"name": "Vegan", "icon": 'assets/images/vegan.png'},
    {"name": "Vegetarian", "icon": 'assets/images/vegetarian.png'},
  ];
}
