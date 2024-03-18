
class Categories {
  final int id;
  final String name;
  final int parentCategoryId;
  final List<Categories> subCategories;

  Categories({
    required this.id,
    required this.name,
    required this.parentCategoryId,
    required this.subCategories,
  });

  factory Categories.fromJson(Map<String, dynamic> json) {
    List<Categories> subCategories = <Categories>[];
    if (json['subCategories'] != null) {
      subCategories = List<Categories>.from(
        json['subCategories'].map((subJson) => Categories.fromJson(subJson)),
      );
    }
    return Categories(
      id: json['id'] as int,
      name: json['name'] as String,
      parentCategoryId: json['parentCategoryId'] as int,
      subCategories: subCategories,
    );
  }
}

