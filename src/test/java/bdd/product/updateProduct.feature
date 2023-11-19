Feature: Actualizar productos

  Background:
    * def response = call read('classpath:bdd/auth/loginAuth.feature@automation-login1')
    * def token = response.AuthToken
    * header Authorization = "Bearer " +token
    * url urlBase
    * header Accept = "application/json"

  @automation-updateProduct01
  Scenario Outline: Actualizar lista de productos con archivo json y csv <caso>
    * def idproduct = <id>
    * def body = read('classpath:resources/json/prod/bodyUpdateProduct.json')

    Given path "/api/v1/producto/" + idproduct
    And request body
    When method put
    Then status <status>
    Then match response.id == idproduct
    Examples:
      | read('classpath:resources/csv/prod/dataUpdateProduct.csv') |

  @automation-updateProduct02
  Scenario:  actualiza producto por id especifico
    * def id = 1
    Given path "/api/v1/producto/" + id
    And request {"codigo": "TC0001","nombre": "ALTERNADOR PL900NS","medida": "UND ","marca": "Generico","categoria": "Repuestos","precio": "15.00","stock": "260","estado": "1","descripcion": "ALTERNADOR PL900NS"}
    When method put
    Then status 200


  @automation-updateProduct03
  Scenario Outline:  actualiza producto con examples de casos varios y docString
    * def idproduct = <id>
    * def bodyupdate =
    """
  {
  "codigo": "#(cod)",
  "nombre": "#(name)",
  "medida": "#(med)",
  "marca": "#(marc)",
  "categoria": "#(catg)",
  "precio": "#(pryce)",
  "stock": "#(stck)",
  "estado": "#(sts)",
  "descripcion": "#(dsc)"
  }
  """
    Given path "/api/v1/producto/" + idproduct
    And request bodyupdate
    When method put
    Then status <status>
    Examples:
      | id | cod    | name               | med | marc     | catg      | pryce | stck | sts | dsc                | status |
      | 1  | TC9021 | ALTERNADOR PL700NS | UND | Generico | Repuestos |       | 28   | 3   | ALTERNADOR PL700NS | 500    |
      | 2  | TC0020 | ALTERNADOR PL730NS | UND | Generico | Repuestos | XX.00 | 48   | 1   | ALTERNADOR PL730NS | 500    |
      | 8  | PRO008 | ALTERNADOR PL700NS | UND | Generico | Repuestos | 6.47  | 29   | 3   | ALTERNADOR PL700NS | 200    |
