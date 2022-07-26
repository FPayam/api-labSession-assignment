Feature: Security test. Token Generation test
@smoke
  Scenario: generate token with valid username and password.
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request { "username": "supervisor", "password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
   @smoke 
 Scenario: generate token with invalid username and valid password.
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request { "username": "supervisorr", "password": "tek_supervisor"}
    When method post
    Then status 404
    And print response
    
    * def errorMessage = response.errorMessage
    
    And assert errorMessage == "USER_NOT_FOUND"
    
    @reg
Scenario: generate token with valid username and invalid password.
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request { "username": "supervisorr", "password": "supervisor"}
    When method post
    Then status 400
    And print response
    
       * def errorMessage = Password Not Matched
    
    And assert errorMessage == "INTERNAL_SERVER_ERROR"
    
    