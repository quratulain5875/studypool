<?php
session_start();
require_once __DIR__ . '/dbconnection.php';

// If the user is already logged in, redirect them to the dashboard
if (isset($_SESSION['user_id'])) {
    // Redirect based on user role (Tutor or Regular User)
    if ($_SESSION['role'] == 'student') {
        header('Location: dashboard.php'); // Redirect to student dashboard
    } else {
        header('Location: TutorDashboard.php'); // Redirect to tutor dashboard
    }
    exit();
}

// Handle form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Sanitize input
    $email = $conn->real_escape_string($_POST['email']);
    $password = $_POST['password'];

    // Validate input
    if (empty($email) || empty($password)) {
        echo "<script>alert('Both email and password are required.');</script>";
    } else {
        // Query to fetch user details
        $sql = "SELECT * FROM users WHERE email = '$email'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $user = $result->fetch_assoc();
            
            // Verify the password
            if (password_verify($password, $user['password'])) {
                // Regenerate session ID to prevent session fixation attacks
                session_regenerate_id(true);

                // Store user data in the session
                $_SESSION['user_id'] = $user['id'];
                $_SESSION['role'] = $user['role'];
                $_SESSION['email'] = $user['email']; // Corrected line

                // Redirect based on user role (Tutor or Regular User)
                if ($_SESSION['role'] == 'tutor') {
                    header('Location: TutorDashboard.php'); // Redirect to tutor dashboard
                } else {
                    header('Location: dashboard.php'); // Redirect to student dashboard
                }
                exit();
            } else {
                echo "<script>alert('Invalid password.');</script>";
            }
        } else {
            echo "<script>alert('No user found with this email.');</script>";
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign In - Study Pool</title>
    <style>
        :root {
            --bg: #0b1220;
            --card: rgba(255, 255, 255, 0.06);
            --card-border: rgba(255, 255, 255, 0.12);
            --text: rgba(255, 255, 255, 0.92);
            --muted: rgba(255, 255, 255, 0.70);
            --primary: #3b82f6;
            --primary-hover: #2563eb;
            --ring: rgba(59, 130, 246, 0.35);
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif; }
        body {
            min-height: 100vh;
            display: grid;
            place-items: center;
            padding: 24px;
            background:
              radial-gradient(900px 600px at 15% 15%, rgba(59, 130, 246, 0.35), transparent 60%),
              radial-gradient(700px 500px at 85% 30%, rgba(34, 197, 94, 0.18), transparent 55%),
              radial-gradient(900px 700px at 50% 95%, rgba(168, 85, 247, 0.20), transparent 55%),
              var(--bg);
            color: var(--text);
        }

        .shell {
            width: min(980px, 100%);
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 18px;
            align-items: stretch;
        }

        .panel {
            border: 1px solid var(--card-border);
            background: var(--card);
            backdrop-filter: blur(10px);
            border-radius: 16px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.35);
            overflow: hidden;
        }

        .left {
            padding: 28px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            background:
              radial-gradient(600px 400px at 20% 20%, rgba(59, 130, 246, 0.25), transparent 60%),
              radial-gradient(500px 350px at 80% 70%, rgba(34, 197, 94, 0.14), transparent 60%),
              rgba(255, 255, 255, 0.04);
        }

        .brand {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .logo {
            width: 40px;
            height: 40px;
            border-radius: 12px;
            background: linear-gradient(135deg, rgba(59, 130, 246, 1), rgba(168, 85, 247, 1));
            box-shadow: 0 10px 30px rgba(59, 130, 246, 0.25);
        }

        .brand h1 { font-size: 18px; letter-spacing: 0.2px; }
        .brand p { margin-top: 2px; font-size: 13px; color: var(--muted); }

        .left h2 { margin-top: 18px; font-size: 28px; line-height: 1.15; }
        .left .subtitle { margin-top: 10px; color: var(--muted); font-size: 15px; line-height: 1.5; }

        .bullets { margin-top: 18px; display: grid; gap: 10px; color: var(--muted); font-size: 14px; }
        .bullet { display: flex; gap: 10px; align-items: flex-start; }
        .dot { margin-top: 3px; width: 10px; height: 10px; border-radius: 999px; background: rgba(59, 130, 246, 0.9); box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.15); }

        .right { padding: 28px; }

        .tabs {
            display: flex;
            gap: 10px;
            margin-bottom: 18px;
            font-size: 14px;
        }
        .tabs a {
            text-decoration: none;
            color: var(--muted);
            padding: 8px 12px;
            border-radius: 999px;
            border: 1px solid transparent;
        }
        .tabs a.active {
            color: var(--text);
            border-color: rgba(255, 255, 255, 0.14);
            background: rgba(255, 255, 255, 0.06);
        }

        .title { font-size: 22px; margin-bottom: 6px; }
        .helper { color: var(--muted); font-size: 14px; margin-bottom: 18px; }

        .form-group { margin-bottom: 14px; }
        label { display: block; margin-bottom: 6px; font-size: 13px; color: var(--muted); }
        input {
            width: 100%;
            padding: 12px 12px;
            border-radius: 12px;
            border: 1px solid rgba(255, 255, 255, 0.14);
            background: rgba(0, 0, 0, 0.18);
            color: var(--text);
            outline: none;
        }
        input:focus { border-color: rgba(59, 130, 246, 0.7); box-shadow: 0 0 0 4px var(--ring); }

        .row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 10px 0 6px;
            gap: 10px;
            flex-wrap: wrap;
        }
        .row a { color: rgba(255, 255, 255, 0.82); text-decoration: none; font-size: 13px; }
        .row a:hover { text-decoration: underline; }

        .btn-primary {
            width: 100%;
            padding: 12px 14px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 10px;
        }
        .btn-primary:hover { background: var(--primary-hover); }

        .footer-text { text-align: center; margin-top: 14px; font-size: 13px; color: var(--muted); }
        .footer-text a { color: rgba(255, 255, 255, 0.9); text-decoration: none; }
        .footer-text a:hover { text-decoration: underline; }

        .notice {
            margin-bottom: 14px;
            border: 1px solid rgba(255, 255, 255, 0.14);
            background: rgba(255, 255, 255, 0.06);
            padding: 10px 12px;
            border-radius: 12px;
            color: rgba(255, 255, 255, 0.86);
            font-size: 13px;
        }

        @media (max-width: 900px) {
            .shell { grid-template-columns: 1fr; }
            .left { display: none; }
        }
    </style>
