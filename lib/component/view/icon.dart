import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' show Unit;
import 'package:jaspr_lucide/jaspr_lucide.dart' as lucide;

/// Icon size presets for consistent sizing across the app
enum IconSize {
  /// 12px
  xs,
  /// 16px
  sm,
  /// 20px
  md,
  /// 24px
  lg,
  /// 32px
  xl,
  /// 48px
  xl2,
}

/// Extension to convert IconSize to pixel values
extension IconSizeExtension on IconSize {
  /// Get the pixel value for this size
  double get pixels => switch (this) {
        IconSize.xs => 12,
        IconSize.sm => 16,
        IconSize.md => 20,
        IconSize.lg => 24,
        IconSize.xl => 32,
        IconSize.xl2 => 48,
      };

  /// Get as Unit for jaspr_lucide icons
  Unit get unit => Unit.pixels(pixels);
}

/// Wrapper class providing a clean API for Lucide icons.
///
/// Instead of using the confusing raw icon constructors like `Home()`,
/// use this class for clarity:
///
/// ```dart
/// ArcaneIcon.home()
/// ArcaneIcon.search(size: IconSize.lg)
/// ArcaneIcon.settings()
/// ```
///
/// All methods accept an optional [size] parameter with sensible defaults.
class ArcaneIcon {
  ArcaneIcon._();

  // ============================================================================
  // Navigation & UI
  // ============================================================================

  /// Home/house icon
  static Component home({IconSize size = IconSize.md}) =>
      lucide.House(width: size.unit, height: size.unit);

  /// Search/magnifying glass icon
  static Component search({IconSize size = IconSize.md}) =>
      lucide.Search(width: size.unit, height: size.unit);

  /// Settings/gear icon
  static Component settings({IconSize size = IconSize.md}) =>
      lucide.Settings(width: size.unit, height: size.unit);

  /// Menu/hamburger icon
  static Component menu({IconSize size = IconSize.md}) =>
      lucide.Menu(width: size.unit, height: size.unit);

  /// Close/X icon
  static Component close({IconSize size = IconSize.md}) =>
      lucide.X(width: size.unit, height: size.unit);

  /// X icon (alias for close)
  static Component x({IconSize size = IconSize.md}) =>
      lucide.X(width: size.unit, height: size.unit);

  /// Plus icon
  static Component plus({IconSize size = IconSize.md}) =>
      lucide.Plus(width: size.unit, height: size.unit);

  /// Minus icon
  static Component minus({IconSize size = IconSize.md}) =>
      lucide.Minus(width: size.unit, height: size.unit);

  /// Check/checkmark icon
  static Component check({IconSize size = IconSize.md}) =>
      lucide.Check(width: size.unit, height: size.unit);

  /// Chevron down icon
  static Component chevronDown({IconSize size = IconSize.md}) =>
      lucide.ChevronDown(width: size.unit, height: size.unit);

  /// Chevron up icon
  static Component chevronUp({IconSize size = IconSize.md}) =>
      lucide.ChevronUp(width: size.unit, height: size.unit);

  /// Chevron left icon
  static Component chevronLeft({IconSize size = IconSize.md}) =>
      lucide.ChevronLeft(width: size.unit, height: size.unit);

  /// Chevron right icon
  static Component chevronRight({IconSize size = IconSize.md}) =>
      lucide.ChevronRight(width: size.unit, height: size.unit);

  /// Arrow left icon
  static Component arrowLeft({IconSize size = IconSize.md}) =>
      lucide.ArrowLeft(width: size.unit, height: size.unit);

  /// Arrow right icon
  static Component arrowRight({IconSize size = IconSize.md}) =>
      lucide.ArrowRight(width: size.unit, height: size.unit);

  /// Arrow up icon
  static Component arrowUp({IconSize size = IconSize.md}) =>
      lucide.ArrowUp(width: size.unit, height: size.unit);

  /// Arrow down icon
  static Component arrowDown({IconSize size = IconSize.md}) =>
      lucide.ArrowDown(width: size.unit, height: size.unit);

  /// External link icon
  static Component externalLink({IconSize size = IconSize.md}) =>
      lucide.ExternalLink(width: size.unit, height: size.unit);

