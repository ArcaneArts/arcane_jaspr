import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/dom.dart' as dom;
export 'package:arcane_jaspr/component/view/icon.dart'
    show ArcaneGlyph, IconSize;

typedef IconData = ArcaneGlyph Function({IconSize size});

class Icon extends StatelessWidget {
  final IconData icon;
  final IconSize size;
  final String? color;
  final String? label;

  const Icon(
    this.icon, {
    this.size = IconSize.md,
    this.color,
    this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) => dom.span(
    styles: dom.Styles(
      raw: <String, String>{
        'color': ?color,
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
      },
    ),
    attributes: <String, String>{
      'aria-label': ?label,
      if (label != null) 'role': 'img',
    },
    <Widget>[icon(size: size)],
  );
}

class Icons {
  const Icons._();

  static IconData get calendar => ArcaneIcon.calendar;
  static IconData get check => ArcaneIcon.check;
  static IconData get chevronDown => ArcaneIcon.chevronDown;
  static IconData get chevronLeft => ArcaneIcon.chevronLeft;
  static IconData get chevronRight => ArcaneIcon.chevronRight;
  static IconData get chevronUp => ArcaneIcon.chevronUp;
  static IconData get circleAlert => ArcaneIcon.circleAlert;
  static IconData get clock3 => ArcaneIcon.clock3;
  static IconData get image => ArcaneIcon.image;
  static IconData get menu => ArcaneIcon.menu;
  static IconData get moreHorizontal => ArcaneIcon.moreHorizontal;
  static IconData get palette => ArcaneIcon.palette;
  static IconData get pencil => ArcaneIcon.pencil;
  static IconData get plus => ArcaneIcon.plus;
  static IconData get search => ArcaneIcon.search;
  static IconData get trash2 => ArcaneIcon.trash2;
  static IconData get x => ArcaneIcon.x;
}
