async function submitRegistrationForm(event) {
    console.log('Form submitted');
    event.preventDefault();  // Prevent traditional form submission

    const name = document.getElementById("name").value;
    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;
    const role = document.getElementById("role").value;

    if (!name || !email || !password || !role) {
        showMessage("All fields are required.", "error");
        return;
    }
    const user = {name, email, password, role};

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
            setTimeout(() => window.location.href = "/login", 2000);
        } else if (data.responseCode === "E000102" && data.data) {  // Validation errors
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

    for (let key in errors) {

        showMessage(errors[key], "error");
    }
}

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


const form = document.getElementById("registrationForm");
if (form) {
    form.addEventListener("submit", submitRegistrationForm);
}

document.addEventListener("DOMContentLoaded",function (){
    const loginBtn = document.getElementById("loginBtn");

    if(loginBtn){
        loginBtn.addEventListener("click", function(){
            window.location.href = "/login";
        });
    }
});


