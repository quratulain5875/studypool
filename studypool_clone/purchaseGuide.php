<?php
// Backwards-compatible alias used by older links in `viewBookGuide.php`
$query = $_SERVER['QUERY_STRING'] ?? '';
$target = 'purchaseBookGuide.php' . ($query !== '' ? ('?' . $query) : '');
header('Location: ' . $target, true, 302);
exit();
