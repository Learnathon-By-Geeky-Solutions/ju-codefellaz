async function submitLoginForm(event) {
    console.log("Login form submission triggered");
    event.preventDefault(); // Prevent default form submission

    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;

    const user = {email, password};
    try {
        const response = await fetch("/api/login", {
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify(user),
            credentials: 'include'
        });

        const data = await response.json();
        console.log("Response received:", data);

        if (!response.ok) {
            throw new Error(data.responseMessage || "Login failed");
        }

        const token = data.data?.token;
        if (!token) {
            throw new Error("Token not received from server");
        }
        console.log(token);

        window.location.href = "/all-users"; // Redirect after success
    } catch (error) {
        console.error("Login error:", error);
        console.log(error.message);
        document.getElementById("message").innerHTML = `<p style="color: red;">Error: ${error.message}</p>`;
    }
}

document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("loginForm");
    if (form) {
        form.addEventListener("submit", submitLoginForm);
    } else {
        console.error("Login form not found in the DOM.");
    }
});

