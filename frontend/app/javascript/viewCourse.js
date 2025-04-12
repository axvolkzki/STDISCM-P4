document.addEventListener("DOMContentLoaded", function () {
    async function fetchCourses() {
        try {
            const response = await fetch("http://localhost:3002/api/v1/courses", {
                method: "GET",
                headers: {
                    "Content-Type": "application/json",
                    "Authorization": `Bearer ${localStorage.getItem("jwt_token")}`
                },
                credentials: "include"
            });
    
            if (!response.ok) {
                throw new Error("Error connecting to backend");
            }
    
            const data = await response.json();
            const tableBody = document.getElementById("course-table");
            tableBody.innerHTML = "";
    
            if (data.length === 0) {
                tableBody.innerHTML = "<tr><td colspan='10'>No available courses.</td></tr>";
                return;
            }
    
            data.forEach((course) => {
                const row = document.createElement("tr");
                row.innerHTML = `
                    <td>${course.code}</td>
                    <td>${course.name}</td>
                    <td>${course.maxStudents}</td>
                    <td>${course.numStudents}</td>
                    <td>${course.section}</td>
                `;
                tableBody.appendChild(row);
            });
        } catch (error) {
            console.error("Error fetching courses:", error);
            alert("Failed to fetch courses.");
        }
    }

    fetchCourses();
});
