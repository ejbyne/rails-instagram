Feature: Visiting pictures page
  In order to view photos
  As a user of the website
  I want to see other users' photos

Scenario: Visiting the page before pictures created
  Given I visit the pictures page
  And it says there are no pictures
  Then I should see "Add a picture"
