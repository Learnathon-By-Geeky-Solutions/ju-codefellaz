async function submitRegistrationForm(event) {
    console.log("Form submitted");
    event.preventDefault();  // Prevent traditional form submission

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

        // Handle API response codes
        if (data.responseCode === "S100000") {  // Success
            showMessage("User registered successfully!", "success");
            // Optionally, redirect after successful registration
            // setTimeout(() => window.location.href = "/login", 2000);
        } else if (data.responseCode === "E000102") {  // Validation errors
            handleValidationErrors(data.data);
        } else {
            showMessage(data.responseMessage || "An unexpected error occurred.", "error");
        }

    } catch (error) {
        showMessage("Network error. Please try again later.", "error");
    }
}

// Function to display validation error messages
function handleValidationErrors(errors) {
    let messageBox = document.getElementById("message");
    messageBox.innerHTML = ""; // Clear previous messages

    for (let key in errors) {
        let errorMessage = `<p style="color: red;">${errors[key]}</p>`;
        messageBox.innerHTML += errorMessage;
    }
}

// Function to display general messages
function showMessage(message, type) {
    const messageDiv = document.getElementById("message");
    messageDiv.innerHTML = `<p style="color: ${type === "success" ? "green" : "red"}; font-size: 10px;">${message}</p>`;
}

document.getElementById("registrationForm").addEventListener("submit", submitRegistrationForm);
