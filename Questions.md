**MVC Principals**
Admin_Applications_Controller#update
  should my conditional logic and updating live here?
    -is this in the right controller? Could it be in ApplicationPet or Application?
    -should it be in a model or controller?
  I only put it where it is because I'm arriving here from the admin_applications#show page
  # It is OK to have a controller doing things in other models*
Pet Model
  Where is it proper for methods to live? Some sanity checks:
    #filter_by_pending_apps
    #application_status
    #approved_on_other_apps
  # It is OK, within reason, to have a model talk to other models

**Getting Data Using Active Record & SQL**
Is it possible for me to get actual data returned rather than an active record association or PJ Object.
  Example 1:
    Shelter - sql_by_name
  Example 2:
    ApplicationPet - find_record

**Partials**
Is there a best practice for naming convention?
Can I put them in their own views folder?
Will we cover best practices for testing these?

**Conditional Logic in HTML Files**
How much conditional logic is too much?
  Example: application_pet_adopting

**Resources**
What syntax is used for compound resources? Like 'admin/shelters'

**Controller Naming**
I added an "admins" controller so that I could have an admins#index page. Does this need to be plural? Is that a thing?

**AR Joins vs helper methods**
What is better, trying to cobble together complex joins, or using multiple helper methods?
If joins are better, how would I accomplish that in this example?
  AR Example 1:
    Pet.filter_by_pending_apps
    ApplicationPet.filter_by_pending_apps
    Application.filter_by_pending
  SQL Equivalent:
    Select distinct a.*
    From shelters a,
    pets b,
    application_pets c,
    applications d

    Where a.id = b.shelter_id
    and b.id = c.pet_id
    and c.application_id = d.id
    and d.status = 'Pending'
  # Try to do this as a AR statement inside Pet. Brian prefers optimization over sticking with OOP principals, and one big query is better because it only makes one database call. Also, don't fall into the temptation to do this in raw SQL - this is a learning experience.

**Seed Issues**
Lines 9-12 of my seed file through errors, and so I have to comment out my seeds to stop my DB from constantly duplicating records. Why is it failing?

**Testing**
I find managing the same hooks over multiple spec files to be exhausting. Can I put it in a spec_helper? If no, why not?

Also, I am having issues testing which appear related to order of operations.
  Example - admin_applications/show_spec.rb

**Autofill on Error**
Error messages - have both javascript required and flash messages,
but following steps outlined in class today did not succeed in auto-filling my form.
Remember to replace required on zip code!

Is it standard practice to name all controllers/routes plural? I.E. admins vs admin