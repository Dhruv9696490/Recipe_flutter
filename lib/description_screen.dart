import 'package:flutter/material.dart';
import 'package:recipe2/RecipeModel.dart';

class DescriptionScreen extends StatelessWidget {
  final Category category;
  const DescriptionScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(child: Card(margin: EdgeInsets.all(50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1000)),
                color: Colors.purple[100],child: Image.network(category.strCategoryThumb ??""))),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(category.strCategoryDescription ?? "",style: TextStyle(
                    fontSize: 24
                  ),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
