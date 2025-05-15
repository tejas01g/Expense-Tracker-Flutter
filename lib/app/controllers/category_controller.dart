import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../models/category_model.dart';
import 'package:flutter/material.dart';

class CategoryController extends GetxController {
  late Box<CategoryModel> _categoryBox;
  var categories = <CategoryModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _categoryBox = Hive.box<CategoryModel>('categories');
    loadCategories();
  }

  void loadCategories() {
    categories.value = _categoryBox.values.toList();
  }

  Future<void> addCategory(CategoryModel category) async {
    await _categoryBox.put(category.id, category);
    loadCategories();
  }

  Future<void> updateCategory(CategoryModel category) async {
    await category.save();
    loadCategories();
  }

  Future<void> deleteCategory(String id) async {
    await _categoryBox.delete(id);
    loadCategories();
  }

  // Subcategory management
  Future<void> addSubcategory(CategoryModel category, String subcategory) async {
    category.subcategories.add(subcategory);
    await category.save();
    loadCategories();
  }

  Future<void> removeSubcategory(CategoryModel category, String subcategory) async {
    category.subcategories.remove(subcategory);
    await category.save();
    loadCategories();
  }
} 