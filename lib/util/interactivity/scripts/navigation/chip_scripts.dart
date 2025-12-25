/// Chip interactivity scripts.
class ChipScripts {
  ChipScripts._();

  static const String code = r'''
  function bindChips() {
    document.querySelectorAll('.arcane-chip').forEach(function(chip) {
      if (chip.dataset.arcaneInteractive) return;
      chip.dataset.arcaneInteractive = 'true';

      if (chip.classList.contains('clickable')) {
        chip.addEventListener('click', function() {
          chip.style.opacity = chip.style.opacity === '0.7' ? '1' : '0.7';
        });
      }

      var removeBtn = chip.querySelector('.arcane-chip-remove');
      if (removeBtn) {
        removeBtn.addEventListener('click', function(e) {
          e.stopPropagation();
          chip.style.transform = 'scale(0.9)';
          chip.style.opacity = '0';
          setTimeout(function() { chip.remove(); }, 150);
        });
      }
    });
  }
''';
}
