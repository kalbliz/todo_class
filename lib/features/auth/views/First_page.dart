import 'package:flutter/material.dart';
import 'package:todo_class/core/router/app_navigator.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:todo_class/services/storage/local_storage_service.dart';
import 'package:todo_class/utils/buttons/app_button.dart';
import 'package:todo_class/utils/text_fields/app_text_field.dart';


class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        title: const Text('Index'),
         leading: IconButton(
    icon: const Icon(Icons.chevron_left),
    onPressed: () {
      // Handle navigation drawer or back action
    },
  ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppButton(
              label: 'LOGIN',
              isLoading: false,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
