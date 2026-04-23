<?php
session_start();
require_once __DIR__ . '/dbconnection.php';

if (!isset($_SESSION['user_id'])) {
    header('Location: signin.php');
    exit();
}

$buyer_id = (int) $_SESSION['user_id'];

if (!isset($_GET['id']) || !is_numeric($_GET['id'])) {
    http_response_code(400);
    echo "Invalid item.";
    exit();
}

$note_id = (int) $_GET['id'];

$stmt = $conn->prepare('SELECT id, title, user_id, fee FROM notes WHERE id = ?');
$stmt->bind_param('i', $note_id);
$stmt->execute();
$note = $stmt->get_result()->fetch_assoc();
$stmt->close();

if (!$note) {
    http_response_code(404);
    echo "Note not found.";
    exit();
}

$seller_id = (int) $note['user_id'];
$amount = (float) $note['fee'];

$conn->begin_transaction();

try {
    $pay = $conn->prepare("INSERT INTO transactions (user_id, type, amount, status) VALUES (?, 'payment', ?, 'completed')");
    $pay->bind_param('id', $buyer_id, $amount);
    $pay->execute();
    $pay->close();

    $earn = $conn->prepare("INSERT INTO transactions (user_id, type, amount, status) VALUES (?, 'earning', ?, 'completed')");
    $earn->bind_param('id', $seller_id, $amount);
    $earn->execute();
    $earn->close();

    $conn->commit();
} catch (Throwable $e) {
    $conn->rollback();
    http_response_code(500);
    echo "Purchase failed. Please try again.";
    exit();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Purchase Complete</title>
    <link rel="stylesheet" href="styles.css">
    <style>
        body { font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif; background:#f6f7fb; margin:0; }
        .wrap { max-width: 720px; margin: 48px auto; background:#fff; border:1px solid #e5e7eb; border-radius:12px; padding:20px; }
        a { color:#2563eb; }
    </style>
</head>
<body>
    <div class="wrap">
        <h1>Purchase recorded</h1>
        <p><strong><?php echo htmlspecialchars($note['title']); ?></strong> — $<strong><?php echo htmlspecialchars(number_format($amount, 2)); ?></strong></p>
        <p>This is a simple purchase flow: it records a <code>payment</code> for you and an <code>earning</code> for the uploader in the <code>transactions</code> table.</p>
        <p><a href="noteBank.php">Back to Note Bank</a></p>
    </div>
</body>
</html>
