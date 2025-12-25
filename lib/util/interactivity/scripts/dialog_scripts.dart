/// Dialog and overlay interactivity scripts for static sites.
class DialogScripts {
  DialogScripts._();

  static const String code = r'''
  // ===== TOASTS (ArcaneToaster) =====
  function bindToasts() {
    // Bind ArcaneToaster containers
    document.querySelectorAll('.arcane-toaster').forEach(function(toaster) {
      if (toaster.dataset.arcaneInteractive === 'true') return;
      toaster.dataset.arcaneInteractive = 'true';

      // Bind all toasts within this toaster
      bindToasterToasts(toaster);

      // Watch for new toasts being added
      var observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
          mutation.addedNodes.forEach(function(node) {
            if (node.classList && node.classList.contains('arcane-toast')) {
              bindSingleToast(node, toaster);
            }
          });
        });
      });
      observer.observe(toaster, { childList: true });
    });

    // Fallback: bind any standalone toasts
    document.querySelectorAll('.arcane-toast').forEach(function(toast) {
      if (toast.dataset.arcaneInteractive === 'true') return;
      bindSingleToast(toast, null);
    });

    // Legacy: demo button support
    document.querySelectorAll('button').forEach(function(btn) {
      var text = btn.textContent.toLowerCase();
      if ((!text.includes('toast') && !text.includes('show')) || btn.dataset.arcaneToastInteractive) return;
      btn.dataset.arcaneToastInteractive = 'true';
      btn.addEventListener('click', function() {
        createDemoToast(text.includes('success') ? 'success' : text.includes('error') ? 'error' : text.includes('warning') ? 'warning' : 'info');
      });
    });
  }

  function bindToasterToasts(toaster) {
    toaster.querySelectorAll('.arcane-toast').forEach(function(toast) {
      bindSingleToast(toast, toaster);
    });
  }

  function bindSingleToast(toast, toaster) {
    if (toast.dataset.arcaneInteractive === 'true') return;
    toast.dataset.arcaneInteractive = 'true';

    // Get duration from data attribute or default to 4000ms
    var duration = parseInt(toast.dataset.duration) || 4000;
    var dismissible = toast.dataset.dismissible !== 'false';

    // Animate in
    toast.style.transition = 'all 0.3s cubic-bezier(0.4, 0, 0.2, 1)';
    requestAnimationFrame(function() {
      toast.style.opacity = '1';
      toast.style.transform = 'translateY(0) scale(1)';
    });

    // Progress bar animation
    var progressBar = toast.querySelector('.arcane-toast-progress');
    if (progressBar && duration > 0) {
      progressBar.style.transition = 'width ' + duration + 'ms linear';
      requestAnimationFrame(function() {
        progressBar.style.width = '0%';
      });
    }

    // Auto-dismiss
    var dismissTimer = null;
    if (duration > 0) {
      dismissTimer = setTimeout(function() {
        dismissToast(toast);
      }, duration);
    }

    // Close button
    var closeBtn = toast.querySelector('.arcane-toast-close');
    if (closeBtn) {
      closeBtn.addEventListener('click', function(e) {
        e.stopPropagation();
        if (dismissTimer) clearTimeout(dismissTimer);
        dismissToast(toast);
      });
    }

    // Click to dismiss (if enabled)
    if (dismissible && !toast.dataset.clickDismiss) {
      toast.dataset.clickDismiss = 'true';
      toast.style.cursor = 'pointer';
      toast.addEventListener('click', function(e) {
        if (e.target.closest('button')) return;
        if (dismissTimer) clearTimeout(dismissTimer);
        dismissToast(toast);
      });
    }

    // Action button handlers
    toast.querySelectorAll('.arcane-toast-action').forEach(function(actionBtn) {
      if (actionBtn.dataset.arcaneActionBound) return;
      actionBtn.dataset.arcaneActionBound = 'true';
      actionBtn.addEventListener('click', function(e) {
        e.stopPropagation();
        if (dismissTimer) clearTimeout(dismissTimer);
        dismissToast(toast);
      });
    });

    // Pause on hover
    toast.addEventListener('mouseenter', function() {
      if (dismissTimer) {
        clearTimeout(dismissTimer);
        dismissTimer = null;
      }
      if (progressBar) {
        progressBar.style.transition = 'none';
      }
    });

    toast.addEventListener('mouseleave', function() {
      if (duration > 0 && !toast.dataset.dismissed) {
        dismissTimer = setTimeout(function() {
          dismissToast(toast);
        }, 2000);
        if (progressBar) {
          progressBar.style.transition = 'width 2000ms linear';
          progressBar.style.width = '0%';
        }
      }
    });
  }

  function dismissToast(toast) {
    if (toast.dataset.dismissed === 'true') return;
    toast.dataset.dismissed = 'true';

    toast.style.opacity = '0';
    toast.style.transform = 'translateY(-10px) scale(0.95)';

    setTimeout(function() {
      toast.remove();
    }, 300);
  }

  function createDemoToast(type) {
    var icons = { success: '✓', error: '✗', warning: '⚠', info: 'ℹ' };
    var colors = { success: 'var(--arcane-success)', error: 'var(--arcane-error)', warning: 'var(--arcane-warning)', info: 'var(--arcane-info)' };
    var messages = { success: 'Action completed successfully!', error: 'Something went wrong.', warning: 'Please review before continuing.', info: 'Here is some information.' };

    var toaster = document.querySelector('.arcane-toaster') || createToasterContainer();

    var toast = document.createElement('div');
    toast.className = 'arcane-toast arcane-toast-' + type;
    toast.dataset.duration = '4000';
    toast.style.cssText = 'display: flex; align-items: flex-start; gap: 12px; padding: 16px; background: var(--arcane-surface); border: 1px solid var(--arcane-border); border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); min-width: 300px; max-width: 400px; opacity: 0; transform: translateY(10px) scale(0.95); position: relative; overflow: hidden;';
    toast.innerHTML = '<span style="color: ' + colors[type] + '; font-size: 18px; line-height: 1;">' + icons[type] + '</span><div style="flex: 1;"><div style="font-weight: 500; color: var(--arcane-on-surface);">' + type.charAt(0).toUpperCase() + type.slice(1) + '</div><div style="font-size: 0.875rem; color: var(--arcane-muted);">' + messages[type] + '</div></div><button class="arcane-toast-close" style="background: none; border: none; color: var(--arcane-muted); cursor: pointer; padding: 0; font-size: 18px; line-height: 1;">×</button><div class="arcane-toast-progress" style="position: absolute; bottom: 0; left: 0; height: 2px; width: 100%; background: ' + colors[type] + ';"></div>';

    toaster.appendChild(toast);
    bindSingleToast(toast, toaster);
  }

  function createToasterContainer() {
    var toaster = document.createElement('div');
    toaster.className = 'arcane-toaster';
    toaster.style.cssText = 'position: fixed; bottom: 16px; right: 16px; display: flex; flex-direction: column-reverse; gap: 8px; z-index: 9999; pointer-events: none;';
    toaster.querySelectorAll('.arcane-toast').forEach(function(t) { t.style.pointerEvents = 'auto'; });
    document.body.appendChild(toaster);
    return toaster;
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
