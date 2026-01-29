
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:recipe2/view_model/recipe_view_model.dart';
import 'package:recipe2/pages/category_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = dir.path;
   

  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_){
          return RecipeViewModel()..getAllRecipe();
      }),
    ],
    child: const MyApp()));
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














