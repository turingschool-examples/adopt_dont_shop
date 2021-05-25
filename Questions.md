**MVC Principals**
Admin_Applications_Controller#update
  should my conditional logic and updating live here?
    -is this in the right controller? Could it be in ApplicationPet or Application?
    -should it be in a model or controller?
  I only put it where it is because I'm arriving here from the admin_applications#show page

**Getting Data Using Active Record & SQL**
Is it possible for me to get actual data returned rather than an active record association or PJ Object.
  Example 1:
    Shelter - sql_by_name
  Example 2:
    ApplicationPet - find_record

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




**Autofill on Error**
Error messages - have both javascript required and flash messages,
but following steps outlined in class today did not succeed in auto-filling my form.
Remember to replace required on zip code!

Is it standard practice to name all controllers/routes plural? I.E. admins vs admin