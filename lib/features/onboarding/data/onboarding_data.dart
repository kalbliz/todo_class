import 'package:todo_class/core/constants/app_assets.dart';
import 'package:todo_class/features/onboarding/models/onboarding_slide.dart';

/// The 3 onboarding slides shown on first launch.
abstract final class OnboardingData {
  static const List<OnboardingSlide> slides = [
    OnboardingSlide(
      title: 'Manage your tasks',
      description:
          'You can easily manage all of your daily tasks in DoMe for free',
      imagePath: AppAssets.onboarding1,
    ),
    OnboardingSlide(
      title: 'Create daily routine',
      description:
          'Use the calendar to see what is due and stay ahead of deadlines.',
      imagePath: AppAssets.onboarding2,
    ),
    OnboardingSlide(
      title: 'Orgonaize your tasks',
      description:
          'You can organize your daily tasks by adding your tasks into separate categories',
      imagePath: AppAssets.onboarding3,
    ),
  ];
}
