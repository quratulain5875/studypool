<?php
session_start();
require_once __DIR__ . '/dbconnection.php';

if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    echo json_encode(['error' => 'Not authenticated']);
    exit;
}

$user_id = (int) $_SESSION['user_id'];

// Get the selected subject from POST request
$subject = $_POST['subject'] ?? 'all';
$subject_safe = $conn->real_escape_string($subject);
$subject_filter = $subject_safe !== 'all' ? "AND category = '$subject_safe'" : '';

// Fetch filtered questions
$questions_query = "SELECT * FROM questions WHERE user_id = $user_id $subject_filter";
$ongoing_questions_query = "SELECT * FROM questions WHERE user_id = $user_id AND status = 'open' $subject_filter";
$completed_questions_query = "SELECT * FROM questions WHERE user_id = $user_id AND status = 'completed' $subject_filter";

$questions_result = $conn->query($questions_query);
$ongoing_questions_result = $conn->query($ongoing_questions_query);
$completed_questions_result = $conn->query($completed_questions_query);

// Prepare data for JSON response
$response = [
    'posted' => $questions_result->fetch_all(MYSQLI_ASSOC),
    'ongoing' => $ongoing_questions_result->fetch_all(MYSQLI_ASSOC),
    'completed' => $completed_questions_result->fetch_all(MYSQLI_ASSOC),
];

// Return JSON response
echo json_encode($response);
?>
