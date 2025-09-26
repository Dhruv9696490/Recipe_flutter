import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'RecipeModel.dart';

class RecipeApi{
  static const String baseurl = "https://www.themealdb.com/api/json/v1/1/categories.php";
  Future<List<Category>> getAllRecipe()async{
    final instance = await http.get(Uri.parse(baseurl));
    if(instance.statusCode==200){
      final response = jsonDecode(instance.body);
      final List recipe = response['categories'];
      return recipe.map((item){
        return Category.fromJson(item);
      }).toList();
    }else{
      throw Exception("something went wrong");
    }
  }
}