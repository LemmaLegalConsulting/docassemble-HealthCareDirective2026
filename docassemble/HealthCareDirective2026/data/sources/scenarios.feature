Feature: Narrative regression scenarios

  @instructions_only
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

  @agent_only
  Scenario: Devon appoints one agent and leaves optional instructions blank
    # Selected sections appear; dormant people and blank prompts do not. Long text must not be silently truncated.
    Given I start the interview at "health_care_directive_2026.yml"
    And the maximum seconds for each step is 90
    When I get to "download health care directive" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
      | users[0].name.first | Devon | |
      | users[0].name.last | Chen | |
      | users[0].birthdate | 01/02/1970 | |
      | users[0].address.address | 123 Example Street | |
      | users[0].address.city | St. Paul | |
      | users[0].address.state | MN | |
      | users[0].address.zip | 55101 | |
      | directive_choices['agent'] | True | |
      | directive_choices['instructions'] | False | |
      | primary_agent.name.first | Alex | |
      | primary_agent.name.last | Primary | |
      | primary_agent.address.address | 123 Example Street | |
      | primary_agent.address.city | St. Paul | |
      | primary_agent.address.state | MN | |
      | primary_agent.address.zip | 55101 | |
      | primary_agent.relationship | Friend | |
      | primary_agent.phone_number | 6125550100 | |
      | appoint_alternate_agent | False | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/fact-sheet/health-care-directives"
    And I download "health_care_directive_2026.pdf"
    And the downloaded PDF "health_care_directive_2026.pdf" should contain "Alex Primary"

  @combined
  Scenario: Noor appoints an agent and alternate and writes care wishes
    # Selected sections appear; dormant people and blank prompts do not. Long text must not be silently truncated.
    Given I start the interview at "health_care_directive_2026.yml"
    And the maximum seconds for each step is 90
    When I get to "download health care directive" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
      | users[0].name.first | Noor | |
      | users[0].name.last | Hassan | |
      | users[0].birthdate | 01/02/1970 | |
      | users[0].address.address | 123 Example Street | |
      | users[0].address.city | St. Paul | |
      | users[0].address.state | MN | |
      | users[0].address.zip | 55101 | |
      | directive_choices['agent'] | True | |
      | directive_choices['instructions'] | True | |
      | primary_agent.name.first | Alex | |
      | primary_agent.name.last | Primary | |
      | primary_agent.address.address | 123 Example Street | |
      | primary_agent.address.city | St. Paul | |
      | primary_agent.address.state | MN | |
      | primary_agent.address.zip | 55101 | |
      | primary_agent.relationship | Friend | |
      | primary_agent.phone_number | 6125550100 | |
      | appoint_alternate_agent | True | |
      | alternate_agent.name.first | Taylor | |
      | alternate_agent.name.last | Alternate | |
      | alternate_agent.address.address | 123 Example Street | |
      | alternate_agent.address.city | St. Paul | |
      | alternate_agent.address.state | MN | |
      | alternate_agent.address.zip | 55101 | |
      | alternate_agent.relationship | Sibling | |
      | alternate_agent.phone_number | 6515550100 | |
      | other_health_care_wishes | Keep me comfortable and let my family visit. | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/fact-sheet/health-care-directives"
    And I download "health_care_directive_2026.pdf"
    And the downloaded PDF "health_care_directive_2026.pdf" should contain "Alex Primary"
    And the downloaded PDF "health_care_directive_2026.pdf" should contain "Taylor Alternate"
    And the downloaded PDF "health_care_directive_2026.pdf" should contain "Keep me comfortable"

  @combined_no_alternate
  Scenario: Casey combines instructions with one agent
    # Selected sections appear; dormant people and blank prompts do not. Long text must not be silently truncated.
    Given I start the interview at "health_care_directive_2026.yml"
    And the maximum seconds for each step is 90
    When I get to "download health care directive" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
      | users[0].name.first | Casey | |
      | users[0].name.last | Morgan | |
      | users[0].birthdate | 01/02/1970 | |
      | users[0].address.address | 123 Example Street | |
      | users[0].address.city | St. Paul | |
      | users[0].address.state | MN | |
      | users[0].address.zip | 55101 | |
      | directive_choices['agent'] | True | |
      | directive_choices['instructions'] | True | |
      | primary_agent.name.first | Alex | |
      | primary_agent.name.last | Primary | |
      | primary_agent.address.address | 123 Example Street | |
      | primary_agent.address.city | St. Paul | |
      | primary_agent.address.state | MN | |
      | primary_agent.address.zip | 55101 | |
      | primary_agent.relationship | Friend | |
      | primary_agent.phone_number | 6125550100 | |
      | appoint_alternate_agent | False | |
      | other_health_care_wishes | Keep me comfortable and let my family visit. | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/fact-sheet/health-care-directives"
    And I download "health_care_directive_2026.pdf"
    And the downloaded PDF "health_care_directive_2026.pdf" should contain "Alex Primary"
    And the downloaded PDF "health_care_directive_2026.pdf" should contain "Keep me comfortable"

  @long_unicode
  Scenario: María writes long wishes with accented names and punctuation
    # Selected sections appear; dormant people and blank prompts do not. Long text must not be silently truncated.
    Given I start the interview at "health_care_directive_2026.yml"
    And the maximum seconds for each step is 90
    When I get to "download health care directive" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
      | users[0].name.first | María | |
      | users[0].name.last | O’Neill-Rivera | |
      | users[0].birthdate | 01/02/1970 | |
      | users[0].address.address | 123 Example Street | |
      | users[0].address.city | St. Paul | |
      | users[0].address.state | MN | |
      | users[0].address.zip | 55101 | |
      | directive_choices['agent'] | False | |
      | directive_choices['instructions'] | True | |
      | other_health_care_wishes | My family’s wishes matter. I want time with family & friends. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices.  | |
      | health_care_goals | My family’s wishes matter. I want time with family & friends. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices.  | |
      | health_care_fears | My family’s wishes matter. I want time with family & friends. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices.  | |
      | spiritual_beliefs | My family’s wishes matter. I want time with family & friends. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices.  | |
      | beliefs_about_quality_of_life | My family’s wishes matter. I want time with family & friends. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices.  | |
      | thoughts_about_family | My family’s wishes matter. I want time with family & friends. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices.  | |
      | pregnancy_care_wishes | My family’s wishes matter. I want time with family & friends. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices.  | |
      | temporary_incapacity_wishes | My family’s wishes matter. I want time with family & friends. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices.  | |
      | dying_care_wishes | My family’s wishes matter. I want time with family & friends. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices.  | |
      | permanent_unconsciousness_wishes | My family’s wishes matter. I want time with family & friends. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices.  | |
      | dependent_care_wishes | My family’s wishes matter. I want time with family & friends. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices.  | |
      | pain_relief_wishes | My family’s wishes matter. I want time with family & friends. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices.  | |
      | preferred_doctor | My family’s wishes matter. I want time with family & friends. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices.  | |
      | preferred_care_location | My family’s wishes matter. I want time with family & friends. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices.  | |
      | preferred_dying_location | My family’s wishes matter. I want time with family & friends. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices.  | |
      | organ_donation_wishes | My family’s wishes matter. I want time with family & friends. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices.  | |
      | body_disposition_wishes | My family’s wishes matter. I want time with family & friends. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices. Please listen to my values and explain choices.  | |
    Then I should see the link to "https://www.lawhelpmn.org/self-help-library/fact-sheet/health-care-directives"
    And I download "health_care_directive_2026.pdf"
    And the downloaded PDF "health_care_directive_2026.pdf" should not contain "Alex Primary"

  @blank_instructions
  Scenario: Lee leaves all instructions blank without an agent
    # Do not produce a directive with neither an agent nor instructions.
    Given I start the interview at "health_care_directive_2026.yml"
    And the maximum seconds for each step is 90
    When I get to "after death wishes" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
      | users[0].name.first | Lee | |
      | users[0].name.last | Park | |
      | users[0].birthdate | 01/02/1970 | |
      | users[0].address.address | 123 Example Street | |
      | users[0].address.city | St. Paul | |
      | users[0].address.state | MN | |
      | users[0].address.zip | 55101 | |
      | directive_choices['agent'] | False | |
      | directive_choices['instructions'] | True | |
    When I tap to continue
    Then I should see the phrase "Write at least one health care instruction"
    And the question id should be "after death wishes"


  @remove_agent
  Scenario: Noor removes the agent after reaching downloads
    # Selected sections appear; dormant people and blank prompts do not. Long text must not be silently truncated.
    Given I start the interview at "health_care_directive_2026.yml"
    And the maximum seconds for each step is 90
    When I get to "download health care directive" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
      | users[0].name.first | Noor | |
      | users[0].name.last | Hassan | |
      | users[0].birthdate | 01/02/1970 | |
      | users[0].address.address | 123 Example Street | |
      | users[0].address.city | St. Paul | |
      | users[0].address.state | MN | |
      | users[0].address.zip | 55101 | |
      | directive_choices['agent'] | True | |
      | directive_choices['instructions'] | True | |
      | primary_agent.name.first | Alex | |
      | primary_agent.name.last | Primary | |
      | primary_agent.address.address | 123 Example Street | |
      | primary_agent.address.city | St. Paul | |
      | primary_agent.address.state | MN | |
      | primary_agent.address.zip | 55101 | |
      | primary_agent.relationship | Friend | |
      | primary_agent.phone_number | 6125550100 | |
      | appoint_alternate_agent | True | |
      | alternate_agent.name.first | Taylor | |
      | alternate_agent.name.last | Alternate | |
      | alternate_agent.address.address | 123 Example Street | |
      | alternate_agent.address.city | St. Paul | |
      | alternate_agent.address.state | MN | |
      | alternate_agent.address.zip | 55101 | |
      | alternate_agent.relationship | Sibling | |
      | alternate_agent.phone_number | 6515550100 | |
      | other_health_care_wishes | Keep me comfortable and let my family visit. | |
    When I follow the review link containing "Edit answers"
    And I follow the review link containing "What to include:"
    And I get to "directive review" with this data:
      | var | value | trigger |
      | directive_choices['agent'] | False | |
      | directive_choices['instructions'] | True | |
    When I tap to continue
    Then the question id should be "download health care directive"
    Then I download "health_care_directive_2026.pdf"
    And the downloaded PDF "health_care_directive_2026.pdf" should not contain "Alex Primary"
    And the downloaded PDF "health_care_directive_2026.pdf" should not contain "Taylor Alternate"
    And the downloaded PDF "health_care_directive_2026.pdf" should contain "Keep me comfortable"


  @remove_alternate
  Scenario: Noor removes only the alternate agent
    # Selected sections appear; dormant people and blank prompts do not. Long text must not be silently truncated.
    Given I start the interview at "health_care_directive_2026.yml"
    And the maximum seconds for each step is 90
    When I get to "download health care directive" with this data:
      | var | value | trigger |
      | acknowledged_information_use | True | |
      | users[0].name.first | Noor | |
      | users[0].name.last | Hassan | |
      | users[0].birthdate | 01/02/1970 | |
      | users[0].address.address | 123 Example Street | |
      | users[0].address.city | St. Paul | |
      | users[0].address.state | MN | |
      | users[0].address.zip | 55101 | |
      | directive_choices['agent'] | True | |
      | directive_choices['instructions'] | True | |
      | primary_agent.name.first | Alex | |
      | primary_agent.name.last | Primary | |
      | primary_agent.address.address | 123 Example Street | |
      | primary_agent.address.city | St. Paul | |
      | primary_agent.address.state | MN | |
      | primary_agent.address.zip | 55101 | |
      | primary_agent.relationship | Friend | |
      | primary_agent.phone_number | 6125550100 | |
      | appoint_alternate_agent | True | |
      | alternate_agent.name.first | Taylor | |
      | alternate_agent.name.last | Alternate | |
      | alternate_agent.address.address | 123 Example Street | |
      | alternate_agent.address.city | St. Paul | |
      | alternate_agent.address.state | MN | |
      | alternate_agent.address.zip | 55101 | |
      | alternate_agent.relationship | Sibling | |
      | alternate_agent.phone_number | 6515550100 | |
      | other_health_care_wishes | Keep me comfortable and let my family visit. | |
    When I follow the review link containing "Edit answers"
    And I follow the review link containing "Choose or remove an alternate agent"
    And I get to "directive review" with this data:
      | var | value | trigger |
      | appoint_alternate_agent | False | |
    When I tap to continue
    Then the question id should be "download health care directive"
    Then I download "health_care_directive_2026.pdf"
    And the downloaded PDF "health_care_directive_2026.pdf" should contain "Alex Primary"
    And the downloaded PDF "health_care_directive_2026.pdf" should not contain "Taylor Alternate"

