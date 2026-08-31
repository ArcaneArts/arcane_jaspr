/// Semantic color values that map to theme CSS custom properties.
///
/// Use these colors for type-safe color references that automatically
/// adapt to the current theme.
enum ArcaneColor {
  // Primary colors
  primary,
  primaryForeground,
  secondary,
  secondaryForeground,
  accent,
  accentForeground,

  // Semantic colors
  success,
  successForeground,
  warning,
  warningForeground,
  error,
  errorForeground,
  info,
  infoForeground,
  destructive,
  destructiveForeground,

  // Surface colors
  background,
  foreground,
  card,
  cardForeground,
  muted,
  mutedForeground,
  border,

  // Special colors
  ring,
  input,
  popover,
  popoverForeground,

  // Neon colors
  neonPink,
  neonCyan,
  neonPurple,
  neonGreen,
  neonOrange,
  neonBlue,
  neonRed,
  neonYellow,
  neonLime,
  neonMagenta,
  neonTeal,
  neonIndigo,
  neonAmber,
  neonRose,
  neonSky,
  neonViolet,
  neonEmerald,
  neonFuchsia,
  neonCoral,
  neonMint,

  // Game brand colors
  gameMinecraft,
  gameRust,
  gameArk,
  gameValheim,
  gameCs2,
  gameTerraria,
  gameHytale,
  gamePalworld,
  gameSatisfactory,
  gameEnshrouded,

  // Platform brand colors
  brandDiscord,
  brandTwitch,
  brandYoutube,
  brandGithub,
  brandSteam,
  brandPatreon,
  brandTwitter,
  brandReddit,
  brandSpotify,
  brandSlack,

  // Utility colors
  white,
  black,
  transparent;

  /// Returns the CSS value for this color.
  String get css => switch (this) {
    ArcaneColor.primary => 'var(--primary)',
    ArcaneColor.primaryForeground => 'var(--primary-foreground)',
    ArcaneColor.secondary => 'var(--secondary)',
    ArcaneColor.secondaryForeground => 'var(--secondary-foreground)',
    ArcaneColor.accent => 'var(--accent)',
    ArcaneColor.accentForeground => 'var(--accent-foreground)',
    ArcaneColor.success => 'var(--success)',
    ArcaneColor.successForeground => 'var(--success-foreground)',
    ArcaneColor.warning => 'var(--warning)',
    ArcaneColor.warningForeground => 'var(--warning-foreground)',
    ArcaneColor.error => 'var(--destructive)',
    ArcaneColor.errorForeground => 'var(--destructive-foreground)',
    ArcaneColor.info => 'var(--info)',
    ArcaneColor.infoForeground => 'var(--info-foreground)',
    ArcaneColor.destructive => 'var(--destructive)',
    ArcaneColor.destructiveForeground => 'var(--destructive-foreground)',
    ArcaneColor.background => 'var(--background)',
    ArcaneColor.foreground => 'var(--foreground)',
    ArcaneColor.card => 'var(--card)',
    ArcaneColor.cardForeground => 'var(--card-foreground)',
    ArcaneColor.muted => 'var(--muted)',
    ArcaneColor.mutedForeground => 'var(--muted-foreground)',
    ArcaneColor.border => 'var(--border)',
    ArcaneColor.ring => 'var(--ring)',
    ArcaneColor.input => 'var(--input)',
    ArcaneColor.popover => 'var(--popover)',
    ArcaneColor.popoverForeground => 'var(--popover-foreground)',
    // Neon colors
    ArcaneColor.neonPink => '#EC4899',
    ArcaneColor.neonCyan => '#06B6D4',
    ArcaneColor.neonPurple => '#8B5CF6',
    ArcaneColor.neonGreen => '#10B981',
    ArcaneColor.neonOrange => '#F97316',
    ArcaneColor.neonBlue => '#3B82F6',
    ArcaneColor.neonRed => '#EF4444',
    ArcaneColor.neonYellow => '#FACC15',
    ArcaneColor.neonLime => '#84CC16',
    ArcaneColor.neonMagenta => '#D946EF',
    ArcaneColor.neonTeal => '#14B8A6',
    ArcaneColor.neonIndigo => '#6366F1',
    ArcaneColor.neonAmber => '#F59E0B',
    ArcaneColor.neonRose => '#F43F5E',
    ArcaneColor.neonSky => '#0EA5E9',
    ArcaneColor.neonViolet => '#A855F7',
    ArcaneColor.neonEmerald => '#34D399',
    ArcaneColor.neonFuchsia => '#E879F9',
    ArcaneColor.neonCoral => '#FB7185',
    ArcaneColor.neonMint => '#6EE7B7',
    // Game brand colors
    ArcaneColor.gameMinecraft => '#62B247',
    ArcaneColor.gameRust => '#CE422B',
    ArcaneColor.gameArk => '#6EC8E4',
    ArcaneColor.gameValheim => '#D4A843',
    ArcaneColor.gameCs2 => '#DE9B35',
    ArcaneColor.gameTerraria => '#29A629',
    ArcaneColor.gameHytale => '#1AB4D6',
    ArcaneColor.gamePalworld => '#56C5D0',
    ArcaneColor.gameSatisfactory => '#E07C39',
    ArcaneColor.gameEnshrouded => '#C4A35A',
    // Platform brand colors
    ArcaneColor.brandDiscord => '#5865F2',
    ArcaneColor.brandTwitch => '#9146FF',
    ArcaneColor.brandYoutube => '#FF0000',
    ArcaneColor.brandGithub => '#24292E',
    ArcaneColor.brandSteam => '#1B2838',
    ArcaneColor.brandPatreon => '#FF424D',
    ArcaneColor.brandTwitter => '#1DA1F2',
    ArcaneColor.brandReddit => '#FF4500',
    ArcaneColor.brandSpotify => '#1DB954',
    ArcaneColor.brandSlack => '#4A154B',
    // Utility colors
    ArcaneColor.white => '#FFFFFF',
    ArcaneColor.black => '#000000',
    ArcaneColor.transparent => 'transparent',
  };

  /// Returns the color with opacity using color-mix.
  String withOpacity(double opacity) {
    final percent = (opacity * 100).round();
    return 'color-mix(in srgb, $css $percent%, transparent)';
  }
}
