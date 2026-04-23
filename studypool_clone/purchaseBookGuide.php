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

$guide_id = (int) $_GET['id'];

$stmt = $conn->prepare('SELECT id, title, tutor_id, price FROM book_guides WHERE id = ?');
$stmt->bind_param('i', $guide_id);
$stmt->execute();
$guide = $stmt->get_result()->fetch_assoc();
$stmt->close();

if (!$guide) {
    http_response_code(404);
    echo "Book guide not found.";
    exit();
}

$seller_id = (int) $guide['tutor_id'];
$amount = (float) $guide['price'];

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
        <p><strong><?php echo htmlspecialchars($guide['title']); ?></strong> — $<strong><?php echo htmlspecialchars(number_format($amount, 2)); ?></strong></p>
        <p><a href="bookGuides.php">Back to Book Guides</a></p>
    </div>
</body>
</html>
