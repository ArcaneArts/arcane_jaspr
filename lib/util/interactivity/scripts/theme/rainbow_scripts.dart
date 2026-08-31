/// JavaScript for Neon rainbow theme animation.
///
/// This script animates the --primary and --ring CSS variables
/// through a rainbow color cycle when the .neon-rainbow class is present.
/// IMPORTANT: Only activates if .neon-rainbow class is already on the root element.
class RainbowScripts {
  RainbowScripts._();

  static const String code = '''
  // Rainbow theme animation - smooth hue rotation
  // ONLY activates if .neon-rainbow class is already present
  function bindRainbowTheme() {
    let root = document.querySelector('.neon-rainbow');

    // Only proceed if .neon-rainbow class is explicitly set
    if (!root) {
      return; // Do nothing if rainbow theme is not enabled
    }

    if (root.dataset.rainbowBound) return;
    root.dataset.rainbowBound = 'true';

    const docRoot = document.documentElement;
    const duration = 15000; // 15 seconds for very smooth cycle
    let startTime = null;

    // HSL to RGB values (0-255)
    function hslToRgb(h, s, l) {
      s /= 100; l /= 100;
      const a = s * Math.min(l, 1 - l);
      const f = n => {
        const k = (n + h / 30) % 12;
        return Math.round(255 * (l - a * Math.max(Math.min(k - 3, 9 - k, 1), -1)));
      };
      return [f(0), f(8), f(4)];
    }

    function rgbToHex(r, g, b) {
      return '#' + [r, g, b].map(x => x.toString(16).padStart(2, '0')).join('');
    }

    function animate(timestamp) {
      if (!startTime) startTime = timestamp;
      const progress = ((timestamp - startTime) % duration) / duration;
      const hue = progress * 360; // Smooth float, not integer

      const isDark = root.classList.contains('dark');
      const s = isDark ? 85 : 75;
      const l = isDark ? 55 : 50;

      const [r, g, b] = hslToRgb(hue, s, l);
      const primary = rgbToHex(r, g, b);
      const [rr, rg, rb] = hslToRgb(hue, s, l - 10);
      const ring = rgbToHex(rr, rg, rb);

      // Set all color variables at once
      docRoot.style.setProperty('--primary', primary);
      docRoot.style.setProperty('--ring', ring);
      docRoot.style.setProperty('--primary-rgb', r + ',' + g + ',' + b);
      requestAnimationFrame(animate);
    }

    requestAnimationFrame(animate);
  }
''';
}
