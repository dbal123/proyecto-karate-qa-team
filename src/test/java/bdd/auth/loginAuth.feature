Feature: Logear al usuario al sistema

  @automation-login1

  Scenario: Caso de prueba para login  Exitoso

    Given url urlBase
    And  path "/api/login"
    And form field email = "carlosz@gmail.com"
    And form field password = "12345678"
    When method post
    Then status 200
    * def AuthToken = response.access_token


  @automation-login2

  Scenario: Caso de prueba para login  Fallido
    * def msj = "Datos incorrectos"
    Given url urlBase
    And  path "/api/login"
    And form field email = "testx@gmail.com"
    And form field password = "12345678"
    When method post
    Then status 401
    Then match response.message == msj


  @automation-login3

  Scenario Outline: Caso de prueba para login <tipocaso> con examples
    Given url urlBase
    And path "/api/login"
    And form field email = "<mail>"
    And form field password = "<pass>"
    When method post
    Then status <status>
    Examples:
      | mail               | pass     | status | tipocaso |
      | carlosz@gmail.com  | 12345678 | 200    | Exitoso  |
      | pruebaXX@gmail.com | 12345678 | 401    | Fallido  |