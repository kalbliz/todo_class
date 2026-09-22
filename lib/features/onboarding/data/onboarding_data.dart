import 'package:todo_class/core/constants/app_assets.dart';
import 'package:todo_class/features/onboarding/models/onboarding_slide.dart';

/// The 3 onboarding slides shown on first launch.
abstract final class OnboardingData {
  static const List<OnboardingSlide> slides = [
    OnboardingSlide(
      title: 'Organize your tasks',
      description:
          'Create, edit, and complete todos so nothing slips through the cracks.',
      imagePath: AppAssets.onboarding1,
    ),
    OnboardingSlide(
      title: 'Plan your week',
      description:
          'Use the calendar to see what is due and stay ahead of deadlines.',
      imagePath: AppAssets.onboarding2,
    ),
    OnboardingSlide(
      title: 'Stay focused',
      description:
          'Track progress, focus on what matters, and build better habits.',
      imagePath: AppAssets.onboarding3,
    ),
  ];
}
