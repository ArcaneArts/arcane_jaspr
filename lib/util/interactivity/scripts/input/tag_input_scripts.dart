/// Tag input interactivity scripts.
class TagInputScripts {
  TagInputScripts._();

  static const String code = r'''
  function bindTagInputs() {
    document.querySelectorAll('.arcane-tag-input').forEach(function(container) {
      if (container.dataset.arcaneInteractive === 'true') return;
      container.dataset.arcaneInteractive = 'true';

      var input = container.querySelector('.arcane-tag-input-field');
      var tagsContainer = container.querySelector('.arcane-tag-input-tags');
      if (!input || !tagsContainer) return;

      container.querySelectorAll('.arcane-tag-remove').forEach(function(btn) {
        btn.addEventListener('click', function(e) {
          e.preventDefault();
          var tag = btn.closest('.arcane-tag');
          if (tag) tag.remove();
        });
      });

      input.addEventListener('keydown', function(e) {
        if (e.key === 'Enter' || e.key === ',') {
          e.preventDefault();
          var value = input.value.trim();
          if (!value) return;

          var tag = document.createElement('span');
          tag.className = 'arcane-tag';
          tag.style.cssText = 'display: inline-flex; align-items: center; gap: 4px; padding: 4px 8px; background: var(--arcane-accent); color: var(--arcane-accent-foreground); border-radius: 9999px; font-size: 0.75rem;';
          tag.innerHTML = value + '<button type="button" class="arcane-tag-remove" style="display: flex; width: 14px; height: 14px; padding: 0; border: none; background: rgba(255,255,255,0.2); border-radius: 9999px; color: inherit; cursor: pointer; align-items: center; justify-content: center;">×</button>';

          tag.querySelector('.arcane-tag-remove').addEventListener('click', function() { tag.remove(); });
          tagsContainer.appendChild(tag);
          input.value = '';
        }
      });
    });
  }
''';
}
