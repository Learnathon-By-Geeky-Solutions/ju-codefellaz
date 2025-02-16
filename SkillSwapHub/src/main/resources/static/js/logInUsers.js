async function submitLoginForm(event) {
    console.log("Login form submission triggered");
    event.preventDefault(); // Prevent default form submission

    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;

    if (!email || !password) {
        showMessage("Both email and password are required.", "error");
        return;
    }
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

        // if (!response.ok) {
        //     throw new Error(data.responseMessage || "Login failed");
        // }

//         const token = data.data?.token;
//         if (!token) {
//             throw new Error("Token not received from server");
//         }
//         console.log(token);
//
//         window.location.href = "/all-users"; // Redirect after success
//     } catch (error) {
//         console.error("Login error:", error);
//         console.log(error.message);
//         document.getElementById("message").innerHTML = `<p style="color: red;">Error: ${error.message}</p>`;
//     }
// }

        if (data.responseCode === "S100000") { // Success response
            showMessage("Login successful!", "success");
            setTimeout(() => window.location.href = "/all-users", 2000);
        } else if (data.responseCode === "E000401") { // Authentication failed
            showMessage(data.responseMessage || "Invalid credentials. Please try again.", "error");
        } else {
            showMessage("An unexpected error occurred. Please try again later.", "error");
        }

    } catch (error) {
        showMessage("Network error. Please check your connection.", "error");
    }
}

// Function to display validation error messages


//Function to display general messages
function showMessage(message, type) {
    let toastContainer = document.getElementById("toast-container");

    let toast = document.createElement("div");
    toast.className = `toast ${type}`;
    toast.innerText = message;

    toastContainer.appendChild(toast);

    // Show toast
    setTimeout(() => {
        toast.classList.add("show");
    }, 100);

    // Hide toast after 4 seconds
    setTimeout(() => {
        toast.classList.remove("show");
        setTimeout(() => toast.remove(), 500);
    }, 7000);
}


document.addEventListener("DOMContentLoaded", function () {
    const form = document.getElementById("loginForm");
    if (form) {
        form.addEventListener("submit", submitLoginForm);
    } else {
        console.error("Login form not found in the DOM.");
    }

    const registerBtn = document.getElementById("registerBtn");
    if (registerBtn) {
        registerBtn.addEventListener("click", function () {
            window.location.href = "/register";
        });
    }
});

