<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.Instant" %>
<%
    if (session != null && session.getAttribute("otpGeneratedTime") == null) {
        session.setAttribute("otpGeneratedTime", Instant.now());
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Verify OTP</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        body {
            font-family: 'Segoe UI', Arial, sans-serif;
            background: #f4f6f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .otp-container {
            background: white;
            padding: 40px 30px;
            border-radius: 12px;
            box-shadow: 0 4px 25px rgba(0,0,0,0.08);
            max-width: 380px;
            width: 100%;
            text-align: center;
        }

        .otp-container h2 {
            margin-bottom: 8px;
            font-size: 22px;
            color: #333;
        }

        .otp-container p {
            color: #777;
            font-size: 14px;
            margin-bottom: 20px;
        }

        .otp-inputs {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }

        .otp-inputs input {
            width: 48px;
            height: 56px;
            font-size: 22px;
            text-align: center;
            border: 1px solid #ccc;
            border-radius: 8px;
            outline: none;
            transition: border-color 0.2s;
        }

        .otp-inputs input:focus {
            border-color: #4a90e2;
            box-shadow: 0 0 0 2px rgba(74,144,226,0.2);
        }

        button {
            width: 100%;
            padding: 12px;
            background: #4a90e2;
            border: none;
            color: white;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            transition: background 0.2s;
        }

        button:hover {
            background: #3d7ecb;
            color: white;
        }

        button:disabled {
            background: #ccc;
            cursor: not-allowed;
        }

        .timer {
            margin-top: 15px;
            font-size: 14px;
            color: #555;
        }

        .resend-btn {
            background: transparent;
            border: none;
            color: #4a90e2;
            font-size: 14px;
            cursor: pointer;
            margin-top: 8px;
            transition: all 0.2s ease;
        }

        .resend-btn:hover:enabled {
            background: #4a90e2;
            color: white;
            padding: 12px 10px;
            border-radius: 6px;
        }

        .resend-btn:disabled {
            color: #999;
            cursor: not-allowed;
        }
    </style>
</head>
<body>

<div class="otp-container">
    <h2>Enter OTP</h2>
    <p>We sent a 6-digit code to your email</p>

    <form action="verifyOtp" method="post" id="otpForm">
        <div class="otp-inputs">
            <input type="text" maxlength="1" name="otp1" required>
            <input type="text" maxlength="1" name="otp2" required>
            <input type="text" maxlength="1" name="otp3" required>
            <input type="text" maxlength="1" name="otp4" required>
            <input type="text" maxlength="1" name="otp5" required>
            <input type="text" maxlength="1" name="otp6" required>
        </div>
        <button type="submit">Verify OTP</button>
    </form>

    <div class="timer" id="timer">OTP expires in 01:00</div>
    <form action="ResendOtpServlet" method="post">
        <button type="submit" class="resend-btn" id="resendBtn" disabled>Resend OTP</button>
    </form>
</div>

<script>
    // OTP Input Auto-focus + Backspace Handling
    const inputs = document.querySelectorAll(".otp-inputs input");

    inputs.forEach((input, index) => {
        input.addEventListener("input", () => {
            if (input.value.length === 1 && index < inputs.length - 1) {
                inputs[index + 1].focus();
            }
        });

        input.addEventListener("keydown", (e) => {
            if (e.key === "Backspace" && input.value === "" && index > 0) {
                inputs[index - 1].focus();
            }
        });
    });

    // Countdown Timer
    let timeLeft = 60;
    const timerDisplay = document.getElementById('timer');
    const resendBtn = document.getElementById('resendBtn');

    function updateTimer() {
        let minutes = String(Math.floor(timeLeft / 60)).padStart(2, '0');
        let seconds = String(timeLeft % 60).padStart(2, '0');
        timerDisplay.textContent = `OTP expires in ${minutes}:${seconds}`;

        if (timeLeft <= 0) {
            clearInterval(timerInterval);
            timerDisplay.textContent = "OTP expired";
            resendBtn.disabled = false;
        }
        timeLeft--;
    }

    let timerInterval = setInterval(updateTimer, 1000);
</script>

</body>
</html>
