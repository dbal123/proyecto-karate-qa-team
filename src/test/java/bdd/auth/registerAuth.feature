Feature: Registrar un nuevo usuario completando todos los datos


  @automation-registro01
  Scenario Outline: Registrar mas de un usuario <casename>
    Given url urlBase
    And path "/api/register"
    And request read('classpath:resources/json/auth/bodyRegistro1.json')
    When method post
    Then status <status>
    Examples:
      | mail               | pass     | name          | type | statususr | status | casename |
      | tstqa103@gmail.com | 12345678 | Prueba SPF    | 1    | 1         | 200    | Exitoso  |
      | carlosz@gmail.com  | 12345678 | Carlos Santos | 1    | 1         | 500    | Fallido  |


  @automation-registro02
  Scenario Outline: Registrar usuarios con archivo json y csv  <casename>
    Given url urlBase
    And path "/api/register"
    And request read('classpath:resources/json/auth/bodyRegistro1.json')
    When method post
    Then status <status>
    Examples:
      | read('classpath:resources/csv/auth/dataRegister.csv') |

  @automation-registro03
  Scenario: Registro fallido de usuario con email vacio

    Given url urlBase
    And path "/api/register"
    And request {"email": "","password": "12345678","nombre": "Prueba Qa Team","tipo_usuario_id": "1","estado": "1"}
    When method post
    Then status 500
    And match response.email[0] == "The email field is required."
