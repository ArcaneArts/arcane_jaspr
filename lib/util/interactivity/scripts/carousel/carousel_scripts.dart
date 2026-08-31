/// Carousel interactivity scripts for drag-to-scroll with infinite looping.
class CarouselScripts {
  CarouselScripts._();

  static const String code = r'''
  function bindCarousels() {
    document.querySelectorAll('.arcane-carousel').forEach(function(carousel) {
      // The duplicate track is visual continuity only. `aria-hidden` on an
      // ancestor does not remove interactive descendants from keyboard focus,
      // and older browsers do not consistently enforce the inert attribute.
      // Neutralize every focus path both at initial bind and after mutations.
      var clone = carousel.querySelector('[data-arcane-carousel-content="clone"]');
      if (clone) {
        clone.setAttribute('aria-hidden', 'true');
        clone.setAttribute('inert', 'true');
        clone.inert = true;
        clone.style.pointerEvents = 'none';
        clone.querySelectorAll(
          'a[href], area[href], button, input, select, textarea, iframe, object, embed, audio[controls], video[controls], summary, [contenteditable], [tabindex]'
        ).forEach(function(element) {
          element.setAttribute('tabindex', '-1');
          element.setAttribute('aria-hidden', 'true');
          element.removeAttribute('autofocus');
          if (element.hasAttribute('contenteditable')) {
            element.setAttribute('contenteditable', 'false');
          }
          if ('disabled' in element) element.disabled = true;
        });
        clone.querySelectorAll('[id]').forEach(function(element) {
          element.removeAttribute('id');
        });
      }

      if (carousel.dataset.arcaneCarouselBound) return;
      carousel.dataset.arcaneCarouselBound = 'true';

      var track = carousel.querySelector('.arcane-carousel-track');
      if (!track) return;

      var isDragging = false;
      var startX = 0;
      var currentTranslateX = 0;
      var dragStartTranslateX = 0;
      var hasInteracted = false;
      var resumeTimer = null;
      var trackWidth = 0;
      var animationDuration = parseInt(carousel.dataset.animationDuration) || 60;
      var resumeDelay = parseInt(carousel.dataset.resumeDelay) || 5000;

      // Velocity tracking for momentum
      var lastX = 0;
      var lastTime = 0;
      var velocity = 0;
      var momentumAnimationId = null;

      function getTrackWidth() {
        return track.scrollWidth / 2;
      }

      function parseTranslateX(transform) {
        if (transform === 'none' || !transform) return 0;
        var match = transform.match(/matrix\(([^)]+)\)/);
        if (match) {
          var values = match[1].split(',');
          if (values.length >= 5) {
            return parseFloat(values[4].trim()) || 0;
          }
        }
        return 0;
      }

      function applyTransform() {
        track.style.transform = 'translateX(' + currentTranslateX + 'px)';
      }

      function wrapPosition() {
        if (trackWidth <= 0) return;
        while (currentTranslateX > 0) {
          currentTranslateX -= trackWidth;
          dragStartTranslateX -= trackWidth;
        }
        while (currentTranslateX < -trackWidth) {
          currentTranslateX += trackWidth;
          dragStartTranslateX += trackWidth;
        }
      }

      function stopMomentum() {
        if (momentumAnimationId) {
          cancelAnimationFrame(momentumAnimationId);
          momentumAnimationId = null;
        }
      }

      function startDrag(clientX) {
        if (resumeTimer) {
          clearTimeout(resumeTimer);
          resumeTimer = null;
        }

        stopMomentum();

        trackWidth = getTrackWidth();

        if (!hasInteracted) {
          var computedStyle = window.getComputedStyle(track);
          currentTranslateX = parseTranslateX(computedStyle.transform);
          hasInteracted = true;
        }

        isDragging = true;
        startX = clientX;
        lastX = clientX;
        lastTime = performance.now();
        velocity = 0;
        dragStartTranslateX = currentTranslateX;

        track.classList.add('dragging');
        track.classList.remove('resuming');
        applyTransform();
      }

      function updateDrag(clientX) {
        if (!isDragging) return;

        var now = performance.now();
        var deltaTime = now - lastTime;

        if (deltaTime > 0) {
          // Calculate velocity (pixels per millisecond)
          velocity = (clientX - lastX) / deltaTime;
        }

        lastX = clientX;
        lastTime = now;

        var deltaX = clientX - startX;
        currentTranslateX = dragStartTranslateX + deltaX;
        wrapPosition();
        applyTransform();
      }

      function animateMomentum() {
        // Apply friction to slow down
        var friction = 0.95;
        velocity *= friction;

        // Stop when velocity is negligible
        if (Math.abs(velocity) < 0.01) {
          stopMomentum();
          scheduleResume();
          return;
        }

        // Move based on velocity (multiply by ~16ms for smooth 60fps)
        currentTranslateX += velocity * 16;
        wrapPosition();
        applyTransform();

        momentumAnimationId = requestAnimationFrame(animateMomentum);
      }

      function scheduleResume() {
        if (resumeTimer) clearTimeout(resumeTimer);
        resumeTimer = setTimeout(resumeAnimation, resumeDelay);
      }

      function endDrag() {
        if (!isDragging) return;
        isDragging = false;

        // If there's significant velocity, start momentum animation
        if (Math.abs(velocity) > 0.1) {
          momentumAnimationId = requestAnimationFrame(animateMomentum);
        } else {
          scheduleResume();
        }
      }

      // Track the current style element for cleanup
      var currentStyleEl = null;

      function resumeAnimation() {
        if (!track) return;

        trackWidth = getTrackWidth();
        if (trackWidth <= 0) return;

        // Normalize position to be within valid range
        wrapPosition();

        // Clean up previous dynamic style if exists
        if (currentStyleEl && currentStyleEl.parentNode) {
          currentStyleEl.parentNode.removeChild(currentStyleEl);
        }

        // Create a unique animation name for this carousel instance
        var animName = 'scroll-carousel-resume-' + Date.now();

        // Inject a keyframe animation that starts from the current position
        currentStyleEl = document.createElement('style');
        currentStyleEl.textContent = '@keyframes ' + animName + ' { from { transform: translateX(' + currentTranslateX + 'px); } to { transform: translateX(' + (currentTranslateX - trackWidth) + 'px); } }';
        document.head.appendChild(currentStyleEl);

        // Apply the animation in a single frame to avoid snap
        // First set the animation, which will immediately start from currentTranslateX
        track.style.animation = 'none';
        track.offsetHeight; // Force reflow
        track.style.transform = '';
        track.style.animation = animName + ' ' + animationDuration + 's linear infinite';

        track.classList.remove('dragging');
        track.classList.remove('resuming');
        hasInteracted = false;
      }

      // Mouse events
      track.addEventListener('mousedown', function(e) {
        e.preventDefault();
        startDrag(e.clientX);
      });

      track.addEventListener('mousemove', function(e) {
        if (isDragging) {
          e.preventDefault();
          updateDrag(e.clientX);
        }
      });

      document.addEventListener('mouseup', function() {
        endDrag();
      });

      // Touch events
      track.addEventListener('touchstart', function(e) {
        if (e.touches.length > 0) {
          startDrag(e.touches[0].clientX);
        }
      }, { passive: true });

      track.addEventListener('touchmove', function(e) {
        if (isDragging && e.touches.length > 0) {
          updateDrag(e.touches[0].clientX);
        }
      }, { passive: true });

      document.addEventListener('touchend', function() {
        endDrag();
      });

      document.addEventListener('touchcancel', function() {
        endDrag();
      });
    });
  }

  // Initial binding
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', bindCarousels);
  } else {
    bindCarousels();
  }

  // Re-bind on dynamic content changes
  var carouselObserver = new MutationObserver(function() {
    bindCarousels();
  });
  carouselObserver.observe(document.body, { childList: true, subtree: true });
''';
}
