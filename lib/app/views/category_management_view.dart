import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/category_controller.dart';
import '../models/category_model.dart';

class CategoryManagementView extends StatelessWidget {
  CategoryManagementView({Key? key}) : super(key: key);

  final CategoryController controller = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Categories')),
      body: Obx(() {
        final categories = controller.categories;
        if (categories.isEmpty) {
          return const Center(child: Text('No categories yet.'));
        }
        return ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ExpansionTile(
                leading: Icon(category.icon, color: category.color),
                title: Text(category.name),
                children: [
                  Wrap(
                    spacing: 8,
                    children: category.subcategories
                        .map((sub) => Chip(
                              label: Text(sub),
                              onDeleted: () => controller.removeSubcategory(category, sub),
                            ))
                        .toList(),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text('Add Subcategory'),
                    onPressed: () => _showAddSubcategoryDialog(context, category),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _showAddEditCategoryDialog(context, category: category),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => controller.deleteCategory(category.id),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddEditCategoryDialog(context),
        child: const Icon(Icons.add),
        tooltip: 'Add Category',
      ),
    );
  }

  void _showAddEditCategoryDialog(BuildContext context, {CategoryModel? category}) {
    final nameController = TextEditingController(text: category?.name ?? '');
    IconData selectedIcon = category?.icon ?? Icons.category;
    Color selectedColor = category?.color ?? Colors.blue;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(category == null ? 'Add Category' : 'Edit Category'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Category Name'),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Icon:'),
                  IconButton(
                    icon: Icon(selectedIcon),
                    onPressed: () async {
                      // For simplicity, just toggle between a few icons
                      final icons = [Icons.category, Icons.shopping_cart, Icons.restaurant, Icons.directions_car];
                      final idx = icons.indexOf(selectedIcon);
                      selectedIcon = icons[(idx + 1) % icons.length];
                      (context as Element).markNeedsBuild();
                    },
                  ),
                  const SizedBox(width: 16),
                  const Text('Color:'),
                  GestureDetector(
                    onTap: () async {
                      // For simplicity, just toggle between a few colors
                      final List<Color> colors = [
                        Colors.blue,
                        Colors.orange,
                        Colors.green,
                        Colors.purple,
                        Colors.red,
                      ];
                      final idx = colors.indexOf(selectedColor);
                      selectedColor = colors[(idx + 1) % colors.length];
                      (context as Element).markNeedsBuild();
                    },
                    child: CircleAvatar(backgroundColor: selectedColor, radius: 12),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text.trim();
                if (name.isEmpty) return;
                if (category == null) {
                  controller.addCategory(CategoryModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: name,
                    iconCodePoint: selectedIcon.codePoint,
                    colorValue: selectedColor.value,
                    subcategories: [],
                  ));
                } else {
                  category.name = name;
                  category.iconCodePoint = selectedIcon.codePoint;
                  category.colorValue = selectedColor.value;
                  controller.updateCategory(category);
                }
                Navigator.of(context).pop();
              },
              child: Text(category == null ? 'Add' : 'Save'),
            ),
          ],
        );
      },
    );
  }

  void _showAddSubcategoryDialog(BuildContext context, CategoryModel category) {
    final subController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Subcategory'),
          content: TextField(
            controller: subController,
            decoration: const InputDecoration(labelText: 'Subcategory Name'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final sub = subController.text.trim();
                if (sub.isNotEmpty) {
                  controller.addSubcategory(category, sub);
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
} 