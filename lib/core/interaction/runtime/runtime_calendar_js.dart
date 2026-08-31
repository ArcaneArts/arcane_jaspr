library;

const String runtimeCalendarJs = r'''
function _calRoot(target){
  if (!target) return null;
  if (target.matches && target.matches('[data-arcane-calendar]')) return target;
  return target.querySelector ? target.querySelector('[data-arcane-calendar]') : null;
}
function _calMonthLabel(d){
  const months = ['January','February','March','April','May','June','July','August','September','October','November','December'];
  return months[d.getMonth()] + ' ' + d.getFullYear();
}
function _calParseDate(s){
  if (!s) return null;
  const parts = String(s).split('-');
  if (parts.length !== 3) return null;
  const y = parseInt(parts[0], 10);
  const m = parseInt(parts[1], 10) - 1;
  const d = parseInt(parts[2], 10);
  if (isNaN(y) || isNaN(m) || isNaN(d)) return null;
  return new Date(y, m, d);
}
function _calFmtDate(d){
  if (!d) return '';
  const y = d.getFullYear();
  const m = String(d.getMonth() + 1).padStart(2, '0');
  const dd = String(d.getDate()).padStart(2, '0');
  return y + '-' + m + '-' + dd;
}
function _calIsSameDay(a, b){
  if (!a || !b) return false;
  return a.getFullYear() === b.getFullYear() && a.getMonth() === b.getMonth() && a.getDate() === b.getDate();
}
function _calInRange(d, start, end){
  if (!d || !start || !end) return false;
  const t = d.getTime();
  return t >= start.getTime() && t <= end.getTime();
}
function _calDisabled(d, root){
  const min = _calParseDate(root.getAttribute('data-arcane-min'));
  const max = _calParseDate(root.getAttribute('data-arcane-max'));
  if (min && d.getTime() < min.getTime()) return true;
  if (max && d.getTime() > max.getTime()) return true;
  return false;
}
function _calWeekNumber(date){
  const d = new Date(Date.UTC(date.getFullYear(), date.getMonth(), date.getDate()));
  const dayNum = d.getUTCDay() || 7;
  d.setUTCDate(d.getUTCDate() + 4 - dayNum);
  const yearStart = new Date(Date.UTC(d.getUTCFullYear(), 0, 1));
  return Math.ceil((((d - yearStart) / 86400000) + 1) / 7);
}
function _calHumanize(d){
  if (!d) return '';
  const months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
  return months[d.getMonth()] + ' ' + d.getDate() + ', ' + d.getFullYear();
}
function _calDisplay(root){
  const mode = root.getAttribute('data-arcane-mode') || 'single';
  if (mode === 'range'){
    const rs = root.getAttribute('data-arcane-range-start');
    const re = root.getAttribute('data-arcane-range-end');
    if (!rs || !re) return '';
    const sd = _calParseDate(rs); const ed = _calParseDate(re);
    return _calHumanize(sd) + ' - ' + _calHumanize(ed);
  }
  const sel = root.getAttribute('data-arcane-selected');
  if (!sel) return '';
  return _calHumanize(_calParseDate(sel));
}
function renderCalendar(root){
  if (!root) return;
  const year = parseInt(root.getAttribute('data-arcane-year') || String(new Date().getFullYear()), 10);
  const month = parseInt(root.getAttribute('data-arcane-month') || String(new Date().getMonth()), 10);
  const firstDayOfWeek = parseInt(root.getAttribute('data-arcane-first-day') || '0', 10);
  const showWeekNumbers = root.getAttribute('data-arcane-show-week-numbers') === 'true';
  const showToday = root.getAttribute('data-arcane-show-today') !== 'false';
  const mode = root.getAttribute('data-arcane-mode') || 'single';
  const selected = _calParseDate(root.getAttribute('data-arcane-selected'));
  const rangeStart = _calParseDate(root.getAttribute('data-arcane-range-start'));
  const rangeEnd = _calParseDate(root.getAttribute('data-arcane-range-end'));
  const pendingStart = _calParseDate(root.getAttribute('data-arcane-pending-start'));
  const displayMonth = new Date(year, month, 1);
  const today = new Date();
  today.setHours(0, 0, 0, 0);
  const monthStart = new Date(year, month, 1);
  const monthEnd = new Date(year, month + 1, 0);
  const startOffset = (monthStart.getDay() - firstDayOfWeek + 7) % 7;
  const gridStart = new Date(year, month, 1 - startOffset);
  const id = root.getAttribute('data-arcane-id') || '';
  let html = '';
  // Keep generated markup out of the global script's literal DOM text. Jaspr
  // hydrates inline scripts in the app tree, and raw tag-shaped strings can be
  // exposed as hidden template controls by DOM/a11y tooling. JavaScript
  // resolves \x3C to "<" only when this function actually renders a calendar.
  html += '\x3Cdiv class="arcane-calendar-header" data-arcane-calendar-header>';
  html += '\x3Cbutton type="button" class="arcane-calendar-nav arcane-calendar-prev" data-arcane-action="calendar.prev:' + id + '" aria-label="Previous month">&#8249;\x3C/button>';
  html += '\x3Cdiv class="arcane-calendar-label" data-arcane-calendar-label>' + _calMonthLabel(displayMonth) + '\x3C/div>';
  html += '\x3Cbutton type="button" class="arcane-calendar-nav arcane-calendar-next" data-arcane-action="calendar.next:' + id + '" aria-label="Next month">&#8250;\x3C/button>';
  html += '\x3C/div>';
  if (showToday){
    html += '\x3Cdiv class="arcane-calendar-today-row">\x3Cbutton type="button" class="arcane-calendar-today" data-arcane-action="calendar.today:' + id + '">Today\x3C/button>\x3C/div>';
  }
  const weekdays = ['Sun','Mon','Tue','Wed','Thu','Fri','Sat'];
  html += '\x3Cdiv class="arcane-calendar-weekdays">';
  if (showWeekNumbers) html += '\x3Cdiv class="arcane-calendar-weekday arcane-calendar-week-num">#\x3C/div>';
  for (let i = 0; i < 7; i++){
    html += '\x3Cdiv class="arcane-calendar-weekday">' + weekdays[(firstDayOfWeek + i) % 7] + '\x3C/div>';
  }
  html += '\x3C/div>';
  html += '\x3Cdiv class="arcane-calendar-grid">';
  let iter = new Date(gridStart.getFullYear(), gridStart.getMonth(), gridStart.getDate());
  for (let w = 0; w < 6; w++){
    if (showWeekNumbers){
      const weekNo = _calWeekNumber(iter);
      html += '\x3Cdiv class="arcane-calendar-weeknum">' + weekNo + '\x3C/div>';
    }
    for (let d = 0; d < 7; d++){
      const inMonth = iter.getMonth() === month;
      const disabled = _calDisabled(iter, root);
      const isToday = _calIsSameDay(iter, today);
      const isSelected = mode === 'single' && _calIsSameDay(iter, selected);
      const inRange = mode === 'range' && rangeStart && rangeEnd && _calInRange(iter, rangeStart, rangeEnd);
      const isRangeStart = mode === 'range' && _calIsSameDay(iter, rangeStart);
      const isRangeEnd = mode === 'range' && _calIsSameDay(iter, rangeEnd);
      const isPendingStart = mode === 'range' && _calIsSameDay(iter, pendingStart);
      const classes = ['arcane-calendar-day'];
      if (!inMonth) classes.push('arcane-calendar-day-other-month');
      if (disabled) classes.push('arcane-calendar-day-disabled');
      if (isToday) classes.push('arcane-calendar-day-today');
      if (isSelected) classes.push('arcane-calendar-day-selected');
      if (inRange) classes.push('arcane-calendar-day-in-range');
      if (isRangeStart) classes.push('arcane-calendar-day-range-start');
      if (isRangeEnd) classes.push('arcane-calendar-day-range-end');
      if (isPendingStart) classes.push('arcane-calendar-day-pending');
      const iso = _calFmtDate(iter);
      const label = iter.getDate();
      if (disabled){
        html += '\x3Cbutton type="button" class="' + classes.join(' ') + '" disabled aria-disabled="true">' + label + '\x3C/button>';
      } else {
        html += '\x3Cbutton type="button" class="' + classes.join(' ') + '" data-arcane-action="calendar.select:' + id + '" data-arcane-value="' + iso + '" aria-pressed="' + (isSelected || isRangeStart || isRangeEnd ? 'true' : 'false') + '">' + label + '\x3C/button>';
      }
      iter = new Date(iter.getFullYear(), iter.getMonth(), iter.getDate() + 1);
    }
    if (iter.getMonth() !== month && iter > monthEnd) break;
  }
  html += '\x3C/div>';
  root.innerHTML = html;
}
function _calEmitChange(root, value){
  let evt;
  try { evt = new CustomEvent('arcane:change', { detail: { value: value }, bubbles: true }); }
  catch (e){ evt = document.createEvent('CustomEvent'); evt.initCustomEvent('arcane:change', true, false, { value: value }); }
  root.dispatchEvent(evt);
  const id = root.getAttribute('data-arcane-id');
  if (!id) return;
  const trigger = document.querySelector('[data-arcane-calendar-trigger="' + cssEscape(id) + '"]');
  if (trigger){
    const label = trigger.querySelector('[data-arcane-calendar-display]');
    if (label) label.textContent = _calDisplay(root) || (trigger.getAttribute('data-arcane-placeholder') || '');
  }
}
function _calResolveRoot(target){
  if (!target) return null;
  if (typeof target === 'string'){
    return _calRoot(document.querySelector('[data-arcane-id="' + cssEscape(target) + '"]'));
  }
  return _calRoot(target);
}
function _calClosePicker(id){
  const picker = document.querySelector('[data-arcane-surface][data-arcane-calendar-anchor="' + cssEscape(id) + '"]');
  if (picker) closeSurface(surfaceType(picker), surfaceId(picker));
}
function calendarPrev(target){
  const root = _calResolveRoot(target);
  if (!root) return;
  const year = parseInt(root.getAttribute('data-arcane-year'), 10);
  const month = parseInt(root.getAttribute('data-arcane-month'), 10);
  const d = new Date(year, month - 1, 1);
  root.setAttribute('data-arcane-year', String(d.getFullYear()));
  root.setAttribute('data-arcane-month', String(d.getMonth()));
  renderCalendar(root);
}
function calendarNext(target){
  const root = _calResolveRoot(target);
  if (!root) return;
  const year = parseInt(root.getAttribute('data-arcane-year'), 10);
  const month = parseInt(root.getAttribute('data-arcane-month'), 10);
  const d = new Date(year, month + 1, 1);
  root.setAttribute('data-arcane-year', String(d.getFullYear()));
  root.setAttribute('data-arcane-month', String(d.getMonth()));
  renderCalendar(root);
}
function calendarToday(target){
  const root = _calResolveRoot(target);
  if (!root) return;
  const now = new Date();
  root.setAttribute('data-arcane-year', String(now.getFullYear()));
  root.setAttribute('data-arcane-month', String(now.getMonth()));
  renderCalendar(root);
}
function calendarSelect(target, value){
  const root = _calResolveRoot(target);
  if (!root) return;
  const picked = _calParseDate(value);
  if (!picked || _calDisabled(picked, root)) return;
  const mode = root.getAttribute('data-arcane-mode') || 'single';
  const id = root.getAttribute('data-arcane-id');
  if (mode === 'range'){
    const pendingStart = root.getAttribute('data-arcane-pending-start');
    if (!pendingStart){
      root.setAttribute('data-arcane-pending-start', value);
      root.removeAttribute('data-arcane-range-start');
      root.removeAttribute('data-arcane-range-end');
      renderCalendar(root);
    } else {
      let startD = _calParseDate(pendingStart);
      let endD = picked;
      if (startD.getTime() > endD.getTime()){
        const tmp = startD; startD = endD; endD = tmp;
      }
      root.setAttribute('data-arcane-range-start', _calFmtDate(startD));
      root.setAttribute('data-arcane-range-end', _calFmtDate(endD));
      root.removeAttribute('data-arcane-pending-start');
      renderCalendar(root);
      _calEmitChange(root, _calFmtDate(startD) + '/' + _calFmtDate(endD));
      _calClosePicker(id);
    }
  } else {
    root.setAttribute('data-arcane-selected', value);
    renderCalendar(root);
    _calEmitChange(root, value);
    _calClosePicker(id);
  }
}
function bindCalendars(){
  const nodes = document.querySelectorAll('[data-arcane-calendar]:not([data-arcane-calendar-bound])');
  for (let i = 0; i < nodes.length; i++){
    nodes[i].setAttribute('data-arcane-calendar-bound', 'true');
    if (!nodes[i].innerHTML.trim()) renderCalendar(nodes[i]);
  }
}
''';
