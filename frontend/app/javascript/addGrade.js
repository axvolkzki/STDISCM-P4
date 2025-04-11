document.addEventListener("DOMContentLoaded", function () {
    const modal = document.getElementById("gradeModal");
    const confirmbtn = document.getElementById("confirm-btn");
    const cancelbtn = document.getElementById("cancel-btn");
    const gradeSelect = document.getElementById("gradeSelect");
    let id = null; 

    document.querySelectorAll(".addGradeBtn").forEach(button => {
        button.onclick = () => {
            id = button.dataset.id;
            gradeSelect.value = button.dataset.grade
            modal.style.display = "flex";  // Show the modal
        };
    });

    confirmbtn.addEventListener("click", async () => {
        const grade = gradeSelect.value;  // Get selected grade
        const gradeCell = document.querySelector(`.grade-cell[data-id="${id}"]`);

        if (gradeCell) {
            gradeCell.textContent = grade;
        }

        target = confirmbtn.getAttribute("request-target")
        const res = await fetch(target, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                id: id,
                grade: grade
            }),
            
        })

        const jsonRes = await res.json()
        
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
