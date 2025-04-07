document.addEventListener("DOMContentLoaded", function () {
    const modal = document.getElementById("gradeModal");
    const confirmbtn = document.getElementById("confirm-btn");
    const cancelbtn = document.getElementById("cancel-btn");
    const gradeSelect = document.getElementById("gradeSelect");
    let studentID = null; 

    document.querySelectorAll(".addGradeBtn").forEach(button => {
        button.onclick = () => {
            studentID = button.dataset.studentId;  // Assign to studentID
            modal.style.display = "flex";  // Show the modal
        };
    });

    confirmbtn.addEventListener("click", () => {
        const grade = gradeSelect.value;  // Get selected grade
        const gradeCell = document.querySelector(`.grade-cell[data-student-id="${studentID}"]`);

        if (gradeCell) {
            gradeCell.textContent = grade;
        }

        // Close the modal
        modal.style.display = "none";
    });

    cancelbtn.onclick = () => {
        modal.style.display = "none";  // Close the modal
    };

    window.onclick = function (event) {
        if (event.target === modal) {
            modal.style.display = "none";  // Close the modal if clicked outside
        }
    };
});
