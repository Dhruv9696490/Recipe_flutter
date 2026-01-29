import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe2/view_model/recipe_view_model.dart';
import 'package:recipe2/pages/description_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.width * 0.10,
        centerTitle: true,
        title: Text(
          "Recipe App",
          style: TextStyle(
            fontSize: size.width * 0.06,
            fontWeight: FontWeight.bold,
            color: Colors.grey[900],
          ),
        ),
        backgroundColor: Colors.red[50],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<RecipeViewModel>().getAllRecipe(),
        backgroundColor: Colors.red[50],
        child: Consumer<RecipeViewModel>(
          builder: (context, vm, _) {
            if (vm.loading == true) {
              return const Center(
                child: CircularProgressIndicator(strokeWidth: 20),
              );
            } else if (vm.error.isNotEmpty && vm.recipeData.isEmpty) {
              return Center(child: Text(vm.error));
            } else if (vm.recipeData.isNotEmpty) {
              return Container(
                color: Colors.grey[400],
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: size.width > 650 ? 3 : 2,
                  ),
                  itemCount: vm.recipeData.length,
                  itemBuilder: (context, index) {
                    final item = vm.recipeData[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DescriptionScreen(category: item);
                            },
                          ),
                        );
                      },
                      child: Card(
                        color: Colors.red[50],
                        shadowColor: Colors.red,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsetsGeometry.all(16),
                                child: Image.network(
                                  item.strCategoryThumb ?? "",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.strCategory ?? "",
                              style: TextStyle(
                                fontSize: size.width * 0.03,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            return SizedBox(child: Text('something went wrong2'));
          },
        ),
      ),
    );
  }
}
