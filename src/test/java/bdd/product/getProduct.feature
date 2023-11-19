Feature:  Listar producto por id

  Background:
    * def response = call read('classpath:bdd/auth/loginAuth.feature@automation-login1')
    * def token = response.AuthToken
    * header Authorization = "Bearer " +token
    * url urlBase

  @automation-getProduct01
  Scenario: Listar un producto por id especifico utilizando  variable
    * def id = 5
    Given path "/api/v1/producto/" + id
    When method get
    Then status 200
    Then match response.id == id
    Then match response.codigo == "PRO005"
    * print response.nombre +" con precio de: " +response.precio


  @automation-getProduct02
  Scenario Outline: Listar varios productos con archivo csv - id <id>

    Given path "/api/v1/producto/" + <id>
    When method get
    Then status <status>
    Then match response.codigo == "<code>"
    Examples:
      | read('classpath:resources/csv/prod/idProducto.csv') |

  @automation-getProduct03
  Scenario: Listar todos los producto
    Given path "/api/v1/producto/"
    When method get
    Then status 200
    And match responseType == "json"