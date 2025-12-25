/// Tooltip interactivity scripts.
class TooltipScripts {
  TooltipScripts._();

  static const String code = r'''
  function bindTooltips() {
    document.querySelectorAll('.arcane-tooltip-trigger').forEach(function(trigger) {
      if (trigger.dataset.arcaneTooltipBound) return;
      trigger.dataset.arcaneTooltipBound = 'true';

      var tooltip = trigger.querySelector('.arcane-tooltip');
      if (!tooltip) {
        var content = trigger.dataset.tooltip;
        var position = trigger.dataset.tooltipPosition || 'top';
        tooltip = createTooltipElement(content, position);
        trigger.appendChild(tooltip);
      }

      trigger.addEventListener('mouseenter', function() {
        tooltip.style.opacity = '1';
        tooltip.style.visibility = 'visible';
        var position = trigger.dataset.tooltipPosition || 'top';
        if (position === 'top' || position === 'bottom') {
          tooltip.style.transform = 'translateX(-50%) translateY(0)';
        } else {
          tooltip.style.transform = 'translateY(-50%) translateX(0)';
        }
      });

      trigger.addEventListener('mouseleave', function() {
        tooltip.style.opacity = '0';
        tooltip.style.visibility = 'hidden';
      });
    });

    document.querySelectorAll('[title]:not(.arcane-tooltip-trigger)').forEach(function(el) {
      if (el.dataset.arcaneTooltipBound) return;
      var title = el.getAttribute('title');
      if (!title) return;

      el.dataset.arcaneTooltipBound = 'true';
      el.removeAttribute('title');

      var wrapper = document.createElement('span');
      wrapper.className = 'arcane-tooltip-trigger';
      wrapper.style.cssText = 'position: relative; display: inline-flex;';
      wrapper.dataset.tooltip = title;
      wrapper.dataset.tooltipPosition = 'top';

      el.parentNode.insertBefore(wrapper, el);
      wrapper.appendChild(el);

      var tooltip = createTooltipElement(title, 'top');
      wrapper.appendChild(tooltip);

      wrapper.addEventListener('mouseenter', function() {
        tooltip.style.opacity = '1';
        tooltip.style.visibility = 'visible';
        tooltip.style.transform = 'translateX(-50%) translateY(0)';
      });

      wrapper.addEventListener('mouseleave', function() {
        tooltip.style.opacity = '0';
        tooltip.style.visibility = 'hidden';
      });
    });
  }

  function createTooltipElement(content, position) {
    var tooltip = document.createElement('div');
    tooltip.className = 'arcane-tooltip arcane-tooltip-' + position;
    tooltip.setAttribute('role', 'tooltip');

    var positionStyles = {
      top: 'bottom: 100%; left: 50%; transform: translateX(-50%) translateY(-4px); margin-bottom: 8px;',
      bottom: 'top: 100%; left: 50%; transform: translateX(-50%) translateY(4px); margin-top: 8px;',
      left: 'right: 100%; top: 50%; transform: translateY(-50%) translateX(-4px); margin-right: 8px;',
      right: 'left: 100%; top: 50%; transform: translateY(-50%) translateX(4px); margin-left: 8px;'
    };

    tooltip.style.cssText = 'position: absolute; z-index: 9999; padding: 6px 12px; font-size: 12px; font-weight: 500; line-height: 1.4; color: var(--arcane-on-surface, #f8fafc); background: var(--arcane-surface, #1e1e2e); border-radius: 8px; box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1); white-space: nowrap; pointer-events: none; opacity: 0; visibility: hidden; transition: opacity 150ms ease, visibility 150ms ease, transform 150ms ease; ' + (positionStyles[position] || positionStyles.top);

    tooltip.textContent = content;

    var arrow = document.createElement('div');
    arrow.className = 'arcane-tooltip-arrow';

    var arrowStyles = {
      top: 'bottom: -4px; left: 50%; margin-left: -4px;',
      bottom: 'top: -4px; left: 50%; margin-left: -4px;',
      left: 'right: -4px; top: 50%; margin-top: -4px;',
      right: 'left: -4px; top: 50%; margin-top: -4px;'
    };

    arrow.style.cssText = 'position: absolute; width: 8px; height: 8px; background: var(--arcane-surface, #1e1e2e); transform: rotate(45deg); ' + (arrowStyles[position] || arrowStyles.top);

    tooltip.appendChild(arrow);
    return tooltip;
  }
''';
}