</head>
<body>
    <div class="shell">
        <section class="panel left">
            <div>
                <div class="brand">
                    <div class="logo" aria-hidden="true"></div>
                    <div>
                        <h1>Studypool Clone</h1>
                        <p>Student–Tutor learning platform</p>
                    </div>
                </div>
                <h2>Welcome back.</h2>
                <p class="subtitle">Sign in to manage your questions, access resources, and connect with verified tutors.</p>
                <div class="bullets" role="list">
                    <div class="bullet" role="listitem"><span class="dot" aria-hidden="true"></span><span>Post questions with budgets and deadlines</span></div>
                    <div class="bullet" role="listitem"><span class="dot" aria-hidden="true"></span><span>Browse notes and book guides</span></div>
                    <div class="bullet" role="listitem"><span class="dot" aria-hidden="true"></span><span>Track uploads and balance in your dashboard</span></div>
                </div>
            </div>
            <div class="helper">Tip: Use your registered email and password.</div>
        </section>

        <section class="panel right" aria-label="Sign in form">
            <div class="tabs" aria-label="Auth navigation">
                <a href="signup.php">Sign up</a>
                <a href="signin.php" class="active" aria-current="page">Sign in</a>
            </div>

            <div class="title">Sign in</div>
            <div class="helper">Enter your credentials to continue.</div>

            <form method="POST" action="">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" placeholder="you@example.com" autocomplete="email" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Your password" autocomplete="current-password" required>
                </div>

                <div class="row">
                    <a href="signup.php">Create a new account</a>
                </div>

                <button type="submit" class="btn-primary">Continue</button>
            </form>
            <p class="footer-text">New here? <a href="signup.php">Sign up</a></p>
        </section>
    </div>
</body>
</html>
