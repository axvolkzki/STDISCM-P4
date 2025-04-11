document.addEventListener("DOMContentLoaded", function () {
    const loginForm = document.getElementById('login-form');

    loginForm.addEventListener('submit', async function(event) {
        event.preventDefault();

        const idNumber = document.getElementById('idNumber').value.trim();
        const password = document.getElementById('password').value.trim();

        const userData = {
            id: idNumber,
            password: password
        };

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
            console.log('response data:', data);
            if(response.ok) {
                // if registration is successful, redirect to student dashboard
                alert('Login successful.');
                // Store the token in localStorage
                localStorage.setItem('jwt_token', data.token);
                localStorage.setItem('user_role', data.user.role);

                // store the token in cookies
                document.cookie = `jwt_token=${data.token}`
                document.cookie = `user_role=${data.user.role}`

                console.log('User role:', data.user.role);
                console.log('Full response data:', data);
                
                if (data.user.role === 'student') {
                    window.location.href = '/studentdashboard';
                } else if (data.user.role === 'faculty') {
                    window.location.href = '/facultydashboard';
                } else {
                    alert('unknown role');
                }

                loginForm.reset(); // clear form
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