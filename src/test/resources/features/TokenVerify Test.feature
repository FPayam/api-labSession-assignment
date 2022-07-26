Feature: Security test. Verify Token test.

Scenario: Verify valid token.

Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request { "username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
    
    * def generatedToken = response.token
    Given path "/api/token/verify"
    And param username = "supervisor"
    And param token = generatedToken
    When method get
    Then status 200
    And print response
   
   
    
  Scenario: Verify invalid token.

		Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token/verify"
    And param username = "supervisor"
    And param token = "invalid_token_random_string" method post
    When method get
    Then status 400
    And print response
    
    * def errorMsg = response.errrorMsg
    And assert errorMsg== "TOKEN_EXPIRED" 
    

    # 3) test api endpoint "/api/token/verify" with valid token.
    # and invalid username, then status should be 400
    # and and errorMessage = Wrong Username send along with Token
    
    
    Scenario: 	verify with valid token and invalid username
    
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token/"
    And request { "username": "supervisor11", "password": "tek_supervisor"}
   
    When method get
    Then status 2
    And print response
    
    * def errorMsg = response.errrorMsg
    And assert errorMsg== "Wrong Username send along with Token" 
    
    
    
    
    
    