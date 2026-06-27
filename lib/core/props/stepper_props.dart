import 'package:arcane_jaspr/flutter.dart';

import '../shared/shared.dart';

export '../shared/shared.dart' show ComponentSize;

enum StepsLayout {
  vertical,
  horizontal,
}

enum StepStatus {
  complete,
  current,
  pending,
}

/// Step item data.
class StepItemData {
  final String title;
  final String? description;
  final StepStatus status;
  final Widget? content;

  const StepItemData({
    required this.title,
    this.description,
    this.status = StepStatus.pending,
    this.content,
  });
}

/// Stepper component properties.
class StepperProps {
  final List<StepItemData> items;
  final StepsLayout layout;
  final ComponentSize size;
  final bool showConnectors;
  final int? currentStep;
  final void Function(int index)? onStepTap;

  const StepperProps({
    required this.items,
    this.layout = StepsLayout.horizontal,
    this.size = ComponentSize.md,
    this.showConnectors = true,
    this.currentStep,
    this.onStepTap,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for stepper components.
mixin StepperRendererContract {
  Widget stepper(StepperProps props);
}
