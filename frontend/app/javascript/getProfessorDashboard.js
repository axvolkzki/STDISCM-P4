document.addEventListener("DOMContentLoaded", function () {
    async function fetchProfessorData() {
        try {
            const response = await fetch('http://127.0.0.1:3001/api/v1/dashboard/professor', {
                method: 'GET',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${localStorage.getItem('jwt_token')}`
                },
                credentials: 'include'
            });

            if (!response.ok) {
                console.error('Failed to fetch professor data:', response.status);
                throw new Error(data.error || 'Unknown error');
                return;
            }

            const data = await response.json();
            console.log('Data received from backend:', data);

            updateUI(data);
        } catch (error) {
            console.error('Error fetching professor data:', error);
        }
    }

    function updateUI(data) {
        if (data && data.professor) {
            document.getElementById('faculty-name').textContent = data.professor.last_name + ' ' + data.professor.first_name + ', ' + data.professor.middle_name|| 'N/A';
            document.getElementById('faculty-id').textContent = data.professor.professor_id || 'N/A';
        }
    }

    fetchProfessorData();
});
