import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe2/RecipeViewModel.dart';
import 'package:recipe2/description_screen.dart';


class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RecipeViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Recipe App",style: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.bold,
          color: Colors.grey[700]
        ),),
        backgroundColor: Colors.red[100],
      ),
      body: RefreshIndicator(onRefresh: ()=> viewModel.getAllRecipe(),
      backgroundColor: Colors.red[100],
      child: Builder(builder: (context){
        if(viewModel.loading){
          return const Center(child: CircularProgressIndicator(),);
        }
        else if(viewModel.error.isNotEmpty){
          return const Center(child: Text("Something Went Wrong"),);
        }else{
          return Container(
            color: Colors.purple[100],
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: viewModel.recipeData.length,
            itemBuilder: (context,index){
              final item = viewModel.recipeData[index];
              return InkWell(
                onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context){
                   return DescriptionScreen(category: item);
                 }));
                },
                child: Card(
                  color:Colors.red[100] ,
                  shadowColor: Colors.red,
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  margin: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child: Image.network(item.strCategoryThumb ?? "",fit: BoxFit.contain,width: 200,height: 200,)),
                      SizedBox(height: 8,),
                      Text(item.strCategory ?? "",style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700]
                      ),)
                    ],
                  ),
                ),
              );
            }),
          );
        }
      })
      ),
    );
  }
}
