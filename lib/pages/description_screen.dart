import 'package:flutter/material.dart';
import 'package:recipe2/model/recipe_model.dart';

class DescriptionScreen extends StatelessWidget {
  final Category category;
  const DescriptionScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.grey[400] ,
      ),
      body: Container(
        color: Colors.grey[400],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(flex: 1, child: Card(margin: EdgeInsets.all(16),
            shadowColor: Colors.red[200],
            elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
                color: Colors.red[50],child: Image.network(category.strCategoryThumb ??"",fit: BoxFit.contain,))),
            Expanded(
              flex: 1,
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                    child: Text(category.strCategoryDescription ?? "",style: TextStyle(
                      fontSize: 24
                    ),),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
