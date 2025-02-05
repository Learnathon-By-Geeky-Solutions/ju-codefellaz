async function submitRegistrationForm(event) {
    console.log("Form submitted");
    event.preventDefault();  // Prevent form from submitting the traditional way

    const name = document.getElementById("name").value;
    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;
    const role = document.getElementById("role").value;

    const user = { name, email, password, role };

    try {
        const response = await fetch("/api/register", {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(user)
        });

        const data = await response.json();
        console.log(data);

        if (!response.ok) {
            throw new Error(data.message || "Registration failed");
        }

        document.getElementById("message").innerHTML = `<p style="color: green;">User registered successfully!</p>`;
        // Optionally, redirect after successful registration
        // window.location.href = "/login"; // Redirect to login page after registration
    } catch (error) {
        document.getElementById("message").innerHTML = `<p style="color: red;">Error: ${error.message}</p>`;
    }
}

document.getElementById("registrationForm").addEventListener("submit", submitRegistrationForm);