  /// Link icon
  static Component link({IconSize size = IconSize.md}) =>
      lucide.Link(width: size.unit, height: size.unit);

  // ============================================================================
  // User & People
  // ============================================================================

  /// User/person icon
  static Component user({IconSize size = IconSize.md}) =>
      lucide.User(width: size.unit, height: size.unit);

  /// Users/people icon
  static Component users({IconSize size = IconSize.md}) =>
      lucide.Users(width: size.unit, height: size.unit);

  /// User plus icon
  static Component userPlus({IconSize size = IconSize.md}) =>
      lucide.UserPlus(width: size.unit, height: size.unit);

  /// User minus icon
  static Component userMinus({IconSize size = IconSize.md}) =>
      lucide.UserMinus(width: size.unit, height: size.unit);

  // ============================================================================
  // Files & Folders
  // ============================================================================

  /// File icon
  static Component file({IconSize size = IconSize.md}) =>
      lucide.File(width: size.unit, height: size.unit);

  /// File text icon
  static Component fileText({IconSize size = IconSize.md}) =>
      lucide.FileText(width: size.unit, height: size.unit);

  /// Folder icon
  static Component folder({IconSize size = IconSize.md}) =>
      lucide.Folder(width: size.unit, height: size.unit);

  /// Folder open icon
  static Component folderOpen({IconSize size = IconSize.md}) =>
      lucide.FolderOpen(width: size.unit, height: size.unit);

  /// Download icon
  static Component download({IconSize size = IconSize.md}) =>
      lucide.Download(width: size.unit, height: size.unit);

  /// Upload icon
  static Component upload({IconSize size = IconSize.md}) =>
      lucide.Upload(width: size.unit, height: size.unit);

  // ============================================================================
  // Actions & Editing
  // ============================================================================

  /// Edit/pencil icon
  static Component edit({IconSize size = IconSize.md}) =>
      lucide.Pencil(width: size.unit, height: size.unit);

  /// Pencil icon (alias for edit)
  static Component pencil({IconSize size = IconSize.md}) =>
      lucide.Pencil(width: size.unit, height: size.unit);

  /// Copy icon
  static Component copy({IconSize size = IconSize.md}) =>
      lucide.Copy(width: size.unit, height: size.unit);

  /// Trash/delete icon
  static Component trash({IconSize size = IconSize.md}) =>
      lucide.Trash(width: size.unit, height: size.unit);

  /// Delete icon (alias for trash)
  static Component delete({IconSize size = IconSize.md}) =>
      lucide.Trash2(width: size.unit, height: size.unit);

  /// Save icon
  static Component save({IconSize size = IconSize.md}) =>
      lucide.Save(width: size.unit, height: size.unit);

  /// Refresh icon
  static Component refresh({IconSize size = IconSize.md}) =>
      lucide.RefreshCw(width: size.unit, height: size.unit);

  /// Undo icon
  static Component undo({IconSize size = IconSize.md}) =>
      lucide.Undo(width: size.unit, height: size.unit);

  /// Redo icon
  static Component redo({IconSize size = IconSize.md}) =>
      lucide.Redo(width: size.unit, height: size.unit);

  // ============================================================================
  // Communication & Alerts
  // ============================================================================

  /// Bell/notification icon
  static Component bell({IconSize size = IconSize.md}) =>
      lucide.Bell(width: size.unit, height: size.unit);

  /// Mail/email icon
  static Component mail({IconSize size = IconSize.md}) =>
      lucide.Mail(width: size.unit, height: size.unit);

  /// Message/chat icon
  static Component message({IconSize size = IconSize.md}) =>
      lucide.MessageSquare(width: size.unit, height: size.unit);

  /// Send icon
  static Component send({IconSize size = IconSize.md}) =>
      lucide.Send(width: size.unit, height: size.unit);

  /// Info icon
  static Component info({IconSize size = IconSize.md}) =>
      lucide.Info(width: size.unit, height: size.unit);

  /// Warning/alert triangle icon
  static Component warning({IconSize size = IconSize.md}) =>
      lucide.TriangleAlert(width: size.unit, height: size.unit);

  /// Alert circle icon
  static Component alertCircle({IconSize size = IconSize.md}) =>
      lucide.CircleAlert(width: size.unit, height: size.unit);

