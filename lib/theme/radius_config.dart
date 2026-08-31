/// Border radius configuration for a theme.
class RadiusConfig {
  final String xs;
  final String sm;
  final String md;

  const RadiusConfig() : xs = '4px', sm = '6px', md = '8px';

  /// Tight radii for dense, technical interfaces.
  const RadiusConfig.dense() : xs = '2px', sm = '4px', md = '4px';

  /// Smaller radii for compact/dense UIs.
  const RadiusConfig.compact() : xs = '2px', sm = '4px', md = '6px';

  /// Sharp corners.
  const RadiusConfig.sharp() : xs = '0', sm = '0', md = '0';
}
