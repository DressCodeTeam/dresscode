import 'package:dresscode/src/models/base.model.dart';
import 'package:dresscode/src/shared/extensions/json_extension.dart';

class Category extends BaseModel {
  Category({
    required this.id,
    required this.name,
    required this.subcategories,
  });

  factory Category.fromJSON(Map<String, dynamic> json) {
    return Category(
      id: json.require<int>('id', className: 'Category'),
      name: json.require<String>('name', className: 'Category'),
      subcategories: (
        json.require<List<dynamic>>(
          'subcategories',
          className: 'Category'
        )
        .map((e) => Subcategory.fromJson(e as Map<String, dynamic>))
        .toList()
      ),
    );
  }

  final int id;
  final String name;
  final List<Subcategory> subcategories;
}

class Subcategory {
  Subcategory({
    required this.id,
    required this.name,
  });
  
  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json.require<int>('id', className: 'Subcategory'),
      name: json.require<String>('name', className: 'Subcategory'),
    );
  }

  final int id;
  final String name;
}
