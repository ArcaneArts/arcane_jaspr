/// Toast notification interactivity scripts.
class ToastScripts {
  ToastScripts._();

  static const String code = r'''
  function bindToasts() {
    document.querySelectorAll('.arcane-toast').forEach(function(toast) {
      if (toast.dataset.arcaneInteractive === 'true') return;
      bindSingleToast(toast);
    });

    document.querySelectorAll('.arcane-toaster').forEach(function(toaster) {
      if (toaster.dataset.arcaneInteractive === 'true') return;
      toaster.dataset.arcaneInteractive = 'true';

      var observer = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
          mutation.addedNodes.forEach(function(node) {
            if (node.nodeType === 1 && node.classList && node.classList.contains('arcane-toast')) {
              bindSingleToast(node);
            }
          });
        });
      });
      observer.observe(toaster, { childList: true, subtree: true });
    });

    document.querySelectorAll('button').forEach(function(btn) {
      var text = (btn.textContent || '').toLowerCase();
      if (btn.dataset.arcaneToastBound) return;

      var isToastButton = text.includes('success') || text.includes('error') ||
                          text.includes('warning') || text.includes('info') ||
                          text.includes('loading') || text.includes('toast') ||
                          text.includes('acknowledge') || text.includes('confirm action') ||
                          text.includes('with undo');
      if (!isToastButton) return;

      btn.dataset.arcaneToastBound = 'true';
      btn.addEventListener('click', function(e) {
        if (text.includes('acknowledge')) {
          createToast('warning', 'Your session will expire in 5 minutes.', {
            title: 'Session Warning',
            duration: 0,
            action: { label: 'OK', onPressed: function() {} }
          });
          return;
        }
        if (text.includes('confirm action')) {
          createToast('error', 'This action cannot be undone.', {
            title: 'Are you sure?',
            duration: 0,
            action: { label: 'I Understand', onPressed: function() {}, destructive: true }
          });
          return;
        }
        if (text.includes('with undo')) {
          createToast('info', 'Item moved to trash.', {
            title: 'Deleted',
            action: { label: 'Undo', onPressed: function() {} }
          });
          return;
        }

        var variant = 'info';
        if (text.includes('success')) variant = 'success';
        else if (text.includes('error')) variant = 'error';
        else if (text.includes('warning')) variant = 'warning';
        else if (text.includes('loading')) variant = 'loading';

        createToast(variant, getToastMessage(variant));
      });
    });
  }

  function bindSingleToast(toast) {
    if (toast.dataset.arcaneInteractive === 'true') return;
    toast.dataset.arcaneInteractive = 'true';

    var duration = toast.dataset.duration !== undefined && toast.dataset.duration !== '' ? parseInt(toast.dataset.duration) : 4000;
    var dismissible = toast.dataset.dismissible !== 'false';
    var variant = toast.dataset.variant || 'info';
    var dismissTimer = null;
    var isPaused = false;

    toast.style.opacity = '0';
    toast.style.transform = 'translateY(16px) scale(0.95)';
    requestAnimationFrame(function() {
      toast.style.transition = 'all 300ms cubic-bezier(0, 0, 0.2, 1)';
      toast.style.opacity = '1';
      toast.style.transform = 'translateY(0) scale(1)';
    });

    var progressBar = toast.querySelector('.arcane-toast-progress');
    if (progressBar && duration > 0) {
      progressBar.style.width = '100%';
      progressBar.style.transition = 'width ' + duration + 'ms linear';
      requestAnimationFrame(function() {
        requestAnimationFrame(function() {
          progressBar.style.width = '0%';
        });
      });
    }

    function startDismissTimer() {
      if (duration > 0 && !isPaused) {
        dismissTimer = setTimeout(function() {
          dismissToast(toast);
        }, duration);
      }
    }
    startDismissTimer();

    toast.addEventListener('mouseenter', function() {
      isPaused = true;
      if (dismissTimer) {
        clearTimeout(dismissTimer);
        dismissTimer = null;
      }
      if (progressBar) {
        var computed = window.getComputedStyle(progressBar);
        progressBar.style.width = computed.width;
        progressBar.style.transition = 'none';
      }
    });

    toast.addEventListener('mouseleave', function() {
      isPaused = false;
      if (duration > 0) {
        dismissTimer = setTimeout(function() {
          dismissToast(toast);
        }, 2000);
        if (progressBar) {
          progressBar.style.transition = 'width 2000ms linear';
          progressBar.style.width = '0%';
        }
      }
    });

    var closeBtn = toast.querySelector('.arcane-toast-close');
    if (closeBtn) {
      closeBtn.addEventListener('click', function(e) {
        e.stopPropagation();
        if (dismissTimer) clearTimeout(dismissTimer);
        dismissToast(toast);
      });
    }

    var actionBtn = toast.querySelector('.arcane-toast-action');
    if (actionBtn && !actionBtn.dataset.arcaneActionBound) {
      actionBtn.dataset.arcaneActionBound = 'true';
      actionBtn.addEventListener('click', function(e) {
        e.stopPropagation();
        if (dismissTimer) clearTimeout(dismissTimer);
        dismissToast(toast);
      });
    }
  }

  function dismissToast(toast) {
    if (toast.dataset.dismissed === 'true') return;
    toast.dataset.dismissed = 'true';

    toast.style.transition = 'all 200ms cubic-bezier(0.4, 0, 1, 1)';
    toast.style.opacity = '0';
    toast.style.transform = 'translateY(-16px) scale(0.95)';

    setTimeout(function() {
      if (toast.parentNode) {
        toast.parentNode.removeChild(toast);
      }
    }, 200);
  }

  function getToastMessage(variant) {
    var messages = {
      success: 'Action completed successfully!',
      error: 'Something went wrong. Please try again.',
      warning: 'Please review before continuing.',
      info: 'Here is some helpful information.',
      loading: 'Processing your request...'
    };
    return messages[variant] || messages.info;
  }

  function getToastTitle(variant) {
    return {
      success: 'Success',
      error: 'Error',
      warning: 'Warning',
      info: 'Information',
      loading: 'Loading'
    }[variant] || 'Notification';
  }

  function createToast(variant, message, options) {
    options = options || {};
    var title = options.title || getToastTitle(variant);
    var description = options.description || '';
    var position = options.position || 'bottomRight';
    var duration = options.duration !== undefined ? options.duration : (variant === 'loading' ? 0 : 4000);
    var action = options.action || null;

    var toaster = document.querySelector('.arcane-toaster[data-position="' + position + '"]') ||
                  document.querySelector('.arcane-toaster') ||
                  createToasterContainer(position);

    var colors = {
      success: { bg: 'rgba(16, 185, 129, 0.05)', border: 'rgba(16, 185, 129, 0.3)', icon: '#10b981', progress: '#10b981' },
      error: { bg: 'rgba(239, 68, 68, 0.05)', border: 'rgba(239, 68, 68, 0.3)', icon: '#ef4444', progress: '#ef4444' },
      warning: { bg: 'rgba(245, 158, 11, 0.05)', border: 'rgba(245, 158, 11, 0.3)', icon: '#f59e0b', progress: '#f59e0b' },
      info: { bg: 'rgba(59, 130, 246, 0.05)', border: 'rgba(59, 130, 246, 0.3)', icon: '#3b82f6', progress: '#3b82f6' },
      loading: { bg: 'var(--arcane-surface, #1a1a2e)', border: 'var(--arcane-border, #2d2d44)', icon: 'var(--arcane-accent, #10b981)', progress: 'var(--arcane-accent, #10b981)' }
    };
    var c = colors[variant] || colors.info;

    var icons = {
      success: '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>',
      error: '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="15" y1="9" x2="9" y2="15"></line><line x1="9" y1="9" x2="15" y2="15"></line></svg>',
      warning: '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path><line x1="12" y1="9" x2="12" y2="13"></line><line x1="12" y1="17" x2="12.01" y2="17"></line></svg>',
      info: '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>',
      loading: '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="animation: arcane-toast-spin 1s linear infinite"><path d="M21 12a9 9 0 1 1-6.219-8.56"></path></svg>'
    };

    var toast = document.createElement('div');
    toast.className = 'arcane-toast arcane-toast-' + variant;
    toast.setAttribute('role', 'alert');
    toast.dataset.variant = variant;
    toast.dataset.duration = duration;
    var requiresAction = duration === 0 && action && action.label;
    var isDismissible = variant !== 'loading' && !requiresAction;
    toast.dataset.dismissible = isDismissible ? 'true' : 'false';

    toast.style.cssText = 'display: flex; align-items: flex-start; gap: 12px; padding: 16px; background: ' + c.bg + '; border: 1px solid ' + c.border + '; border-radius: 12px; box-shadow: 0 10px 15px -3px rgba(0,0,0,0.1); min-width: 320px; max-width: 420px; pointer-events: auto; position: relative; overflow: hidden; opacity: 0; transform: translateY(16px) scale(0.95);';

    var closeButton = isDismissible ? '<button class="arcane-toast-close" type="button" style="display: flex; align-items: center; justify-content: center; width: 24px; height: 24px; padding: 0; border: none; background: transparent; color: var(--arcane-muted, #6b7280); cursor: pointer; border-radius: 6px;"><svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg></button>' : '';
    var progressBar = duration > 0 ? '<div class="arcane-toast-progress" style="position: absolute; bottom: 0; left: 0; height: 2px; width: 100%; background: ' + c.progress + ';"></div>' : '';
    var actionBtnHtml = '';
    if (action && action.label) {
      var actionColor = action.destructive ? 'var(--arcane-error, #ef4444)' : 'var(--arcane-accent, #10b981)';
      actionBtnHtml = '<div style="margin-top: 8px;"><button class="arcane-toast-action" type="button" style="padding: 4px 8px; font-size: 12px; font-weight: 500; color: ' + actionColor + '; background: transparent; border: 1px solid var(--arcane-border); border-radius: 6px; cursor: pointer;">' + action.label + '</button></div>';
    }

    toast.innerHTML = '<div style="color: ' + c.icon + ';">' + (icons[variant] || icons.info) + '</div><div style="flex: 1;"><span style="font-weight: 600; font-size: 14px; color: var(--arcane-on-surface);">' + title + '</span><span style="font-size: 14px; color: var(--arcane-muted); display: block;">' + message + '</span>' + actionBtnHtml + '</div>' + closeButton + progressBar;

    toaster.appendChild(toast);

    if (action && action.onPressed) {
      var actionBtn = toast.querySelector('.arcane-toast-action');
      if (actionBtn) {
        actionBtn.addEventListener('click', function(e) {
          e.stopPropagation();
          action.onPressed();
          dismissToast(toast);
        });
      }
    }

    bindSingleToast(toast);
    return toast;
  }

  function createToasterContainer(position) {
    position = position || 'bottomRight';
    var positionStyles = {
      topLeft: 'top: 20px; left: 20px; align-items: flex-start; flex-direction: column;',
      topCenter: 'top: 20px; left: 50%; transform: translateX(-50%); align-items: center; flex-direction: column;',
      topRight: 'top: 20px; right: 20px; align-items: flex-end; flex-direction: column;',
      bottomLeft: 'bottom: 20px; left: 20px; align-items: flex-start; flex-direction: column-reverse;',
      bottomCenter: 'bottom: 20px; left: 50%; transform: translateX(-50%); align-items: center; flex-direction: column-reverse;',
      bottomRight: 'bottom: 20px; right: 20px; align-items: flex-end; flex-direction: column-reverse;'
    };

    var toaster = document.createElement('div');
    toaster.className = 'arcane-toaster';
    toaster.dataset.position = position;
    toaster.style.cssText = 'position: fixed; z-index: 9999; display: flex; gap: 12px; pointer-events: none; ' + (positionStyles[position] || positionStyles.bottomRight);
    document.body.appendChild(toaster);
    return toaster;
  }

  if (!document.getElementById('arcane-toast-keyframes')) {
    var style = document.createElement('style');
    style.id = 'arcane-toast-keyframes';
    style.textContent = '@keyframes arcane-toast-spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }';
    document.head.appendChild(style);
  }
''';
}
