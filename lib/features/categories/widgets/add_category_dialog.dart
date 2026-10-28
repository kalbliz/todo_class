import 'package:flutter/material.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:todo_class/features/categories/notifiers/categories_notifier.dart';
import 'package:todo_class/models/category_model.dart';
import 'package:todo_class/utils/buttons/app_button.dart';
import 'package:todo_class/utils/dialogs/app_dialog.dart';
import 'package:todo_class/utils/text_fields/app_text_field.dart';

/// Dialog for creating a new category. Returns the created category.
class AddCategoryDialog extends StatefulWidget {
  const AddCategoryDialog({super.key});

  static Future<CategoryModel?> show(BuildContext context) {
    return AppDialogs.show<CategoryModel>(
      context: context,
      child: const AddCategoryDialog(),
    );
  }

  @override
  State<AddCategoryDialog> createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _isSaving = true);
    final category =
        await CategoriesNotifier.instance.addCategory(_nameController.text);
    if (!mounted) return;
    Navigator.of(context).pop(category);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('New category', style: AppTextStyles.heading3),
          const SizedBox(height: 16),
          AppTextField(
            controller: _nameController,
            label: 'Name',
            hint: 'e.g. Shopping',
            textInputAction: TextInputAction.done,
            validator: CategoriesNotifier.instance.validateName,
          ),
          const SizedBox(height: 20),
          AppButton(
            label: 'Add Category',
            icon: Icons.add,
            isLoading: _isSaving,
            onPressed: _save,
          ),
        ],
      ),
    );
  }
}
