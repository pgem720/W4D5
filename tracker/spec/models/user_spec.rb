require "rails_helper" 

RSpec.describe User, type: :model do 
  it { should validate_presence_of(:username) } 
  it { should validate_presence_of(:password_digest) } 
  it { should validate_presence_of(:session_token) } 
  it { should validate_length_of(:password).is_at_least(6) } 

  describe 'uniqueness' do 
    before :each do 
      create(:user) 
    end
    it { should validate_uniqueness_of(:username) } 
    it { should validate_uniqueness_of(:session_token) }
    
  end

  #public_methods 

  describe 'is_password?' do
    let!(:user) {create(:user)}

    context 'invalid password' do
      it 'should return false' do
        expect(user.is_password?('badpassword')).to be false
      end
    end

    context 'valid password' do
      it 'should return true' do
        expect(user.is_password?('starwars')).to be true
      end
    end
  end
  
  describe 'find by credentials' do
    let!(:user) {create(:user, username: 'jon' , password: 'starwars')}
    it 'finds user by username and password' do
      expect(user.username).to eq('jon')
      expect(user.password).to eq('starwars')
    end
  end

  describe 'generate session token' do
    it 'generates a session token' do
      session_token_1 = User.generate_session_token
      session_token_2 = User.generate_session_token

      expect(session_token_1).not_to eq(session_token_2) 
    end
  end

  describe 'password=' do 
    subject(:test) {User.new(username: 'test' , password: 'starwars') } 
    it 'sets the password_digest' do 
      # expect(test.password_digest).to be nil 
      # test.password=('starwars') 
      expect(test.password_digest).not_to be nil 
    end
  end

  describe 'ensure session token' do
    let!(:user) {create(:user)}
    it 'ensures a session token' do 
      user.ensure_session_token
      expect(user.session_token).not_to be nil
    end
  end

  describe 'reset session token' do
    let!(:user) { create(:user) }
    it 'resets session token' do 
      old_session_token = user.session_token 
      user.reset_session_token!
      expect(user.session_token).not_to eq(old_session_token) 
    end
  end

end
