Feature: Create an account and add adress to the account

  Background: Create new Account
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def createAccountResult = callonce read('CreateAccountFeature.feature')
    And print createAccountResult
    * def primaryPersonId = createAccountResult.response.id
    * def token = createAccountResult.response.token

  Scenario: Add address to an account
    Given path '/api/accounts/add-account-address'
    Given param primaryPersonId = primaryPersonId
    Given header Authorization = "Bearer" + token
    Given request
      """
      {
      "addressType": "Home",
      "addressLine1": "7100 Tysons Central ST", 
      "city": "Vienna",
      "state": "Virginia",
      "postalCode": "22192",
      "current": "true"
      
      }
      """
    When method post
    Then status 201
    And print response
