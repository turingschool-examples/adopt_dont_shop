RSpec.describe 'The partial form for applications,', type: :view do
  describe 'fields,' do
    before :each do
      render partial: 'applications/form', locals: { application: Application.new }
    end
...

within 'form' do

blah

visit new_application_path