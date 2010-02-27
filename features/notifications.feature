Feature: Notifications
  So that I know the status of my sites
  As a site owner
  I want to receive notifications when a site goes down

  Scenario: Receiving a "Site is down" Notification
    Given the following site:
      | name   | url                   |
      | Woobly | http://www.woobly.com |
    When "Woobly" has an unsuccessful attempt
    Then "servers@neotericdesign.com" should have 1 email