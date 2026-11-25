# ALDashboard static draft reviewed against interview order and the existing regression suite.
@e2e
Feature: Complete a representative interview

  Scenario: Maya gives instructions without appointing anyone
    # Selected sections appear; dormant people and blank prompts do not. Long text must not be silently truncated.
    Given I start the interview at "health_care_directive_2026.yml"
    And the maximum seconds for each step is 90
    When I get to "download health care directive" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
      | users[0].name.first | Maya | |
      | users[0].name.last | Rivera | |
      | users[0].birthdate | 01/02/1970 | |
      | users[0].address.address | 123 Example Street | |
      | users[0].address.city | St. Paul | |
      | users[0].address.state | MN | |
      | users[0].address.zip | 55101 | |
      | directive_choices['agent'] | False | |
      | directive_choices['instructions'] | True | |
      | other_health_care_wishes | Keep me comfortable and let my family visit. | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/fact-sheet/health-care-directives"
    And I download "health_care_directive_2026.pdf"
    And the downloaded PDF "health_care_directive_2026.pdf" should not contain "Alex Primary"
    And the downloaded PDF "health_care_directive_2026.pdf" should contain "Keep me comfortable"
