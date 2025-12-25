/// Tree view interactivity scripts.
class TreeViewScripts {
  TreeViewScripts._();

  static const String code = r'''
  function bindTreeViews() {
    document.querySelectorAll('[role="tree"]').forEach(function(tree) {
      if (tree.dataset.arcaneInteractive) return;
      tree.dataset.arcaneInteractive = 'true';

      tree.querySelectorAll('[role="treeitem"]').forEach(function(item) {
        item.addEventListener('click', function(e) {
          e.stopPropagation();

          var hasChildren = item.getAttribute('aria-expanded') !== null;
          var isExpanded = item.getAttribute('aria-expanded') === 'true';
          var isSelected = item.getAttribute('aria-selected') === 'true';

          if (hasChildren) {
            item.setAttribute('aria-expanded', (!isExpanded).toString());
            var group = item.nextElementSibling;
            if (group && group.getAttribute('role') === 'group') {
              group.style.display = isExpanded ? 'none' : 'block';
            }
            var icon = item.querySelector('[style*="transform"]');
            if (icon) {
              icon.style.transform = isExpanded ? 'rotate(0deg)' : 'rotate(90deg)';
            }
          }

          tree.querySelectorAll('[role="treeitem"]').forEach(function(other) {
            other.setAttribute('aria-selected', 'false');
            other.style.background = 'transparent';
            var label = other.querySelector('span:last-child');
            if (label) {
              label.style.color = 'var(--arcane-on-surface)';
              label.style.fontWeight = 'normal';
            }
          });

          item.setAttribute('aria-selected', 'true');
          item.style.background = 'var(--arcane-surface-variant)';
          var label = item.querySelector('span:last-child');
          if (label) {
            label.style.color = 'var(--arcane-accent)';
            label.style.fontWeight = '500';
          }
        });
      });
    });
  }
''';
}
