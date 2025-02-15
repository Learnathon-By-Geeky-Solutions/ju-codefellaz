async function renderUsers() {
    const apiUrl = "/api/all-users";
    const container = document.getElementById("userTable");

    if (!container) return;

    // Show a loading state
    container.innerHTML = `<tr><td colspan="4" style="text-align:center;">Loading users...</td></tr>`;

    try {
        const response = await fetchData(apiUrl);

        if (response.error) {
            container.innerHTML = `<tr><td colspan="4" style="color: red; text-align: center;">${response.error}</td></tr>`;
            return;
        }

        if (!response.data || !Array.isArray(response.data)) {
            container.innerHTML = `<tr><td colspan="4" style="color: red; text-align: center;">Invalid data format</td></tr>`;
            return;
        }

        // Map the user data into table rows
        container.innerHTML = response.data.map(user => `
            <tr>
                <td>${user.name}</td>
                <td>${user.email}</td>
                <td>${user.role}</td>
                <td>
                    <button class="action-btn edit-btn">Edit</button>
                    <button class="action-btn delete-btn">Delete</button>
                </td>
            </tr>
        `).join("");

    } catch (error) {
        container.innerHTML = `<tr><td colspan="4" style="color: red; text-align: center;">Error fetching users</td></tr>`;
        console.error("Error fetching users:", error);
    }
}


















// async function renderUsers() {
//     const apiUrl = "/api/all-users";
//     const response = await fetchData(apiUrl);
//     const container = document.getElementById("userTable");
//
//     if (!container) return;
//     if (response.error) {
//         container.innerHTML = `<p style="color: red;">${response.error}</p>`;
//         return;
//     }
//
//     if (!response.data || !Array.isArray(response.data)) {
//         container.innerHTML = `<p style="color: red;">Invalid data format</p>`;
//         return;
//     }
//
//     container.innerHTML = response.data.map(user => `
//         <tr>
//             <td>${user.name}</td>
//             <td>${user.email}</td>
//             <td>${user.role}</td>
//         </tr>
//     `).join("");
// }
