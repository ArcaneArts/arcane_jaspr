/// Sheet/Drawer overlay interactivity scripts.
class SheetScripts {
  SheetScripts._();

  static const String code = r'''
  function bindSheets() {
    // Close buttons on sheets
    document.querySelectorAll('.arcane-sheet .arcane-sheet-close').forEach(function(closeBtn) {
      if (closeBtn.dataset.arcaneInteractive === 'true') return;
      closeBtn.dataset.arcaneInteractive = 'true';

      closeBtn.addEventListener('click', function() {
        var sheet = closeBtn.closest('.arcane-sheet-overlay');
        if (sheet) {
          sheet.remove();
        }
      });
    });

    // Backdrop dismiss for sheets
    document.querySelectorAll('.arcane-sheet-overlay').forEach(function(overlay) {
      if (overlay.dataset.arcaneInteractive === 'true') return;
      overlay.dataset.arcaneInteractive = 'true';

      overlay.addEventListener('click', function(e) {
        if (e.target === overlay && overlay.dataset.barrierDismissible !== 'false') {
          overlay.remove();
        }
      });
    });

    // Action sheet items
    document.querySelectorAll('.arcane-action-sheet-item').forEach(function(item) {
      if (item.dataset.arcaneInteractive === 'true') return;
      if (item.dataset.disabled === 'true') return;
      item.dataset.arcaneInteractive = 'true';

      item.addEventListener('click', function() {
        var actionSheet = item.closest('.arcane-sheet-overlay');
        if (actionSheet) {
          actionSheet.remove();
        }
      });
    });
  }

  function openSheet(position, content, options) {
    options = options || {};
    var overlay = document.createElement('div');
    overlay.className = 'arcane-sheet-overlay';
    overlay.dataset.barrierDismissible = options.barrierDismissible !== false ? 'true' : 'false';
    overlay.style.cssText = 'position:fixed;inset:0;z-index:1050;display:flex;align-items:' +
      (position === 'bottom' ? 'flex-end' : position === 'top' ? 'flex-start' : 'stretch') +
      ';justify-content:' + (position === 'end' ? 'flex-end' : position === 'start' ? 'flex-start' : 'center') +
      ';background:var(--arcane-scrim);';

    var sheet = document.createElement('div');
    sheet.className = 'arcane-sheet arcane-sheet-' + position;

    var baseStyles = 'background:var(--arcane-surface);display:flex;flex-direction:column;overflow:hidden;';
    if (position === 'bottom' || position === 'top') {
      sheet.style.cssText = baseStyles + 'width:100%;max-height:' + (options.height || 400) + 'px;border-radius:var(--arcane-radius-lg) var(--arcane-radius-lg) 0 0;';
    } else {
      sheet.style.cssText = baseStyles + 'height:100%;width:' + (options.width || 400) + 'px;max-width:100%;';
    }

    sheet.innerHTML = content;
    overlay.appendChild(sheet);
    document.body.appendChild(overlay);

    bindSheets();
    return overlay;
  }

  window.ArcaneSheet = { open: openSheet };
''';
}
