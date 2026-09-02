/* Goliath Consulting LLC — scroll reveals + inquiry form */
(function () {
  'use strict';

  /* Scroll reveals ---------------------------------------------------- */
  // Elements are visible by default; the observer replays them on entry, so
  // nothing is ever hidden if IntersectionObserver is missing or never fires.
  var reduced = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  if ('IntersectionObserver' in window && !reduced) {
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (entry) {
        if (!entry.isIntersecting) return;
        entry.target.setAttribute('data-revealed', '1');
        entry.target.style.animation = 'rise 0.85s cubic-bezier(0.22,0.7,0.25,1) both';
        io.unobserve(entry.target);
      });
    }, { rootMargin: '0px 0px -10% 0px', threshold: 0.05 });

    document.querySelectorAll('[data-reveal]:not([data-revealed])').forEach(function (el) {
      io.observe(el);
    });
  }

  /* Inquiry form ------------------------------------------------------- */
  // No backend: submitting hands the inquiry to the visitor's email client,
  // pre-addressed and pre-filled, so nothing is silently dropped.
  var INBOX = 'aac@goliathconsultingllc.com';
  var form = document.getElementById('inquiry-form');
  if (!form) return;

  var button = form.querySelector('.submit');
  var note = form.querySelector('.form-note');

  form.addEventListener('submit', function (event) {
    event.preventDefault();

    var data = new FormData(form);
    var name = (data.get('name') || '').trim();
    var org = (data.get('org') || '').trim();
    var email = (data.get('email') || '').trim();
    var message = (data.get('message') || '').trim();

    var subject = 'Consulting inquiry' + (org ? ' — ' + org : name ? ' — ' + name : '');
    var body = [
      'Name: ' + name,
      'Organization: ' + (org || '—'),
      'Email: ' + email,
      '',
      'What are you working through?',
      message || '—'
    ].join('\n');

    window.location.href = 'mailto:' + INBOX +
      '?subject=' + encodeURIComponent(subject) +
      '&body=' + encodeURIComponent(body);

    if (button) button.textContent = 'Opened in your email app';
    if (note) note.textContent = 'Finish sending it from there and we will respond within one business day.';
  });
})();
