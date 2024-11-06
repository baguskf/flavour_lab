import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavour_lab/app/controllers/firebase_service.dart';
import 'package:flavour_lab/app/data/data_provider.dart';
import 'package:flavour_lab/app/data/model_detail.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  final auth = FirebaseService().auth;
  final data = FirebaseService().data;

  String mealID = '';
  var isLoading = false.obs;
  var isExpanded = false.obs;
  var isSaved = false.obs;
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

  var ingredientImages = <String>[].obs;

  @override
  void onInit() async {
    super.onInit();
    var data = Get.arguments;
    if (data is String) {
      mealID = data;
      await fetchData(mealID); // Tunggu fetchData selesai
      checkBookmarkStatus(); // Panggil setelah data selesai di-fetch
    }
  }

  Future<void> fetchData(String mealID) async {
    isLoading.value = true;
    try {
      final response = await DataProvider().getDetail(mealID);
      isLoading.value = false;

      if (response.statusCode == 200) {
        if (response.bodyString != null) {
          var mealsList = jsonDecode(response.bodyString!)['meals'] as List;

          if (mealsList.isNotEmpty) {
            dataDetail.value = DetailMeal.fromJson(mealsList[0]);

            await getImageUrl(dataDetail.value.ingredients);
            print('Ingredients: ${dataDetail.value.ingredients}');
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

  void togglesSave() {
    isSaved.value = !isSaved.value;
    if (isSaved.value) {
      bookmark(dataDetail.value.idMeal, dataDetail.value.strMeal,
          dataDetail.value.strMealThumb);
    } else {
      removeBookmark(dataDetail.value.idMeal);
    }
  }

  void bookmark(String idMeal, String nameMeal, String image) async {
    final bookmarkCollection = await data
        .collection('data')
        .doc(auth.currentUser!.uid)
        .collection('bookmark')
        .where("idMeal", isEqualTo: idMeal)
        .get();

    if (bookmarkCollection.docs.isEmpty) {
      await data
          .collection('data')
          .doc(auth.currentUser!.uid)
          .collection('bookmark')
          .add({
        "idMeal": idMeal,
        "name_meal": nameMeal,
        "image": image,
        "createdAt": FieldValue.serverTimestamp(),
      });
      isSaved.value = true;
    } else {
      print("Bookmark sudah ada.");
    }
  }

  void removeBookmark(String idMeal) async {
    final bookmarkCollection = await data
        .collection('data')
        .doc(auth.currentUser!.uid)
        .collection('bookmark')
        .where("idMeal", isEqualTo: idMeal)
        .get();

    for (var doc in bookmarkCollection.docs) {
      await doc.reference.delete();
    }
    isSaved.value = false;
  }

  Future<void> checkBookmarkStatus() async {
    final bookmarkCollection = await data
        .collection('data')
        .doc(auth.currentUser!.uid)
        .collection('bookmark')
        .where("idMeal", isEqualTo: dataDetail.value.idMeal)
        .get();

    if (bookmarkCollection.docs.isNotEmpty) {
      isSaved.value = true;
      print('ini sudah di save');
    } else {
      isSaved.value = false;
    }
  }

  Future<void> getImageUrl(List<String> ingredients) async {
    ingredientImages.clear();
    for (var ingredient in ingredients) {
      final String imageUrl =
          'https://www.themealdb.com/images/ingredients/$ingredient.png';
      print("Fetching image from URL: $imageUrl");
      ingredientImages.add(imageUrl);
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
    return isExpanded.value ? 'See less' : 'See more....';
  }
}
