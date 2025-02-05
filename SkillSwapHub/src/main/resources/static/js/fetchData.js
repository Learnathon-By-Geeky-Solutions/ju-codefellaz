async function fetchData(apiUrl) {
    try {
        const response = await fetch(apiUrl);
        const data = await response.json();

        if (!response.ok) {
            throw new Error(data.message || "Failed to fetch data");
        }

        return data;
    } catch (error) {
        return { error: error.message };
    }
}
