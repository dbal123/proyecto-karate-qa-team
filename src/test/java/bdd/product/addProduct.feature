Feature: Añadir un producto


  Background:
    * def response = call read('classpath:bdd/auth/loginAuth.feature@automation-login1')
    * def token = response.AuthToken
    * header Authorization = "Bearer " +token
    * url urlBase

  @automation-addProduct01

  Scenario Outline: Crear nuevos productos con archivo json y csv <caso>

    Given path "/api/v1/producto"
    And request read('classpath:resources/json/prod/bodyProduct.json')
    When method post
    Then status <status>
    Examples:
      | read('classpath:resources/csv/prod/dataProducto.csv') |


  @automation-addProduct02

  Scenario: Crear nuevo producto con docString en variable

    * def body =
     """
       {
  "codigo": "TC1127",
    "nombre": "ALTERNADOR PL300NS",
    "medida": "UND ",
    "marca": "Generico",
    "categoria": "Repuestos",
    "precio": "75.00",
    "stock": "28",
    "estado": "3",
    "descripcion": "ALTERNADOR PL300NS"
        }
    """
    Given path "/api/v1/producto"
    And request body
    When method post
    Then status 200
    * print response.id


  @automation-addProduct03


  Scenario: Caso fallido por producto duplicado

    Given path "/api/v1/producto"
    And request {"codigo": "TC0004","nombre": "ALTERNADOR PL300NS","medida": "UND ","marca": "Generico","categoria": "Repuestos","precio": "75.00","stock": "28","estado": "3","descripcion": "ALTERNADOR PL300NS"}
    When method post
    Then status 500
    * print response.error


  @automation-addProduct04

  Scenario Outline: Caso <casename> para validar la integridad del campo precio con examples
    Given path "/api/v1/producto"
    And request read('classpath:resources/json/prod/bodyProduct.json')
    When method post
    Then status <status>
    Then match response.precio[0]  == "<msj>"
    Examples:
      | cod    | name               | med | marc     | catg      | pryce | stck | sts | dsc                | casename | status | msj                           |
      | TC9021 | ALTERNADOR PL500NS | UND | Generico | Repuestos |       | 28   | 3   | ALTERNADOR PL500NS | fallido  | 500    | The precio field is required. |
      | TC0020 | ALTERNADOR PL200NS | UND | Generico | Repuestos | XX.00 | 48   | 3   | ALTERNADOR PL200NS | fallido  | 500    | The precio must be a number.  |
      | TC9727 | ALTERNADOR PL500NS | UND | Generico | Repuestos | 26.47 | 28   | 3   | ALTERNADOR PL500NS | exitoso  | 200    | #notpresent                   |


