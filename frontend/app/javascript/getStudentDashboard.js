document.addEventListener("DOMContentLoaded", function () {
    async function fetchStudentData() {
        try {
            const response = await fetch('http://127.0.0.1:3001/api/v1/dashboard/student', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${localStorage.getItem('jwt_token')}`
                },
                credentials: 'include'
            });

            if (!response.ok) {
                console.error('Failed to fetch student data:', response.status);
                return;
            }

            const data = await response.json();
            console.log('Data received from backend:', data);

            updateUI(data);
        } catch (error) {
            console.error('Error fetching student data:', error);
        }
    }

    function updateUI(data) {
        if (data && data.student) {
            document.getElementById('student-name').textContent = data.student.last_name + ' ' + data.student.first_name + ', ' + data.student.middle_name|| 'N/A';
            document.getElementById('student-id').textContent = data.student.student_id || 'N/A';
        }
    }

    fetchStudentData();
});
