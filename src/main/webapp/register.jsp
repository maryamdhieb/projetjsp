<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
     <title>SportShop</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        body, html { height: 100%; margin: 0; font-family: 'Segoe UI', sans-serif; }
        .split-container {
            display: flex;
            height: 100vh;
            overflow: hidden;
        }
        .left-side {
            flex: 1;
            background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.6)), url('https://images.unsplash.com/photo-1530549384075-2c0b2d4d13e3?ixlib=rb-4.0.3&auto=format&fit=crop&q=80') center/cover no-repeat;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
        }
        .illustration {
            text-align: center;
            max-width: 80%;
        }
        .illustration h1 {
            font-size: 3rem;
            font-weight: 900;
            margin-bottom: 1rem;
        }
        .illustration p {
            font-size: 1.3rem;
            opacity: 0.9;
        }
        .right-side {
            flex: 1;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        .register-card {
            width: 100%;
            max-width: 420px;
        }
        .register-card h2 {
            color: #ff6b35;
            font-weight: 800;
            margin-bottom: 2rem;
        }
        .form-control {
            border-radius: 12px;
            padding: 14px 18px;
            border: 1px solid #e0e0e0;
        }
        .form-control:focus {
            border-color: #ff6b35;
            box-shadow: 0 0 0 0.25rem rgba(255, 107, 53, 0.15);
        }
        .btn-register {
            background-color: #ff6b35;
            border: none;
            font-weight: bold;
            padding: 14px;
            border-radius: 12px;
            transition: all 0.3s;
        }
        .btn-register:hover {
            background-color: #e55a2b;
            transform: scale(1.03);
        }
        .login-link a {
            color: #ff6b35;
            font-weight: 600;
        }
        @media (max-width: 992px) {
            .split-container { flex-direction: column; }
            .left-side { height: 40vh; }
            .right-side { height: 60vh; }
        }
    </style>
</head>
<body>

<div class="split-container">
    <!-- Côté gauche : Illustration sportive -->
    <div class="left-side">
        <div class="illustration">
            <h1>Join SportShop</h1>
            <p>Get access to the best sports gear and exclusive deals!</p>
            <i class="bi bi-trophy fs-1 mt-4"></i>
        </div>
    </div>

    <!-- Côté droit : Formulaire -->
    <div class="right-side">
        <div class="register-card">
            <h2 class="text-center">Create Account</h2>
            <form action="/servlet-jsp-gr3/register" method="post">
                <div class="mb-4">
                    <input type="text" class="form-control form-control-lg" name="fullname" placeholder="Full Name" required>
                </div>
                <div class="mb-4">
                    <input type="email" class="form-control form-control-lg" name="email" placeholder="Email Address" required>
                </div>
                <div class="mb-4">
                    <input type="password" class="form-control form-control-lg" name="password" placeholder="Password" required>
                </div>

                <button type="submit" class="btn btn-register btn-lg w-100 text-white">
                    Register Now
                </button>

                <div class="text-center mt-4">
                    Already have an account? <a href="index.jsp">Sign In</a>
                </div>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>