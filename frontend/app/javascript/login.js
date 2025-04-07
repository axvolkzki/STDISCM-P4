document.addEventListener("DOMContentLoaded", function () {
    const loginForm = document.getElementById('login-form');

    loginForm.addEventListener('submit', async function(event) {
        event.preventDefault();

        //User input values
        const idNumber = document.getElementById('idNumber').value.trim();
        const password = document.getElementById('password').value.trim();

        const userData = {
            id: idNumber,
            password: password
        };

         // send user data to the server using a fetch request
        try {
             // checks if response is successful
            const response = await fetch('http://127.0.0.1:3001/api/v1/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    id: idNumber,
                    password: password,
                  }),
                  credentials: "include" 
            });



            const data = await response.json();
            console.log('Full response data:', data);
            if(response.ok) {
                // if registration is successful, redirect to student dashboard
                alert('Login successful.');
                // Store the token in localStorage (or cookie)
                localStorage.setItem('jwt_token', data.token);
                window.location.href = '/studentdashboard';
                loginForm.reset(); // clear form fields
            }
            else {
                alert('Login not successful.');
            }
        } catch(error) {
            console.error('Error: ', error);
            alert('An error occurred while processing your request. Please try again later.');
        }
    })
});