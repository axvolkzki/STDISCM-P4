// https://stackoverflow.com/questions/10730362/get-cookie-by-name
function getCookie(name) {
    function escape(s) { return s.replace(/([.*+?\^$(){}|\[\]\/\\])/g, '\\$1'); }
    var match = document.cookie.match(RegExp('(?:^|;\\s*)' + escape(name) + '=([^;]*)'));
    return match ? match[1] : null;
}

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

        target = confirmbtn.getAttribute("request-target")
        token = getCookie("jwt_token")
        console.log(token)
        const res = await fetch(target, {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
                "Authorization": `Bearer ${token}`
            },
            body: JSON.stringify({
                id: id,
                grade: grade
            }),
            
        })
        const jsonRes = await res.json()

        if (res.status == 401) {
            alert(jsonRes["message"])
        } else if (gradeCell) {
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
