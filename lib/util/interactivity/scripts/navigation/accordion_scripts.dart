/// Expander/Accordion interactivity scripts.
class AccordionScripts {
  AccordionScripts._();

  static const String code = r'''
  function bindExpandersAccordions() {
    document.querySelectorAll('.arcane-expander-header, .arcane-accordion-header, button[aria-expanded]').forEach(function(header) {
      if (header.dataset.arcaneInteractive) return;
      header.dataset.arcaneInteractive = 'true';

      header.addEventListener('click', function() {
        var isExpanded = header.getAttribute('aria-expanded') === 'true';
        header.setAttribute('aria-expanded', (!isExpanded).toString());

        var container = header.closest('.arcane-expander, .arcane-accordion, [style*="border-radius"]');
        var content = header.nextElementSibling;
        if (content) {
          content.style.display = isExpanded ? 'none' : 'block';
        }

        var icon = header.querySelector('[style*="transform"], svg');
        if (icon) {
          icon.style.transform = isExpanded ? 'rotate(0deg)' : 'rotate(180deg)';
        }
      });
    });
  }
''';
}
