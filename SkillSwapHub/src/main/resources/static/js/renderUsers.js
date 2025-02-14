async function renderUsers() {
    const apiUrl = "/api/all-users";
    const response = await fetchData(apiUrl);
    const container = document.getElementById("userTable");

    if (!container) return;
    if (response.error) {
        container.innerHTML = `<p style="color: red;">${response.error}</p>`;
        return;
    }

    if (!response.data || !Array.isArray(response.data)) {
        container.innerHTML = `<p style="color: red;">Invalid data format</p>`;
        return;
    }

    container.innerHTML = response.data.map(user => `
        <tr>
            <td>${user.name}</td>
            <td>${user.email}</td>
            <td>${user.role}</td>
        </tr>
    `).join("");
}
