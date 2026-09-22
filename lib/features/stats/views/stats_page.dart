import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:todo_class/core/router/app_navigator.dart';
import 'package:todo_class/core/theme/app_colors.dart';
import 'package:todo_class/core/theme/app_text_styles.dart';
import 'package:todo_class/utils/buttons/app_button.dart';

/// Stats page using fl_chart — placeholder data for class demos.
class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stats'),
        leading: AppIconButton(
          icon: Icons.arrow_back,
          onPressed: () => AppNavigator.back(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Weekly progress', style: AppTextStyles.heading3),
            const SizedBox(height: 24),
            SizedBox(
              height: 220,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 2,
                  centerSpaceRadius: 48,
                  sections: [
                    PieChartSectionData(
                      value: 60,
                      title: 'Done',
                      color: AppColors.success,
                      radius: 50,
                      titleStyle: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      value: 40,
                      title: 'Left',
                      color: AppColors.primary,
                      radius: 50,
                      titleStyle: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Replace placeholder chart data with real task counts later.',
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
