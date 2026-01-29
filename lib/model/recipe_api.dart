import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:recipe2/secrets/secrets.dart';
import 'recipe_model.dart';


class RecipeApi {
  static const String baseurl = Secrets.url;
  Future<List<Category>> getAllRecipe() async {
    final bool isConnected = await InternetConnection().hasInternetAccess;
    if (isConnected == false) {
      throw Exception("no internet connection");
    }
    try {
      final instance = await http.get(Uri.parse(baseurl));
      if (instance.statusCode == 200) {
        final response = jsonDecode(instance.body);
        final List recipe = response['categories'];
        return recipe.map((item) {
          return Category.fromJson(item);
        }).toList();
      } else {
        throw Exception("something went wrong");
      }
    } on SocketException catch (e) {
      throw Exception(e.toString());
    }
  }
}
