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
        let errorMessage = `<p class="validation-error">${errors[key]}</p>`;
        messageBox.innerHTML += errorMessage;
    }
}

//Function to display general messages
function showMessage(message, type) {
    const messageDiv = document.getElementById("message");
    messageDiv.innerHTML = `<p style="color: ${type === "success" ? "#0F5133" : "#84202A"}; font-size: 10px;" class="submission-msg">${message}</p>`;
}

document.getElementById("registrationForm").addEventListener("submit", submitRegistrationForm);






































// async function submitRegistrationForm(event) {
//     console.log('Form submitted');
//     event.preventDefault();  // Prevent traditional form submission
//
//     const name = document.getElementById("name").value;
//     const email = document.getElementById("email").value;
//     const password = document.getElementById("password").value;
//     const role = document.getElementById("role").value;
//
//     if (!name || !email || !password || !role) {
//         showMessage("All fields are required.", "error");
//         return;
//     }
//     const user = { name, email, password, role };
//
//     try {
//         const response = await fetch("/api/register", {
//             method: "POST",
//             headers: {
//                 "Content-Type": "application/json"
//             },
//             body: JSON.stringify(user)
//         });
//         if (!response.ok) {
//             throw new Error(`HTTP error! Status: ${response.status}`);
//         }
//
//         const data = await response.json();
//         console.log(data);
//
//         // Handle API response codes
//         if (data.responseCode === "S100000") {  // Success
//             showMessage("User registered successfully!", "success");
//             // Optionally, redirect after successful registration
//              setTimeout(() => window.location.href = "/login", 2000);
//         } else if (data.responseCode === "E000102" && data.data) {  // Validation errors
//             handleValidationErrors(data.data);
//         } else {
//             showMessage(data.responseMessage || "An unexpected error occurred.", "error");
//         }
//
//     } catch (error) {
//         showMessage("Network error. Please try again later.", "error");
//     }
// }
//
// // Function to display validation error messages
// function handleValidationErrors(errors) {
//     // let messageBox = document.getElementById("message");
//     // messageBox.innerHTML = ""; // Clear previous messages
//
//     for (let key in errors) {
//         // let errorMessage = `<p class="validation-error">${errors[key]}</p>`;
//         // messageBox.innerHTML += errorMessage;
//         showMessage(errors[key], "error");
//     }
// }
//
// //Function to display general messages
// function showMessage(message, type) {
//     let toastContainer = document.getElementById("toast-container");
//
//     let toast = document.createElement("div");
//     toast.className = `toast ${type}`;
//     toast.innerText = message;
//
//     toastContainer.appendChild(toast);
//
//     // Show toast
//     setTimeout(() => {
//         toast.classList.add("show");
//     }, 100);
//
//     // Hide toast after 4 seconds
//     setTimeout(() => {
//         toast.classList.remove("show");
//         setTimeout(() => toast.remove(), 500);
//     }, 7000);
// }
//
// //     const messageDiv = document.getElementById("message");
// //     messageDiv.innerHTML = `<p style="color: ${type === "success" ? "#0F5133" : "#84202A"}; font-size: 10px;" class="submission-msg">${message}</p>`;
//
//
// const form = document.getElementById("registrationForm");
// if(form) {
//     form.addEventListener("submit", submitRegistrationForm);
// }