  /// Help/question icon
  static Component help({IconSize size = IconSize.md}) =>
      lucide.CircleQuestionMark(width: size.unit, height: size.unit);

  // ============================================================================
  // Media & Content
  // ============================================================================

  /// Image icon
  static Component image({IconSize size = IconSize.md}) =>
      lucide.Image(width: size.unit, height: size.unit);

  /// Video icon
  static Component video({IconSize size = IconSize.md}) =>
      lucide.Video(width: size.unit, height: size.unit);

  /// Music icon
  static Component music({IconSize size = IconSize.md}) =>
      lucide.Music(width: size.unit, height: size.unit);

  /// Play icon
  static Component play({IconSize size = IconSize.md}) =>
      lucide.Play(width: size.unit, height: size.unit);

  /// Pause icon
  static Component pause({IconSize size = IconSize.md}) =>
      lucide.Pause(width: size.unit, height: size.unit);

  /// Stop icon
  static Component stop({IconSize size = IconSize.md}) =>
      lucide.Square(width: size.unit, height: size.unit);

  // ============================================================================
  // Social & Feedback
  // ============================================================================

  /// Heart icon
  static Component heart({IconSize size = IconSize.md}) =>
      lucide.Heart(width: size.unit, height: size.unit);

  /// Star icon
  static Component star({IconSize size = IconSize.md}) =>
      lucide.Star(width: size.unit, height: size.unit);

  /// Thumbs up icon
  static Component thumbsUp({IconSize size = IconSize.md}) =>
      lucide.ThumbsUp(width: size.unit, height: size.unit);

  /// Thumbs down icon
  static Component thumbsDown({IconSize size = IconSize.md}) =>
      lucide.ThumbsDown(width: size.unit, height: size.unit);

  /// Share icon
  static Component share({IconSize size = IconSize.md}) =>
      lucide.Share(width: size.unit, height: size.unit);

  /// Bookmark icon
  static Component bookmark({IconSize size = IconSize.md}) =>
      lucide.Bookmark(width: size.unit, height: size.unit);

  // ============================================================================
  // Theme & Display
  // ============================================================================

  /// Sun icon (light mode)
  static Component sun({IconSize size = IconSize.md}) =>
      lucide.Sun(width: size.unit, height: size.unit);

  /// Moon icon (dark mode)
  static Component moon({IconSize size = IconSize.md}) =>
      lucide.Moon(width: size.unit, height: size.unit);

  /// Monitor/desktop icon
  static Component monitor({IconSize size = IconSize.md}) =>
      lucide.Monitor(width: size.unit, height: size.unit);

  /// Smartphone icon
  static Component smartphone({IconSize size = IconSize.md}) =>
      lucide.Smartphone(width: size.unit, height: size.unit);

  /// Tablet icon
  static Component tablet({IconSize size = IconSize.md}) =>
      lucide.Tablet(width: size.unit, height: size.unit);

  /// Eye icon (visible)
  static Component eye({IconSize size = IconSize.md}) =>
      lucide.Eye(width: size.unit, height: size.unit);

  /// Eye off icon (hidden)
  static Component eyeOff({IconSize size = IconSize.md}) =>
      lucide.EyeOff(width: size.unit, height: size.unit);

  // ============================================================================
  // Data & Charts
  // ============================================================================

  /// Chart/bar chart icon
  static Component chart({IconSize size = IconSize.md}) =>
      lucide.ChartBar(width: size.unit, height: size.unit);

  /// Pie chart icon
  static Component pieChart({IconSize size = IconSize.md}) =>
      lucide.ChartPie(width: size.unit, height: size.unit);

  /// Line chart icon
  static Component lineChart({IconSize size = IconSize.md}) =>
      lucide.ChartLine(width: size.unit, height: size.unit);

  /// Activity icon
  static Component activity({IconSize size = IconSize.md}) =>
      lucide.Activity(width: size.unit, height: size.unit);

  /// Database icon
  static Component database({IconSize size = IconSize.md}) =>
      lucide.Database(width: size.unit, height: size.unit);

  // ============================================================================
  // Security & Auth
  // ============================================================================

  /// Lock icon
  static Component lock({IconSize size = IconSize.md}) =>
      lucide.Lock(width: size.unit, height: size.unit);

