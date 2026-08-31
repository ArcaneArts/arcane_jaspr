import 'package:arcane_jaspr/component/form/field.dart';
import 'package:arcane_jaspr/component/form/field_wrapper.dart';
import 'package:arcane_jaspr/component/form/provider.dart';
import 'package:arcane_jaspr/flutter.dart';
import 'package:arcane_jaspr/util/appearance/colors.dart';
import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

class ArcaneColorField extends StatelessWidget {
  final ArcaneFieldProvider<Color> provider;
  final String? name;
  final String? description;

  const ArcaneColorField({
    required this.provider,
    this.name,
    this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ArcaneField<Color>(
    meta: ArcaneFieldMetadata(name: name, description: description),
    provider: provider,
    builder:
        (BuildContext context, Color value, void Function(Color) onChanged) =>
            ArcaneFieldWrapper(
              labelText: name,
              description: description,
              field: Component.element(
                tag: 'input',
                attributes: <String, String>{
                  'type': 'color',
                  'value': value.hex.length == 9
                      ? value.hex.substring(0, 7)
                      : value.hex,
                },
                styles: const dom.Styles(
                  raw: <String, String>{
                    'width': '100%',
                    'height': '2.75rem',
                    'border': '1px solid var(--border)',
                    'border-radius': 'var(--radius-md)',
                    'background': 'var(--card)',
                  },
                ),
                events: <String, dynamic Function(dynamic)>{
                  'input': (dynamic event) {
                    final dynamic target = event.target;
                    onChanged(
                      _colorFromHex((target.value as String?) ?? '#000000'),
                    );
                    return null;
                  },
                },
              ),
            ),
  );
}

Color _colorFromHex(String value) {
  final String normalized = value.replaceAll('#', '');
  final int parsed = int.parse(normalized, radix: 16);
  return Color(0xFF000000 | parsed);
}
