require 'rails_helper'

RSpec.describe 'Some essential functions', type: :system do
  describe 'posts guide page' do
    it 'shows the right content' do
      create(:post, category: 'guide', title: 'A guide to test')
      create(:post, category: 'interview', title: 'An interview to test')
      
      
      visit posts_guides_path 
      expect(page).to have_content('A guide to test')
      expect(page).not_to have_content('An interview to test')
    end
  end

  describe 'signing up' do
    it 'signs up a new person succesfully' do
      visit new_user_registration_path
      fill_in 'First name', with: 'Test'
      fill_in 'Last name', with: 'User'
      fill_in 'Email', with: 'test@gmail.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'

      expect(User.last.email).to eq('test@gmail.com')
    end

    it 'gives an error if some information is missing' do
      visit new_user_registration_path
      fill_in 'Email', with: 'failing_test@gmail.com'
      fill_in 'Password', with: 'password'
      fill_in 'Password confirmation', with: 'password'
      click_button 'Sign up'

      expect(User.last).to be_nil
      expect(page).to have_content('error')
    end

  end
  
  describe 'logging in' do
    before(:each) do
      create(:user, email: 'testing@gmail.com', password: 'Testing') 
    end

    it 'logs in successfully' do
      visit new_user_session_path
      fill_in 'Email', with: 'testing@gmail.com'
      fill_in 'Password', with: 'Testing'
      click_button 'Log in'
      expect(page).to have_content('successfully')
    end

    it 'gives an error when logging in unsuccesfully' do
      visit new_user_session_path
      fill_in 'Email', with: 'failing_test@gmail.com'
      fill_in 'Password', with: 'Testing'
      click_button 'Log in'
      expect(page).to have_content('Invalid')
    end
  end
  
  describe 'when logged in' do
    it 'renders the link to the new_post_path for an admin user' do
      login_as(create :admin)
      visit root_path
      expect(page).to have_link('New post')
    end

    it 'does not render the link to the new_post_path for a non-admin user' do
      login_as(create :user)
      visit root_path
      expect(page).not_to have_link('New post')
    end
  end

  describe 'when making a new post' do
    it 'works with valid inputs' do
      visit new_post_path
      fill_in 'Title', with: 'A title'
      find("trix-editor").set("new value goes here")
      find('#post_category').find(:xpath, 'option[1]').select_option
      page.attach_file('post_cover_photo', 'app/assets/images/dylan.jpg')
      click_button 'Create Post'

      expect(page).to have_content('succesfully')
    end
  end

  describe 'saving a post' do
    it 'works when no posts are saved' do
      login_as(create :user)
      visit saved_posts_path

      expect(page).to have_content("There is nothing to display yet.")
    end

    it 'displays a saved post and links to the post page' do
      user = create(:user)
      login_as(user)
      saved_post = create(:saved_post, user: user)
      visit saved_posts_path

      click_link("#{saved_post.post.title}")

      expect(page).to have_css('.show-body')
    end

    it 'after saving a post and then unsaving it, it is not visible anymore' do
      user = create(:user)
      login_as(user)
      saved_post = create(:saved_post, user: user)
      visit post_path(saved_post.post)

      click_link("Unsave post")
      click_link("Saved Posts")

      sleep 2

      expect(page).not_to have_content("#{saved_post.post.title}")
    end
  end
end