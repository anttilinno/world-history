// Context-aware back link. Priority:
//   1. ?from=globe  -> back to the globe (globe opens articles in a new tab, so
//      there is no referrer to read; it tags the URL instead).
//   2. arrived from the Articles index -> back to the index.
//   3. otherwise -> the default timeline link, untouched.
(function () {
  var el = document.querySelector('a.back');
  if (!el) return;

  if (new URLSearchParams(location.search).get('from') === 'globe') {
    el.href = '../globe.html';
    el.textContent = '← Back to globe';
    return;
  }

  var ref = document.referrer;
  if (!ref) return;
  var path;
  try { path = new URL(ref).pathname; } catch (e) { return; }
  if (path.endsWith('/articles/') || path.endsWith('/articles/index.html')) {
    el.href = 'index.html';
    el.textContent = '← Back to articles';
  }
})();
