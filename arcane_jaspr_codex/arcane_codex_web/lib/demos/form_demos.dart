import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Demo builders for form components
class FormDemos {
  static List<Component> form() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '300px',
            padding: PaddingPreset.md,
            background: Background.surface,
            borderRadius: Radius.md,
          ),
          children: [
            ArcaneColumn(
              gapSize: Gap.md,
              children: [
                ArcaneTextInput(
                    label: 'Email', placeholder: 'you@example.com', name: 'email'),
                ArcaneTextInput(
                    label: 'Password', placeholder: '••••••••', name: 'password'),
                ArcaneButton.primary(label: 'Submit', onPressed: () {}),
              ],
            ),
          ],
        ),
      ];

  static List<Component> field() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '300px'),
          children: [
            ArcaneFieldWrapper(
              labelText: 'Field Label',
              field: ArcaneTextInput(placeholder: 'Enter value', name: 'field'),
            ),
          ],
        ),
      ];

  static List<Component> fieldWrapper() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '300px'),
          children: [
            ArcaneFieldWrapper(
              labelText: 'Wrapped Field',
              description: 'Helper text here',
              field: ArcaneTextInput(placeholder: 'Input', name: 'wrapped'),
            ),
          ],
        ),
      ];
}
