document.addEventListener("DOMContentLoaded", function () {
    const modal = document.getElementById("dropModal");
    const confirmdrop = document.getElementById("confirm-btn-drop");
    const canceldrop = document.getElementById("cancel-btn-drop");
    let classID = null; 

    document.querySelectorAll(".dropBtn").forEach(button => {
        button.onclick = () => {
            classID = button.dataset.classId;  // Assign to studentID
            modal.style.display = "flex";  // Show the modal
        };
    });

    confirmdrop.addEventListener("click", () => {
        const dropCell = document.querySelector(`.drop-cell[data-class-id="${classID}"]`);
        dropCell.textContent = "Dropped";

        // Close the modal
        modal.style.display = "none";
    });

    canceldrop.onclick = () => {
        modal.style.display = "none";  // Close the modal
    };

    window.onclick = function (event) {
        if (event.target === modal) {
            modal.style.display = "none";  // Close the modal if clicked outside
        }
    };
});
