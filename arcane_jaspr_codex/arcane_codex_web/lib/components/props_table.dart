import 'package:arcane_jaspr/arcane_jaspr.dart';

/// A table component for documenting component properties.
///
/// Displays property names, types, defaults, and descriptions in a structured table format.
class PropsTable extends StatelessComponent {
  final List<PropItem> props;
  final String? title;

  const PropsTable({
    super.key,
    required this.props,
    this.title,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        margin: MarginPreset.bottomXl,
      ),
      children: [
        if (title != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontWeight: FontWeight.w600,
              fontSize: FontSize.lg,
              textColor: TextColor.primary,
              margin: MarginPreset.bottomMd,
            ),
            children: [ArcaneText(title!)],
          ),
        ArcaneDiv(
          styles: const ArcaneStyleData(
            borderRadius: Radius.lg,
            overflow: Overflow.auto,
            border: BorderPreset.standard,
          ),
          children: [
            ArcaneDataTable<PropItem>(
              items: props,
              columns: [
                ArcaneDataColumn<PropItem>(
                  header: 'Property',
                  builder: (prop) => ArcaneDiv(
                    styles: const ArcaneStyleData(
                      display: Display.flex,
                      alignItems: AlignItems.center,
                      gap: Gap.sm,
                    ),
                    children: [
                      ArcaneSpan(
                        styles: const ArcaneStyleData(
                          fontFamily: FontFamily.mono,
                          fontSize: FontSize.sm,
                          fontWeight: FontWeight.w500,
                          textColor: TextColor.accent,
                        ),
                        child: ArcaneText(prop.name),
                      ),
                      if (prop.required)
                        ArcaneSpan(
                          styles: const ArcaneStyleData(
                            fontSize: FontSize.xs,
                            padding: PaddingPreset.inlineCode,
                            borderRadius: Radius.xs,
                            textColor: TextColor.error,
                            raw: {
                              'background': 'rgba(239, 68, 68, 0.15)',
                            },
                          ),
                          child: const ArcaneText('required'),
                        ),
                    ],
                  ),
                ),
                ArcaneDataColumn<PropItem>(
                  header: 'Type',
                  builder: (prop) => ArcaneSpan(
                    styles: const ArcaneStyleData(
                      fontFamily: FontFamily.mono,
                      fontSize: FontSize.sm,
                      textColor: TextColor.muted,
                    ),
                    child: ArcaneText(prop.type),
                  ),
                ),
                ArcaneDataColumn<PropItem>(
                  header: 'Default',
                  builder: (prop) => prop.defaultValue != null
                      ? ArcaneSpan(
                          styles: const ArcaneStyleData(
                            fontFamily: FontFamily.mono,
                            fontSize: FontSize.sm,
                            padding: PaddingPreset.inlineCode,
                            background: Background.glassTint,
                            borderRadius: Radius.xs,
                            textColor: TextColor.muted,
                          ),
                          child: ArcaneText(prop.defaultValue!),
                        )
                      : ArcaneSpan(
                          styles: const ArcaneStyleData(
                            fontSize: FontSize.sm,
                            textColor: TextColor.muted,
                          ),
                          child: const ArcaneText('-'),
                        ),
                ),
                ArcaneDataColumn<PropItem>(
                  header: 'Description',
                  builder: (prop) => ArcaneText(prop.description),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// Represents a single property in the props table
class PropItem {
  final String name;
  final String type;
  final String description;
  final String? defaultValue;
  final bool required;

  const PropItem({
    required this.name,
    required this.type,
    required this.description,
    this.defaultValue,
    this.required = false,
  });
}

/// A compact enum table for showing enum values
class EnumTable extends StatelessComponent {
  final String enumName;
  final List<EnumValue> values;
  final String? description;

  const EnumTable({
    super.key,
    required this.enumName,
    required this.values,
    this.description,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        margin: MarginPreset.bottomXl,
      ),
      children: [
        // Enum name header
        ArcaneDiv(
          styles: const ArcaneStyleData(
            display: Display.flex,
            alignItems: AlignItems.center,
            gap: Gap.md,
            margin: MarginPreset.bottomMd,
          ),
          children: [
            ArcaneSpan(
              styles: const ArcaneStyleData(
                fontFamily: FontFamily.mono,
                fontWeight: FontWeight.w600,
                fontSize: FontSize.lg,
                textColor: TextColor.accent,
              ),
              child: ArcaneText(enumName),
            ),
          ],
        ),

        if (description != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontSize: FontSize.sm,
              textColor: TextColor.muted,
              margin: MarginPreset.bottomMd,
            ),
            children: [ArcaneText(description!)],
          ),

        // Values table
        ArcaneDiv(
          styles: const ArcaneStyleData(
            borderRadius: Radius.lg,
            overflow: Overflow.auto,
            border: BorderPreset.standard,
          ),
          children: [
            ArcaneDataTable<EnumValue>(
              items: values,
              columns: [
                ArcaneDataColumn<EnumValue>(
                  header: 'Value',
                  builder: (value) => ArcaneSpan(
                    styles: const ArcaneStyleData(
                      fontFamily: FontFamily.mono,
                      fontSize: FontSize.sm,
                      textColor: TextColor.accent,
                    ),
                    child: ArcaneText(value.name),
                  ),
                ),
                ArcaneDataColumn<EnumValue>(
                  header: 'CSS Output',
                  builder: (value) => ArcaneSpan(
                    styles: const ArcaneStyleData(
                      fontFamily: FontFamily.mono,
                      fontSize: FontSize.sm,
                      textColor: TextColor.muted,
                    ),
                    child: ArcaneText(value.cssValue),
                  ),
                ),
                ArcaneDataColumn<EnumValue>(
                  header: 'Description',
                  builder: (value) => ArcaneText(value.description),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// Represents an enum value
class EnumValue {
  final String name;
  final String cssValue;
  final String description;

  const EnumValue({
    required this.name,
    required this.cssValue,
    this.description = '',
  });
}
