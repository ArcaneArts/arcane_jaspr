/// ItemPicker dialog interactivity scripts.
class ItemPickerScripts {
  ItemPickerScripts._();

  static const String code = r'''
  function bindItemPickers() {
    document.querySelectorAll('.arcane-item-picker-content').forEach(function(picker) {
      if (picker.dataset.arcaneInteractive === 'true') return;
      picker.dataset.arcaneInteractive = 'true';

      var searchInput = picker.querySelector('.arcane-item-picker-search input');
      var items = picker.querySelectorAll('.arcane-item-picker-item');
      var isMultiSelect = picker.dataset.multiSelect === 'true';
      var selectedItems = new Set();

      // Search filtering
      if (searchInput) {
        searchInput.addEventListener('input', function() {
          var query = searchInput.value.toLowerCase();
          items.forEach(function(item) {
            var text = item.textContent.toLowerCase();
            item.style.display = text.includes(query) ? 'flex' : 'none';
          });
        });
      }

      // Item selection
      items.forEach(function(item) {
        item.addEventListener('click', function() {
          var itemId = item.dataset.itemId || item.textContent;

          if (isMultiSelect) {
            if (selectedItems.has(itemId)) {
              selectedItems.delete(itemId);
              item.classList.remove('selected');
              item.style.background = 'transparent';
              item.style.borderColor = 'var(--arcane-border)';
            } else {
              selectedItems.add(itemId);
              item.classList.add('selected');
              item.style.background = 'var(--arcane-accent-container)';
              item.style.borderColor = 'var(--arcane-accent)';
            }

            // Update selection count
            var counter = picker.querySelector('.arcane-item-picker-count');
            if (counter) {
              counter.textContent = selectedItems.size + ' item(s) selected';
              counter.style.display = selectedItems.size > 0 ? 'block' : 'none';
            }
          } else {
            // Single select - deselect others
            items.forEach(function(i) {
              i.classList.remove('selected');
              i.style.background = 'transparent';
              i.style.borderColor = 'var(--arcane-border)';
            });
            item.classList.add('selected');
            item.style.background = 'var(--arcane-accent-container)';
            item.style.borderColor = 'var(--arcane-accent)';
          }

          picker.dispatchEvent(new CustomEvent('itemselect', {
            detail: {
              item: itemId,
              selected: isMultiSelect ? Array.from(selectedItems) : itemId
            }
          }));
        });
      });
    });
  }
''';
}
