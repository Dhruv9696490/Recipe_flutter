
import 'package:flutter/material.dart';
import 'package:recipe2/RecipeApi.dart';
import 'RecipeModel.dart';

class RecipeViewModel extends ChangeNotifier{
  final RecipeApi _recipeApi = RecipeApi();
  bool _loading=false;
  String _error="";
  List<Category> _recipeData = [];
  bool get loading => _loading;
  String get error => _error;
  List<Category>  get recipeData => _recipeData;
  Future<void> getAllRecipe() async{
    _loading=true;
    notifyListeners();
    try{
      _recipeData = await _recipeApi.getAllRecipe();
    }catch(e){
      _error = "something went wrong";
    }
    _loading=false;
    notifyListeners();
  }
}