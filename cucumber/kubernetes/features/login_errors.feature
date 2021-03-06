Feature: Errors emitted by the login method.

  # Skip this test as we're not currently doing IP verification.
  @skip
  Scenario: It's an error to login as a different host than the one that sent the request.
    Given I login to authn-k8s as "stateful_set/inventory-stateful"
    And I use the IP address of "pod/inventory-pod"
    When I login to authn-k8s as "stateful_set/inventory-stateful"
    Then the HTTP status is "401"

  Scenario: It's an error to login as a host which does not hold "authenticate" privilege
    on the webservice.
    When I login to authn-k8s as "pod/inventory-unauthorized"
    Then the HTTP status is "401"

  Scenario: It's an error to login as a service account host which does not match the calling pod.
    When I login to pod matching "app=inventory-deployment" to authn-k8s as "service_account/inventory-pod-only"
    Then the HTTP status is "401"
