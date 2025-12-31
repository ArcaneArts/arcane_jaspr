/// EmailDialog interactivity scripts.
class EmailDialogScripts {
  EmailDialogScripts._();

  static const String code = r'''
  function bindEmailDialogs() {
    document.querySelectorAll('.arcane-email-dialog').forEach(function(dialog) {
      if (dialog.dataset.arcaneInteractive === 'true') return;
      dialog.dataset.arcaneInteractive = 'true';

      var input = dialog.querySelector('.arcane-email-dialog-input input');
      var errorEl = dialog.querySelector('.arcane-email-dialog-error');
      var submitBtn = dialog.querySelector('.arcane-email-dialog-submit');
      var blockedDomains = (dialog.dataset.blockedDomains || '').split(',').filter(Boolean);
      var requireWork = dialog.dataset.requireWork === 'true';

      if (input) {
        input.addEventListener('input', function() {
          validateEmail();
        });

        input.addEventListener('blur', function() {
          validateEmail();
        });
      }

      if (submitBtn) {
        submitBtn.addEventListener('click', function() {
          if (validateEmail()) {
            dialog.dispatchEvent(new CustomEvent('emailsubmit', {
              detail: { email: input.value }
            }));
          }
        });
      }

      function validateEmail() {
        var email = input.value.trim();
        var error = null;

        if (!email) {
          error = null; // No error for empty
        } else if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)) {
          error = 'Please enter a valid email address';
        } else {
          var domain = email.split('@')[1].toLowerCase();

          // Check blocked domains
          for (var i = 0; i < blockedDomains.length; i++) {
            if (domain === blockedDomains[i].toLowerCase()) {
              error = 'This email domain is not allowed';
              break;
            }
          }

          // Check work email requirement
          if (!error && requireWork) {
            var personalDomains = ['gmail.com', 'yahoo.com', 'hotmail.com', 'outlook.com', 'aol.com', 'icloud.com', 'mail.com'];
            for (var j = 0; j < personalDomains.length; j++) {
              if (domain === personalDomains[j]) {
                error = 'Please use a work email address';
                break;
              }
            }
          }
        }

        if (errorEl) {
          errorEl.textContent = error || '';
          errorEl.style.display = error ? 'block' : 'none';
        }

        if (submitBtn) {
          submitBtn.disabled = !!error || !email;
        }

        input.style.borderColor = error ? 'var(--arcane-destructive)' : 'var(--arcane-border)';

        return !error && email;
      }
    });
  }
''';
}
