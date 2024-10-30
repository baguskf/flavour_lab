import 'dart:convert';
import 'package:flavour_lab/app/data/data_provider.dart';
import 'package:flavour_lab/app/data/model_detail.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  String mealID = '';
  var isLoading = false.obs;
  var isExpanded = false.obs;
  var dataDetail = DetailMeal(
    idMeal: '',
    strMeal: '',
    strCategory: '',
    strArea: '',
    strInstructions: '',
    strMealThumb: '',
    strYoutube: '',
    ingredients: [],
    measures: [],
  ).obs;

  @override
  void onInit() {
    super.onInit();
    var data = Get.arguments;
    if (data is String) {
      mealID = data;
      fetchData(mealID);
    }
  }

  void fetchData(String mealID) async {
    isLoading.value = true;
    try {
      final response = await DataProvider().getDetail(mealID);
      isLoading.value = false;

      if (response.statusCode == 200) {
        if (response.bodyString != null) {
          var mealsList = jsonDecode(response.bodyString!)['meals'] as List;

          if (mealsList.isNotEmpty) {
            dataDetail.value = DetailMeal.fromJson(mealsList[0]);
          } else {
            print('No meals found in response');
          }
        } else {
          print('Response body is null');
        }
      } else {
        print('Failed to fetch meal details: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error: $e');
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  void toggleExpanded() {
    isExpanded.value = !isExpanded.value;
    print('Expanded status: ${isExpanded.value}');
  }

  String getDisplayedInstructions() {
    final instructions = dataDetail.value.strInstructions;

    final formattedInstructions = instructions.split('\n').map((line) {
      return line.trim();
    }).toList();

    final filteredInstructions = formattedInstructions.where((line) {
      return !RegExp(r'STEP\s*\d+', caseSensitive: false).hasMatch(line);
    }).toList();

    if (filteredInstructions.length > 2) {
      return isExpanded.value
          ? filteredInstructions.join('\n')
          : filteredInstructions.take(2).join('\n');
    }

    return filteredInstructions.join('\n');
  }

  String getSeeMoreText() {
    return isExpanded.value ? 'See less' : 'See more';
  }
}
