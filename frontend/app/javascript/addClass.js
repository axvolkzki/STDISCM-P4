function getCookie(name) {
    function escape(s) {
        return s.replace(/([.*+?\^$(){}|\[\]\/\\])/g, '\\$1');
    }
    var match = document.cookie.match(RegExp('(?:^|;\\s*)' + escape(name) + '=([^;]*)'));
    return match ? match[1] : null;
}

document.addEventListener("DOMContentLoaded", function () {
    const enrollForm = document.getElementById("enrollment-form");
    const courseIdInput = document.getElementById("courseIdInput");
    const enrollTable = document.getElementById("enroll-course-table");

    const token = getCookie("jwt_token");

    async function fetchEnrolledCourses() {
        try {
            const res = await fetch("http://localhost:3003/api/v1/list", {
                headers: {
                    "Content-Type": "application/json",
                    "Authorization": `Bearer ${token}`
                }
            });

            const courses = await res.json();

            enrollTable.innerHTML = "";

            courses.forEach(course => {
                const row = document.createElement("tr");
                row.innerHTML = `
                    <td>${course.course_id}</td>
                    <td>${course.code}</td>
                    <td>${course.name}</td>
                    <td>${course.maxStudents}</td>
                    <td>${course.numStudents}</td>
                    <td>${course.section}</td>
                `;
                enrollTable.appendChild(row);
            });

        } catch (err) {
            console.error("Failed to fetch enrolled courses:", err);
        }
    }

    enrollForm.addEventListener("submit", async (e) => {
        e.preventDefault();
        const courseId = courseIdInput.value;

        if (!courseId || isNaN(courseId)) {
            alert("Please enter a valid course ID.");
            return;
        }

        const res = await fetch("http://localhost:3003/api/v1/enroll", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Authorization": `Bearer ${token}`
            },
            body: JSON.stringify({
                course_id: courseId
            })
        });

        const json = await res.json();

        if (res.status === 201) {
            alert(json.message || "Successfully enrolled!");
            fetchEnrolledCourses();
        } else {
            alert(json.error || "Something went wrong.");
        }

        courseIdInput.value = "";
    });

    fetchEnrolledCourses();
});
