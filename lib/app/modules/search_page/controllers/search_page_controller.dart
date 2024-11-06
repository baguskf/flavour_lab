import 'package:flavour_lab/app/data/data_provider.dart';
import 'package:flavour_lab/app/data/model_categori.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {
  final TextEditingController searchC = TextEditingController();

  var isLoading = false.obs;
  var dataCategori = <Meal>[].obs;

  void searchRecipe(String search) async {
    isLoading.value = true;
    try {
      final response = await DataProvider().search(search);
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
