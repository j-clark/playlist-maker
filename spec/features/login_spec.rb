describe 'Authentication' do
  before do
    visit '/'
  end

  describe 'signing in' do
    before do
      sign_in_as(user)
    end

    context 'when the user has an account' do
      let(:email) { 'jimbob@gmail.com' }
      let(:user) { FactoryGirl.create(:user, email: email) }

      it 'redirects to the home page' do
        expect(page).to have_content('This is home')
      end

      it 'displays the user\'s name' do
        expect(page).to have_content("Hello, #{email}")
      end
    end

    context 'when the user does not have an account' do
      let(:user) { double(:non_user, email: 'dude@guy.com', password: 'dragon') }

      it 'rejects the authentication attempt' do
        expect(page).to have_content('Invalid email or password')
      end
    end
  end

  describe 'signing out' do
    before do
      sign_in_as(FactoryGirl.create(:user))
      sign_out
    end

    it 'displays a helpful message' do
      expect(page).to have_content('Signed out successfully')
    end

    it 'redirects to the home page' do
      expect(page).to have_content('This is home')
    end

    it 'allows the user to login again' do
      expect(page).to have_content('Sign in')
    end

    def sign_out
      click_on 'Sign out'
    end
  end

  describe 'creating an account' do
    before do
      click_on 'Sign up!'
    end

    it 'requires all fields' do
      click_on 'Sign up'
      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password can't be blank")

      fill_in 'Email', with: 'bobby_sue@gmail.com'
      click_on 'Sign up'
      expect(page).to have_content("Password can't be blank")


      fill_in 'Password', with: 'dragon123'
      click_on 'Sign up'
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    it 'logs the user in after creation' do
      fill_in 'Email', with: 'bobby_sue@gmail.com'
      fill_in 'Password', with: 'dragon123'
      fill_in 'Password confirmation', with: 'dragon123'

      click_on 'Sign up'

      expect(page).to have_content('Hello, bobby_sue@gmail.com')
    end
  end

  def sign_in_as(user)
    click_on 'Sign in'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password

    click_on 'Log in'
  end
end


