import 'package:fish_and_meat_app/constants/appfontsize.dart';
import 'package:fish_and_meat_app/controllers/product_details_screen_controllers/selected_category_controller.dart';
import 'package:flutter/material.dart';

class CustomComboBox extends StatelessWidget {
  final String label;
  final SelectedCategoryController selectedCategoryController;
  CustomComboBox({
    super.key,
    required this.label,
    required this.selectedCategoryController,
  });

  final List<String> _categories = [
    'Chicken',
    'Beef',
    'Mutton',
    'Pork',
    'Salt Water Fish',
    'Fresh Water Fish',
    'shell Fish',
    'Prawns',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.teal.withAlpha(50),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: Appfontsize.small14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                value: selectedCategoryController.selectedCategory.value,
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    selectedCategoryController.setCategory(newValue);
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a category';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
