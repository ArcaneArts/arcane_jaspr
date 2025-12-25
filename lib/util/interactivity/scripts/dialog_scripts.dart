/// Dialog and overlay interactivity scripts for static sites.
class DialogScripts {
  DialogScripts._();

  static const String code = r'''
  // ===== TOASTS =====
  function bindToasts() {
    document.querySelectorAll('button').forEach(function(btn) {
      var text = btn.textContent.toLowerCase();
      if ((!text.includes('toast') && !text.includes('show')) || btn.dataset.arcaneToastInteractive) return;
      btn.dataset.arcaneToastInteractive = 'true';

      btn.addEventListener('click', function() {
        var toast = document.createElement('div');
        toast.style.cssText = 'position: fixed; bottom: 20px; right: 20px; padding: 12px 20px; background: var(--arcane-surface); border: 1px solid var(--arcane-border); border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); z-index: 9999; transform: translateX(100%); opacity: 0; transition: all 0.3s ease;';
        toast.innerHTML = '<div style="display: flex; align-items: center; gap: 8px;"><span style="color: var(--arcane-success);">✓</span><span style="color: var(--arcane-on-surface);">Toast notification!</span></div>';

        document.body.appendChild(toast);
        requestAnimationFrame(function() {
          toast.style.transform = 'translateX(0)';
          toast.style.opacity = '1';
        });

        setTimeout(function() {
          toast.style.transform = 'translateX(100%)';
          toast.style.opacity = '0';
          setTimeout(function() { toast.remove(); }, 300);
        }, 3000);
      });
    });
  }

  // ===== POPOVERS/HOVERCARDS =====
  function bindPopovers() {
    document.querySelectorAll('[style*="position: relative"]').forEach(function(container) {
      var trigger = container.firstElementChild;
      var popup = container.querySelector('[style*="position: absolute"][style*="z-index"]');
      if (!trigger || !popup || container.dataset.arcanePopoverInteractive) return;
      container.dataset.arcanePopoverInteractive = 'true';

      popup.style.display = 'none';

      trigger.addEventListener('mouseenter', function() { popup.style.display = 'block'; });
      container.addEventListener('mouseleave', function() { popup.style.display = 'none'; });
      trigger.addEventListener('click', function(e) {
        e.stopPropagation();
        popup.style.display = popup.style.display === 'none' ? 'block' : 'none';
      });
    });
  }

  // ===== TOOLTIPS =====
  function bindTooltips() {
    document.querySelectorAll('[title]:not([data-arcane-tooltip])').forEach(function(el) {
      if (!el.title || el.dataset.arcaneTooltip) return;
      el.dataset.arcaneTooltip = 'true';

      var tooltipText = el.title;
      el.removeAttribute('title');

      var tooltip = null;

      el.addEventListener('mouseenter', function(e) {
        tooltip = document.createElement('div');
        tooltip.className = 'arcane-tooltip';
        tooltip.style.cssText = 'position: fixed; padding: 6px 10px; background: var(--arcane-surface); color: var(--arcane-on-surface); border: 1px solid var(--arcane-border); border-radius: 4px; font-size: 0.75rem; z-index: 9999; pointer-events: none; white-space: nowrap; box-shadow: 0 2px 8px rgba(0,0,0,0.15);';
        tooltip.textContent = tooltipText;
        document.body.appendChild(tooltip);

        var rect = el.getBoundingClientRect();
        tooltip.style.left = rect.left + (rect.width / 2) - (tooltip.offsetWidth / 2) + 'px';
        tooltip.style.top = (rect.top - tooltip.offsetHeight - 8) + 'px';
      });

      el.addEventListener('mouseleave', function() {
        if (tooltip) {
          tooltip.remove();
          tooltip = null;
        }
      });
    });
  }

  // ===== DIALOGS =====
  function bindDialogs() {
    // Dialog trigger buttons
    document.querySelectorAll('button').forEach(function(btn) {
      var text = btn.textContent.toLowerCase();
      if ((!text.includes('dialog') && !text.includes('modal') && !text.includes('open')) || btn.dataset.arcaneDialogInteractive) return;
      btn.dataset.arcaneDialogInteractive = 'true';

      btn.addEventListener('click', function() {
        // Look for a nearby dialog element
        var dialog = document.querySelector('[role="dialog"]:not([open]), .arcane-dialog:not(.open)');
        if (dialog) {
          dialog.setAttribute('open', 'true');
          dialog.classList.add('open');
          dialog.style.display = 'flex';

          // Create backdrop if needed
          var backdrop = document.querySelector('.arcane-dialog-backdrop');
          if (!backdrop) {
            backdrop = document.createElement('div');
            backdrop.className = 'arcane-dialog-backdrop';
            backdrop.style.cssText = 'position: fixed; inset: 0; background: rgba(0,0,0,0.5); z-index: 9998;';
            document.body.appendChild(backdrop);
          }
          backdrop.style.display = 'block';
        }
      });
    });

    // Dialog close buttons
    document.querySelectorAll('[role="dialog"] button, .arcane-dialog button').forEach(function(btn) {
      var text = btn.textContent.toLowerCase();
      if ((!text.includes('close') && !text.includes('cancel') && btn.textContent.trim() !== '×') || btn.dataset.arcaneDialogCloseInteractive) return;
      btn.dataset.arcaneDialogCloseInteractive = 'true';

      btn.addEventListener('click', function() {
        var dialog = btn.closest('[role="dialog"], .arcane-dialog');
        if (dialog) {
          dialog.removeAttribute('open');
          dialog.classList.remove('open');
          dialog.style.display = 'none';

          var backdrop = document.querySelector('.arcane-dialog-backdrop');
          if (backdrop) backdrop.style.display = 'none';
        }
      });
    });

    // Close on backdrop click
    document.addEventListener('click', function(e) {
      if (e.target.classList?.contains('arcane-dialog-backdrop')) {
        document.querySelectorAll('[role="dialog"][open], .arcane-dialog.open').forEach(function(dialog) {
          dialog.removeAttribute('open');
          dialog.classList.remove('open');
          dialog.style.display = 'none';
        });
        e.target.style.display = 'none';
      }
    });

    // Close on Escape key
    document.addEventListener('keydown', function(e) {
      if (e.key === 'Escape') {
        document.querySelectorAll('[role="dialog"][open], .arcane-dialog.open').forEach(function(dialog) {
          dialog.removeAttribute('open');
          dialog.classList.remove('open');
          dialog.style.display = 'none';
        });
        var backdrop = document.querySelector('.arcane-dialog-backdrop');
        if (backdrop) backdrop.style.display = 'none';
      }
    });
  }

  // ===== DRAWER =====
  function bindDrawers() {
    // Drawer trigger buttons
    document.querySelectorAll('[data-drawer-trigger], button').forEach(function(btn) {
      var text = btn.textContent.toLowerCase();
      if (!btn.dataset.drawerTrigger && !text.includes('menu') && !text.includes('drawer') && btn.textContent.trim() !== '☰') return;
      if (btn.dataset.arcaneDrawerInteractive) return;
      btn.dataset.arcaneDrawerInteractive = 'true';

      btn.addEventListener('click', function() {
        var drawerId = btn.dataset.drawerTrigger;
        var drawer = drawerId ? document.getElementById(drawerId) : document.querySelector('.arcane-drawer, [style*="position: fixed"][style*="left: 0"]');

        if (drawer) {
          var isOpen = drawer.style.transform === 'translateX(0px)' || drawer.style.transform === 'translateX(0)';
          drawer.style.transform = isOpen ? 'translateX(-100%)' : 'translateX(0)';
        }
      });
    });

    // Close drawer when clicking outside
    document.addEventListener('click', function(e) {
      var drawer = document.querySelector('.arcane-drawer[style*="translateX(0)"], [style*="position: fixed"][style*="left: 0"][style*="translateX(0)"]');
      if (drawer && !drawer.contains(e.target) && !e.target.dataset.arcaneDrawerInteractive) {
        drawer.style.transform = 'translateX(-100%)';
      }
    });
  }

  // ===== MOBILE MENU =====
  function bindMobileMenus() {
    document.querySelectorAll('.arcane-mobile-menu-trigger, [aria-label="Toggle menu"]').forEach(function(trigger) {
      if (trigger.dataset.arcaneMobileMenuInteractive) return;
      trigger.dataset.arcaneMobileMenuInteractive = 'true';

      var menu = document.querySelector('.arcane-mobile-menu, [style*="position: fixed"][style*="inset: 0"]');

      trigger.addEventListener('click', function() {
        if (menu) {
          var isOpen = menu.style.display !== 'none';
          menu.style.display = isOpen ? 'none' : 'flex';

          // Toggle hamburger animation
          var lines = trigger.querySelectorAll('span, div');
          lines.forEach(function(line, i) {
            if (isOpen) {
              line.style.transform = '';
            } else {
              if (i === 0) line.style.transform = 'rotate(45deg) translateY(6px)';
              if (i === 1) line.style.opacity = '0';
              if (i === 2) line.style.transform = 'rotate(-45deg) translateY(-6px)';
            }
          });
        }
      });
    });
  }
''';
}
