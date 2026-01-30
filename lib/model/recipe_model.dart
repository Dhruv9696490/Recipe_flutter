class Category {
  String? idCategory;
  String? strCategory;
  String? strCategoryThumb;
  String? strCategoryDescription;

  Category(
      {this.idCategory,
        this.strCategory,
        this.strCategoryThumb,
        this.strCategoryDescription});

  Category.fromJson(Map<dynamic, dynamic> json) {
    idCategory = json['idCategory'];
    strCategory = json['strCategory'];
    strCategoryThumb = json['strCategoryThumb'];
    strCategoryDescription = json['strCategoryDescription'];
  }

  Map<dynamic, dynamic> toJson() {
    return <dynamic, dynamic>{
      'idCategory': idCategory,
      'strCategory': strCategory,
      'strCategoryThumb': strCategoryThumb,
      'strCategoryDescription': strCategoryDescription,
    };
  }
}
