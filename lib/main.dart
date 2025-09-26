
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:recipe2/RecipeViewModel.dart';
import 'package:recipe2/category_screen.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_){
          return RecipeViewModel()..getAllRecipe();
      }),
    ],
    child: const MyApp()),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Meal Categories",
      theme: ThemeData(primarySwatch: Colors.pink),
      home: CategoryScreen(),
    );
  }
}














