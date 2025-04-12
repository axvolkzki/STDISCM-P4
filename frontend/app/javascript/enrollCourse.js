document.addEventListener("DOMContentLoaded", function () {
  let allCourses = [];

  // Fetch all available courses when the page loads
  async function fetchCourses() {
    try {
      const response = await fetch("http://localhost:3004/api/v1/view", {
        method: "GET",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${localStorage.getItem("jwt_token")}`,
        },
        credentials: "include",
      });

      if (!response.ok) {
        throw new Error("Error fetching courses");
      }

      const data = await response.json();
      allCourses = data;
      renderCourses(allCourses);
    } catch (error) {
      console.error("Error fetching courses:", error);
      alert("Failed to fetch courses.");
    }
  }

  // Render the course list with enroll buttons
  function renderCourses(courses) {
    const tableBody = document.getElementById("course-table");
    tableBody.innerHTML = "";

    if (courses.length === 0) {
      tableBody.innerHTML = "<tr><td colspan='10'>No available courses.</td></tr>";
      return;
    }

    courses.forEach((course) => {
      const row = document.createElement("tr");
      row.innerHTML = `
        <td>${course.id}</td>
        <td>${course.code}</td>
        <td>${course.name}</td>
        <td>${course.maxStudents}</td>
        <td>${course.numStudents}</td>
        <td>${course.section}</td>
        <td>
          <button class="enroll-btn" data-course-id="${course.id}" ${
            course.numStudents >= course.maxStudents ? "disabled" : ""
          }>
            ${course.numStudents >= course.maxStudents ? "Full" : "Enroll"}
          </button>
        </td>
      `;
      tableBody.appendChild(row);
    });

    // Bind enroll button click events
    document.querySelectorAll(".enroll-btn").forEach((button) => {
      button.addEventListener("click", enrollInCourse);
    });
  }

  // Enroll in a course
  async function enrollInCourse(event) {
    const courseId = event.target.getAttribute("data-course-id");

    try {
      const response = await fetch("http://localhost:3004/api/v1/enroll", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Authorization": `Bearer ${localStorage.getItem("jwt_token")}`,
        },
        body: JSON.stringify({ course_id: courseId }),
        credentials: "include",
      });

      const result = await response.json();

      if (response.ok) {
        alert(`Successfully enrolled in ${result.course.name}`);
        await fetchCourses(); // Re-fetch and update course list
      } else {
        alert(`Failed to enroll: ${result.message}`);
      }
    } catch (error) {
      console.error("Error enrolling:", error);
      alert("Error enrolling in course.");
    }
  }

  // Search courses by ID or code
  const searchInput = document.getElementById("search-input");

  searchInput.addEventListener("input", function () {
    const query = this.value.trim().toLowerCase();

    const filtered = allCourses.filter((course) => {
      return (
        course.code.toLowerCase().includes(query) ||
        course.id.toString().includes(query)
      );
    });

    renderCourses(filtered);
  });

  // Initial fetch
  fetchCourses();
});
