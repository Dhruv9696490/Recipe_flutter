import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:recipe2/model/recipe_api.dart';
import '../model/recipe_model.dart';

class RecipeViewModel extends ChangeNotifier {
  final RecipeApi _recipeApi = RecipeApi();
  final Box box = Hive.box("recipes");
  List<Category> _recipeData = [];
  List<Category> get recipeData => _recipeData;
  bool _loading = false;
  bool get loading => _loading;
  String _error = "";
  String get error => _error;
  Future<void> getAllRecipe() async {
    _loading = true;
    _error = "";
    notifyListeners();
    try {
      _recipeData = await _recipeApi.getAllRecipe();
      box.clear();
      for (int i = 0; i < _recipeData.length; i++) {
        box.put(i.toString(), _recipeData[i].toJson());
      }
    } on Exception catch (e) {
      if (box.isNotEmpty) {
        for (int i = 0; i < box.length; i++) {
          _recipeData.add(Category.fromJson(box.get(i.toString())));
        }
      } else {
        _error = e.toString();
      }
    }
    _loading = false;
    notifyListeners();
  }
}
