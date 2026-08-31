import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr/html.dart';

/// A table component for documenting component properties.
///
/// Displays property names, types, defaults, and descriptions in a structured table format.
class PropsTable extends StatelessWidget {
  final List<PropItem> props;
  final String? title;

  const PropsTable({super.key, required this.props, this.title});

  @override
  Widget build(BuildContext context) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(margin: MarginPreset.bottomXl),
      children: [
        if (title != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontWeight: FontWeight.w600,
              fontSize: FontSize.lg,
              textColor: TextColor.primary,
              margin: MarginPreset.bottomMd,
            ),
            children: [Text(title!)],
          ),
        ArcaneDiv(
          styles: const ArcaneStyleData(
            borderRadius: Radius.md,
            overflow: Overflow.auto,
            border: BorderPreset.standard,
          ),
          children: [
            DataTable(
              items: props,
              columns: [
                DataColumn(
                  header: 'Property',
                  builder: (PropItem prop) => ArcaneDiv(
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
                        child: Text(prop.name),
                      ),
                      if (prop.required)
                        ArcaneSpan(
                          styles: const ArcaneStyleData(
                            fontSize: FontSize.xs,
                            padding: PaddingPreset.inlineCode,
                            borderRadius: Radius.xs,
                            textColor: TextColor.error,
                            backgroundCustom:
                                'rgba(var(--arcane-destructive-rgb), 0.15)',
                          ),
                          child: const Text('required'),
                        ),
                    ],
                  ),
                ),
                DataColumn(
                  header: 'Type',
                  builder: (PropItem prop) => ArcaneSpan(
                    styles: const ArcaneStyleData(
                      fontFamily: FontFamily.mono,
                      fontSize: FontSize.sm,
                      textColor: TextColor.mutedForeground,
                    ),
                    child: Text(prop.type),
                  ),
                ),
                DataColumn(
                  header: 'Default',
                  builder: (PropItem prop) => prop.defaultValue != null
                      ? ArcaneSpan(
                          styles: const ArcaneStyleData(
                            fontFamily: FontFamily.mono,
                            fontSize: FontSize.sm,
                            padding: PaddingPreset.inlineCode,
                            background: Background.code,
                            borderRadius: Radius.xs,
                            textColor: TextColor.mutedForeground,
                          ),
                          child: Text(prop.defaultValue!),
                        )
                      : ArcaneSpan(
                          styles: const ArcaneStyleData(
                            fontSize: FontSize.sm,
                            textColor: TextColor.mutedForeground,
                          ),
                          child: const Text('-'),
                        ),
                ),
                DataColumn(
                  header: 'Description',
                  builder: (PropItem prop) => Text(prop.description),
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
class EnumTable extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(margin: MarginPreset.bottomXl),
      children: [
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
              child: Text(enumName),
            ),
          ],
        ),
        if (description != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontSize: FontSize.sm,
              textColor: TextColor.mutedForeground,
              margin: MarginPreset.bottomMd,
            ),
            children: [Text(description!)],
          ),
        ArcaneDiv(
          styles: const ArcaneStyleData(
            borderRadius: Radius.md,
            overflow: Overflow.auto,
            border: BorderPreset.standard,
          ),
          children: [
            DataTable(
              items: values,
              columns: [
                DataColumn(
                  header: 'Value',
                  builder: (EnumValue value) => ArcaneSpan(
                    styles: const ArcaneStyleData(
                      fontFamily: FontFamily.mono,
                      fontSize: FontSize.sm,
                      textColor: TextColor.accent,
                    ),
                    child: Text(value.name),
                  ),
                ),
                DataColumn(
                  header: 'CSS Output',
                  builder: (EnumValue value) => ArcaneSpan(
                    styles: const ArcaneStyleData(
                      fontFamily: FontFamily.mono,
                      fontSize: FontSize.sm,
                      textColor: TextColor.mutedForeground,
                    ),
                    child: Text(value.cssValue),
                  ),
                ),
                DataColumn(
                  header: 'Description',
                  builder: (EnumValue value) => Text(value.description),
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
