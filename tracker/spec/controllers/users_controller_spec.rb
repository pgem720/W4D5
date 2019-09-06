require "rails_helper"


RSpec.describe UsersController, type: :controller do 
  
  describe 'GET #new' do  
    it 'brings up the form to create a user' do
      allow(subject).to receive(:logged_in?).and_return(true) 
      get(:new) 
      expect(response).to render_template(:new) 
    end
    
  end


  describe 'POST #create' do 
    before :each do 
      create(:user) 
      allow(subject).to receive(:current_user).and_return(user.last) 
    end
    let(:valid_params) { {user: {username: 'jon', password: 'starwars'}} }
    let(:invalid_params) { {user: {not_username: 'not_jon', not_password: 'bad_password'}} }

    context 'with valid params' do
      it 'creates the user' do
        post(:create, params:valid_params)
        expect(user.last.username).to eq('jon')
        expect(user.last.password).to eq('starwars')
      end
    end
    #add redirect

    context 'with invalid params' do
      it 'creates the user' do
        post(:create, params:invalid_params)
        expect(user.last.not_username).to eq('not_jon')
        expect(user.last.not_password).to eq('bad_password')
      end
    end
    #add error

  end
end