  /// Unlock icon
  static Component unlock({IconSize size = IconSize.md}) =>
      lucide.LockOpen(width: size.unit, height: size.unit);

  /// Key icon
  static Component key({IconSize size = IconSize.md}) =>
      lucide.KeyRound(width: size.unit, height: size.unit);

  /// Shield icon
  static Component shield({IconSize size = IconSize.md}) =>
      lucide.Shield(width: size.unit, height: size.unit);

  /// Shield check icon
  static Component shieldCheck({IconSize size = IconSize.md}) =>
      lucide.ShieldCheck(width: size.unit, height: size.unit);

  // ============================================================================
  // Time & Calendar
  // ============================================================================

  /// Clock icon
  static Component clock({IconSize size = IconSize.md}) =>
      lucide.Clock(width: size.unit, height: size.unit);

  /// Calendar icon
  static Component calendar({IconSize size = IconSize.md}) =>
      lucide.Calendar(width: size.unit, height: size.unit);

  /// Alarm clock icon
  static Component alarm({IconSize size = IconSize.md}) =>
      lucide.AlarmClock(width: size.unit, height: size.unit);

  // ============================================================================
  // Commerce & Money
  // ============================================================================

  /// Shopping cart icon
  static Component cart({IconSize size = IconSize.md}) =>
      lucide.ShoppingCart(width: size.unit, height: size.unit);

  /// Shopping bag icon
  static Component bag({IconSize size = IconSize.md}) =>
      lucide.ShoppingBag(width: size.unit, height: size.unit);

  /// Credit card icon
  static Component creditCard({IconSize size = IconSize.md}) =>
      lucide.CreditCard(width: size.unit, height: size.unit);

  /// Dollar sign icon
  static Component dollar({IconSize size = IconSize.md}) =>
      lucide.DollarSign(width: size.unit, height: size.unit);

  // ============================================================================
  // Development & Code
  // ============================================================================

  /// Code icon
  static Component code({IconSize size = IconSize.md}) =>
      lucide.Code(width: size.unit, height: size.unit);

  /// Terminal icon
  static Component terminal({IconSize size = IconSize.md}) =>
      lucide.Terminal(width: size.unit, height: size.unit);

  /// Git branch icon
  static Component gitBranch({IconSize size = IconSize.md}) =>
      lucide.GitBranch(width: size.unit, height: size.unit);

  /// Git commit icon
  static Component gitCommit({IconSize size = IconSize.md}) =>
      lucide.GitCommitHorizontal(width: size.unit, height: size.unit);

  /// Bug icon
  static Component bug({IconSize size = IconSize.md}) =>
      lucide.Bug(width: size.unit, height: size.unit);

  // ============================================================================
  // Layout & Grid
  // ============================================================================

  /// Grid icon
  static Component grid({IconSize size = IconSize.md}) =>
      lucide.Grid3x3(width: size.unit, height: size.unit);

  /// List icon
  static Component list({IconSize size = IconSize.md}) =>
      lucide.LayoutList(width: size.unit, height: size.unit);

  /// Columns icon
  static Component columns({IconSize size = IconSize.md}) =>
      lucide.Columns3(width: size.unit, height: size.unit);

  /// Rows icon
  static Component rows({IconSize size = IconSize.md}) =>
      lucide.Rows3(width: size.unit, height: size.unit);

  /// Maximize icon
  static Component maximize({IconSize size = IconSize.md}) =>
      lucide.Maximize(width: size.unit, height: size.unit);

  /// Minimize icon
  static Component minimize({IconSize size = IconSize.md}) =>
      lucide.Minimize(width: size.unit, height: size.unit);

  // ============================================================================
  // Misc
  // ============================================================================

  /// More horizontal (three dots) icon
  static Component moreHorizontal({IconSize size = IconSize.md}) =>
      lucide.Ellipsis(width: size.unit, height: size.unit);

  /// More vertical (three dots) icon
  static Component moreVertical({IconSize size = IconSize.md}) =>
      lucide.EllipsisVertical(width: size.unit, height: size.unit);

  /// Filter icon
  static Component filter({IconSize size = IconSize.md}) =>
      lucide.Funnel(width: size.unit, height: size.unit);

  /// Sort icon
  static Component sort({IconSize size = IconSize.md}) =>
      lucide.ArrowUpDown(width: size.unit, height: size.unit);

