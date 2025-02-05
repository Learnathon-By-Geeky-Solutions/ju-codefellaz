async function renderUsers() {
    const apiUrl = "/api/all-users";
    const data = await fetchData(apiUrl);
    const container = document.getElementById("userTable");

    if (!container) return;
    if (data.error) {
        container.innerHTML = `<p style="color: red;">${data.error}</p>`;
        return;
    }

    container.innerHTML = data.map(user => `
        <tr>
            <td>${user.name}</td>
            <td>${user.email}</td>
        </tr>
    `).join("");
}
