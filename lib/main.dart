
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Meal Categories",
      theme: ThemeData(primarySwatch: Colors.pink),
      home: const CategoryPage(),
    );
  }
}


class Category{
  final String idCategory;
  final String strCategory;
  final String strCategoryThumb;
  final String strCategoryDescription;
  Category({required this.idCategory, required this.strCategory, required this.strCategoryThumb ,required this.strCategoryDescription});
  factory Category.fromJson(Map<String,dynamic> json){
    return Category(
        idCategory: json['idCategory'] ?? '',
        strCategory: json['strCategory'] ?? '',
        strCategoryThumb: json['strCategoryThumb'] ?? '',
        strCategoryDescription: json['strCategoryDescription'] ?? '');
    }
}
//todolist nahi lagayaa maine
Future<List<Category>> fetchAllRecipe() async{
  final response = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php"));
  final data = jsonDecode(response.body);
  final List list = data["categories"];
  if(list.isNotEmpty){
    return list.map((i){
      return Category.fromJson(i);
    }).toList();
  }else{
    throw Exception("error 404");
  }
}

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(
        "Recipe App",
        textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 35,
        fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w400
      ),),
      centerTitle: true,),
      body: FutureBuilder(
          future: fetchAllRecipe(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
               return Center(
                 child: CircularProgressIndicator(value: 45),
               );
            }else if(snapshot.hasError){
              return Center(
                child: Text("Something went wrong"),
              );
            }else if(!snapshot.hasData){
              return Center(
                child: Text("data not found"),
              );
            }else {
              final List<Category> list = snapshot.data!;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,           // number of columns
                  crossAxisSpacing: 10,        // space between columns
                  mainAxisSpacing: 10,         // space between rows
                  childAspectRatio: 0.8,       // width/height ratio
                ),
                itemCount: list.length,
                itemBuilder: (context,index){
                  final item = list[index];
                  return GestureDetector(
                    onTap: (){
                       Navigator.push(context, MaterialPageRoute(
                          builder: (_){
                            return RecipeScreen(category: item);
                          } ));
                    },
                    child: (
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: Image.network(item.strCategoryThumb)),
                          Text(item.strCategory,style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold
                          ),)
                        ],
                      )
                    ),
                  );
                },

              );

            }
          }
      )
    );
  }
}

class RecipeScreen extends StatelessWidget {
  final Category category;
  const RecipeScreen({super.key,required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.fromLTRB(16, 30, 16, 16),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(category.strCategoryThumb,
              height: 300,
              fit: BoxFit.fitWidth ,),
              SizedBox(height: 8),
              Text(category.strCategory,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24
              ),),
              SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child:
                    Text(category.strCategoryDescription,
                    style: TextStyle(
                      fontSize: 30
                    ),),
                ),
              )
            ],
      )
      ),
    );
  }
}


