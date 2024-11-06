import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flavour_lab/app/controllers/firebase_service.dart';
import 'package:flavour_lab/app/data/data_provider.dart';
import 'package:flavour_lab/app/data/model_categori.dart';
import 'package:flavour_lab/app/data/model_detail.dart';
import 'package:get/get.dart';

class BookmarkController extends GetxController {
  final auth = FirebaseService().auth;
  final data = FirebaseService().data;

  var searchResults = <Meal>[].obs;

  var isLoading = false.obs;
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

  Stream<QuerySnapshot<Object?>> getData() {
    CollectionReference listdata = data
        .collection('data')
        .doc(auth.currentUser!.uid)
        .collection('bookmark');
    return listdata.orderBy('createdAt', descending: true).snapshots();
  }
}
