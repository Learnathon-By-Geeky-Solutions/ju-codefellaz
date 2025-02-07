async function submitLoginForm(event) {
    console.log("Login form submitted");
    event.preventDefault();  // Prevent traditional form submission

    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;

    const user = { email, password };

    try {
        const response = await fetch("/api/login", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(user)
        });

        const data = await response.json();
        console.log(data);

        if (!response.ok) {
            throw new Error(data.message || "Login failed");
        }

        document.getElementById("loginMessage").innerHTML = `<p style="color: green;">Login successful!</p>`;

        // Redirect to dashboard or homepage after successful login
        // window.location.href = "/dashboard"; // Change the path as per your app
    } catch (error) {
        document.getElementById("loginMessage").innerHTML = `<p style="color: red;">Error: ${error.message}</p>`;
    }
}

document.getElementById("loginForm").addEventListener("submit", submitLoginForm);
