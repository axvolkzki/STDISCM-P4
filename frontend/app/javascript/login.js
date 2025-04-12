document.addEventListener("DOMContentLoaded", function () {
    const loginForm = document.getElementById('login-form');
    const loginError = document.getElementById('login-error');
    const successDiv = document.getElementById('login-success');
    const successMessage = document.getElementById('login-success-message');

    loginForm.addEventListener('submit', async function (event) {
        event.preventDefault();

        const idNumber = document.getElementById('idNumber').value.trim();
        const password = document.getElementById('password').value.trim();

        loginError.textContent = '';  
        successDiv.classList.add('hidden');

        try {
            const response = await fetch('http://127.0.0.1:3001/api/v1/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    id: idNumber,
                    password: password,
                }),
                credentials: "include",
            });

            const data = await response.json();

            if (response.ok) {
                successMessage.textContent = 'Login successful.';
                successDiv.classList.remove('hidden');  // show the success alert
                
                // success message visible for 4s
                setTimeout(() => {
                    successDiv.classList.remove('hidden');
                }, 4000);

                // Store token and user role in localStorage
                localStorage.setItem('jwt_token', data.token);
                localStorage.setItem('user_role', data.user.role);

                // store the token in cookies
                document.cookie = `jwt_token=${data.token}`
                document.cookie = `user_role=${data.user.role}`

                // Redirect based on the user role  
                setTimeout(() => {
                    if (data.user.role === 'student') {
                        window.location.href = '/studentdashboard';
                    } else if (data.user.role === 'faculty' || data.user.role === 'professor') {
                        window.location.href = '/facultydashboard';
                    } else {
                        alert('Unknown user role.');
                    }
                }, 1500);

                loginForm.reset();
            } else {
                // for debugging
                // alert('Login not successful.');
                loginError.textContent = data.error || data.message || 'Login not successful. Please check your ID or password.';
            }
        } catch (error) {
            console.error('Error:', error);
            loginError.textContent = 'An error occurred. Please try again.';
        }
    });
});

document.addEventListener("DOMContentLoaded", function () {
     // logout functionality
     const logoutBtn = document.getElementById('logout-btn');
     logoutBtn.addEventListener('click', async function (e) {
         e.preventDefault();
 
         try {
            const response = await fetch('http://127.0.0.1:3001/api/v1/logout', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${localStorage.getItem("jwt_token")}`,
                },
                credentials: "include",
            });

            localStorage.removeItem('jwt_token');
            localStorage.removeItem('user_role');
 
            // for debugging
            //  alert("You have been logged out successfully.");
             window.location.href = '/';
         } catch (err) {
             alert("Logout failed.");
         }
     });
});  