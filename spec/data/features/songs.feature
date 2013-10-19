# Based on turnip/examples

Feature: Battle a monster
  Scenario: normal monster
    Given there is a monster
     When I attack it
     Then it should die
      And Fanfare

  Scenario Outline: a simple outline
      Given there is a monster with <hp> hitpoints
      When I attack the monster and do <damage> points damage
      Then the monster should be <state>

      Examples:
        | hp | damage | state |
        | 10 |     13 | alive |
        | 12 |      8 | dead  |
        |  3 |     10 | alive |
        |  8 |      5 | dead  |

  Scenario: strong monster
    Given there is a strong monster
     When I attack it
     Then it should die
      And Fanfare