  /// Loader icon
  static Component loader({IconSize size = IconSize.md}) =>
      lucide.Loader(width: size.unit, height: size.unit);

  /// Zap/lightning icon
  static Component zap({IconSize size = IconSize.md}) =>
      lucide.Zap(width: size.unit, height: size.unit);

  /// Globe icon
  static Component globe({IconSize size = IconSize.md}) =>
      lucide.Globe(width: size.unit, height: size.unit);

  /// Map pin icon
  static Component mapPin({IconSize size = IconSize.md}) =>
      lucide.MapPin(width: size.unit, height: size.unit);

  /// Compass icon
  static Component compass({IconSize size = IconSize.md}) =>
      lucide.Compass(width: size.unit, height: size.unit);

  /// Printer icon
  static Component printer({IconSize size = IconSize.md}) =>
      lucide.Printer(width: size.unit, height: size.unit);

  /// Paperclip/attachment icon
  static Component attachment({IconSize size = IconSize.md}) =>
      lucide.Paperclip(width: size.unit, height: size.unit);

  /// Tag icon
  static Component tag({IconSize size = IconSize.md}) =>
      lucide.Tag(width: size.unit, height: size.unit);

  /// Hash icon
  static Component hash({IconSize size = IconSize.md}) =>
      lucide.Hash(width: size.unit, height: size.unit);

  /// At sign icon
  static Component at({IconSize size = IconSize.md}) =>
      lucide.AtSign(width: size.unit, height: size.unit);

  /// Power icon
  static Component power({IconSize size = IconSize.md}) =>
      lucide.Power(width: size.unit, height: size.unit);

  /// Log out icon
  static Component logOut({IconSize size = IconSize.md}) =>
      lucide.LogOut(width: size.unit, height: size.unit);

  /// Log in icon
  static Component logIn({IconSize size = IconSize.md}) =>
      lucide.LogIn(width: size.unit, height: size.unit);

  /// Grip vertical (drag handle) icon
  static Component gripVertical({IconSize size = IconSize.md}) =>
      lucide.GripVertical(width: size.unit, height: size.unit);

  /// Grip horizontal (drag handle) icon
  static Component gripHorizontal({IconSize size = IconSize.md}) =>
      lucide.GripHorizontal(width: size.unit, height: size.unit);

  // ============================================================================
  // Icons with Dart naming conflicts (accessible here since raw names are hidden)
  // ============================================================================

  /// Factory/building icon
  static Component factory({IconSize size = IconSize.md}) =>
      lucide.Factory(width: size.unit, height: size.unit);

  /// Target/crosshair icon
  static Component target({IconSize size = IconSize.md}) =>
      lucide.Target(width: size.unit, height: size.unit);

  /// Key icon (the actual key shape, not KeyRound)
  static Component keyIcon({IconSize size = IconSize.md}) =>
      lucide.Key(width: size.unit, height: size.unit);

  /// List icon
  static Component listIcon({IconSize size = IconSize.md}) =>
      lucide.List(width: size.unit, height: size.unit);

  /// Timer icon
  static Component timer({IconSize size = IconSize.md}) =>
      lucide.Timer(width: size.unit, height: size.unit);

  /// View/eye icon (alternate)
  static Component view({IconSize size = IconSize.md}) =>
      lucide.View(width: size.unit, height: size.unit);

  /// Map icon
  static Component map({IconSize size = IconSize.md}) =>
      lucide.Map(width: size.unit, height: size.unit);

  /// Import icon
  static Component importIcon({IconSize size = IconSize.md}) =>
      lucide.Import(width: size.unit, height: size.unit);

  /// Contrast icon
  static Component contrast({IconSize size = IconSize.md}) =>
      lucide.Contrast(width: size.unit, height: size.unit);

  /// Radius icon
  static Component radius({IconSize size = IconSize.md}) =>
      lucide.Radius(width: size.unit, height: size.unit);

  /// Spell check icon
  static Component spellCheck({IconSize size = IconSize.md}) =>
      lucide.SpellCheck(width: size.unit, height: size.unit);

  /// Text wrap icon
  static Component textWrap({IconSize size = IconSize.md}) =>
      lucide.TextWrap(width: size.unit, height: size.unit);
}
