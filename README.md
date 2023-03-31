Visitors to the site will be able to create applications to adopt pets. An application has many pets. Pets can have many applications.

[ ] done

1. Application Show Page

As a visitor
When I visit an applications show page
Then I can see the following:
- Name of the Applicant
- Full Address of the Applicant including street address, city, state, and zip code
- Description of why the applicant says they'd be a good home for this pet(s)
- names of all pets that this application is for (all names of pets should be links to their show page)
- The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

# Adopt, don't Shop

This is a paired project used in Turing School's Backend Program Module 2.

## Learning Goals

In this project, students will build upon the code in this repo to create a Pet Adoption Platform. Users will be able to apply to adopt pets, and Admins will be able to approve or reject applications and see statistics for the Shelters, Pets, and Applications in the system.

* Build out CRUD functionality for a many to many relationship
* Use ActiveRecord to write queries that join multiple tables of data together
* Use MVC to organize code effectively, limiting the amount of logic included in views and controllers
* Validate models and handle sad paths for invalid data input
* Use flash messages to give feedback to the user
* Use partials in views
* Use `within` blocks in tests
* Track user stories using GitHub Projects
* Deploy your application to the internet

## Requirements
* Project must use Rails 5.2.x, Ruby 2.7.4, and PostgreSQL
* Use of `resources` on this project is not permitted
* Use of scaffolding on this project is not permitted
* Students wanting to use any extra gems on this project must first get permission from your instructors
  * Pre-approved gems are `capybara, pry, faker, factorybot, orderly, simplecov, shoulda-matchers, launchy`

## Project Phases

1. [Set Up](./doc/set_up.md)
1. [User Stories](./doc/user_stories.md)
1. [Evaluation](./doc/evaluation.md)

## Check In

This project will have one Check In. During your Check In, you should be prepared to review your database schema for the many to many relationship, your deployment to Heroku, and your GitHub Projects board.

