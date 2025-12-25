/// OTP input interactivity scripts.
class OtpInputScripts {
  OtpInputScripts._();

  static const String code = r'''
  function bindOtpInputs() {
    document.querySelectorAll('.arcane-otp-input').forEach(function(container) {
      if (container.dataset.arcaneInteractive === 'true') return;
      container.dataset.arcaneInteractive = 'true';

      var inputs = container.querySelectorAll('.arcane-otp-digit');
      if (!inputs.length) return;

      inputs.forEach(function(input, index) {
        input.addEventListener('input', function(e) {
          var value = input.value;

          if (value.length > 1) {
            var digits = value.replace(/[^0-9]/g, '').split('');
            inputs.forEach(function(inp, i) {
              if (digits[i]) inp.value = digits[i];
            });
            var lastIndex = Math.min(digits.length, inputs.length) - 1;
            if (lastIndex >= 0) inputs[lastIndex].focus();
            return;
          }

          if (value && index < inputs.length - 1) {
            inputs[index + 1].focus();
          }
        });

        input.addEventListener('keydown', function(e) {
          if (e.key === 'Backspace' && !input.value && index > 0) {
            inputs[index - 1].focus();
          } else if (e.key === 'ArrowLeft' && index > 0) {
            inputs[index - 1].focus();
          } else if (e.key === 'ArrowRight' && index < inputs.length - 1) {
            inputs[index + 1].focus();
          }
        });

        input.addEventListener('focus', function() {
          input.select();
        });
      });
    });
  }
''';
}
