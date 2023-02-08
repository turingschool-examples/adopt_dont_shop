# Evaluation

For the project eval, you should prepare a video presentation that clearly demonstrates the presentation points listed below. To create your video presentation, we suggest hopping on a zoom call with your partner, sharing your screen, and recording your meeting as you go through the presentation points. Then, upload that video to either your Google Drive or YouTube. Please include the link to your video in your submission.

### Presentation Points

**1. User Story Presentation**

Each partner should present 1 user story. If your project has 2 partners, your team should present a total of 2 stories. Try to pick user stories that you think will deliver the highest value in terms of feedback from the instructor. 

For each story:

* Demonstrate the user story on Heroku (or localhost if the feature is not functional in Production)
* Show the test(s) for the user story
* Show all code that implements the user story

**2. Student Questions and Requested Feedback**

In your presentation, please also include any questions or areas of your code where you would like to receive instructor feedback.

___

## Rubric

| | **Feature Completeness** | **Rails** | **ActiveRecord** | **Testing and Debugging** | **Project Management** |
| --- | --- | --- | --- | --- | --- |
| **Exceptional**  | All User Stories 100% complete including all sad paths and edge cases, and some extension work completed | Students implement strategies not discussed in class and can defend their design decisions | At least one ActiveRecord extension is complete | 100% coverage for features and models. A gem that enhances testing effectiveness is implemented (orderly, factorybot, faker, etc). Students can point to multiple examples of edge case testing that are not included in the user stories | GitHub Project board is fully up to date in all checkins and the evaluation. Students create custom cards on the project board to track tasks in addition to user stories.
| **Meets Expectations** | All stories in the "Deploy", "Apply for Pet(s)", "Database Logic Part 1", and "Approving Applications" sections are completed | Students use the principles of MVC to effectively organize code with only 1 - 2 infractions. Action View helpers are used to create forms, links, and buttons. Routes and Actions mostly follow RESTful conventions, and student can defend any non restful routes. At least one partial is created and included in at least two different views. Models include validations. Flash messages are used. | ActiveRecord helpers are utilized whenever possible. ActiveRecord is used in a clear and effective way to read/write data. No Ruby is used to process data. All queries functional and accurately implemented. | 100% coverage for models. 98% coverage for features. Tests are well written and meaningful. Tests utilize within blocks to target specific areas of a page | Student uses GitHub Project to track all user stories. Project board is mostly up to date in all checkins. Project board is fully up to date at the evaluation |
| **Approaching Expectations** | All stories in the "Deploy", "Apply for Pet(s)", and "Database Logic Part 1" sections are completed |  Students use the principles of MVC to effectively organize code, but may have more than 2 infractions. Some routes and actions are not restful, and student cannot defend those decisions. Project may fail to include one of the following: a partial that is included in at least two different views, model validations, or use of flash messages. | Ruby is used to process data that could use ActiveRecord instead. Some instances where ActiveRecord helpers are not utilized. Some queries not accurately implemented. | Feature test coverage between 90% and 98%, or model test coverage below 100%, or tests are not meaningfully written or have an unclear objective, or tests do not utilize within blocks | GitHub Project board is not utilized during one of the checkins. Project board is not fully up to date during evaluation.
| **Below Expectations** | Students fail to complete "Database Logic Part 1" section | Project fails to include two out of the following: a partial that is included in at least two different views, model validations, or use of flash messages | Ruby is used to process data more often than ActiveRecord. Many cases where ActiveRecord helpers are not utilized. | Below 90% coverage for either features or models. | GitHub projects is not utilized

