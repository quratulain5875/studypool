<?php
include 'dbConnection.php';
session_start();

if (!isset($_SESSION['user_id'])) {
    echo "You must log in to sell a document.";
    exit();
}

$user_id = $_SESSION['user_id'];

// Handle form submission
if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_POST['title'], $_POST['description'], $_POST['price'])) {
    $title = $conn->real_escape_string($_POST['title']);
    $description = $conn->real_escape_string($_POST['description']);
    $price = (float)$_POST['price'];

    // File upload handling
    if (isset($_FILES['document']) && $_FILES['document']['error'] == 0) {
        $file_name = basename($_FILES['document']['name']);
        $file_tmp_path = $_FILES['document']['tmp_name'];
        $upload_dir = 'uploads/documents/';
        $file_path = $upload_dir . uniqid() . '_' . $file_name;

        // Ensure upload directory exists
        if (!is_dir($upload_dir)) {
            mkdir($upload_dir, 0777, true);
        }

        if (move_uploaded_file($file_tmp_path, $file_path)) {
            // Insert document details into the database
            $insert_query = "INSERT INTO documents (user_id, title, description, price, file_path) 
                             VALUES ('$user_id', '$title', '$description', '$price', '$file_path')";
            if ($conn->query($insert_query) === TRUE) {
                echo "Document uploaded and listed for sale successfully!";
            } else {
                echo "Error: " . $conn->error;
            }
        } else {
            echo "Error uploading the file.";
        }
    } else {
        echo "Please select a document to upload.";
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sell a Document</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
<!-- Navbar -->
<div class="navbar">
    <img src="https://www.studypool.com/images/logo.png" width="150px" alt="Study Pool Logo">
    <span class="menu-icon" onclick="toggleMenu()">&#9776;</span>
    <div class="menu">
        <a href="myProfile.php">My Profile</a>
        <a href="postQuestion.php">Post a Question</a>
        <a href="noteBank.php">Notebank</a>
        <a href="bookGuides.php">Book Guides</a>
        <a href="howItWorks.php">How It Works</a>
        <a href="myTutors.php">My Tutors</a>
        <a href="sellDocs.php">Sell Docs</a>
        <a href="settings.php">Settings</a>
        <a href="signout.php">Logout</a>
    </div>
</div>

<div class="sell-document">
    <h2>Sell a Document</h2>
    <form action="sellDocument.php" method="POST" enctype="multipart/form-data">
        <label for="title">Document Title:</label><br>
        <input type="text" name="title" id="title" required><br><br>

        <label for="description">Description:</label><br>
        <textarea name="description" id="description" rows="4" cols="50" required></textarea><br><br>

        <label for="price">Price ($):</label><br>
        <input type="number" name="price" id="price" step="0.01" required><br><br>

        <label for="document">Upload Document:</label><br>
        <input type="file" name="document" id="document" accept=".pdf,.doc,.docx" required><br><br>

        <button type="submit">Sell Document</button>
    </form>
</div>

<style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
    }

    .sell-document {
        max-width: 600px;
        margin: 0 auto;
        padding: 20px;
        border: 1px solid #ddd;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    }

    h2 {
        text-align: center;
        color: #333;
    }

    label {
        font-weight: bold;
    }

    input, textarea, button {
        width: 100%;
        padding: 10px;
        margin-top: 5px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    button {
        background-color: #4CAF50;
        color: white;
        border: none;
        cursor: pointer;
    }

    button:hover {
        background-color: #45a049;
    }
    body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
        }
        .navbar {
            display: flex;
            justify-content: space-between;
            background-color: #007bff;
            padding: 10px 20px;
            align-items: center;
        }
        .navbar img {
            height: 50px;
        }
        .navbar input[type="text"] {
            padding: 10px;
            width: 300px;
            border-radius: 5px;
            border: 1px solid #ddd;
        }
        .menu-icon {
            display: none;
            font-size: 30px;
            color: white;
            cursor: pointer;
        }
        .menu {
            display: flex;
            gap: 20px;
        }
        .menu a {
            color: white;
            text-decoration: none;
        }
</style>

</body>
</html>
