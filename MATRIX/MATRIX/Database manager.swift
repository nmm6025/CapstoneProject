def test_login_error_handling():
    # Attempt login with invalid credentials
    invalid_credentials = {
        "email": "invalid@example.com",
        "password": "invalidpassword"
    }
    response = client.post("/login", json=invalid_credentials)
    
    # Check if the response status code is 401 (Unauthorized)
    assert response.status_code == 401
    
    # Check if the response contains an error message indicating invalid credentials
    assert response.json()["error"] == "Invalid credentials"
