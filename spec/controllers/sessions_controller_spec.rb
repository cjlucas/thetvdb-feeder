require 'rails_helper'

describe SessionsController, :type => :controller do
  context 'when accessing sessions#index' do
    it 'should return a valid page' do
      get :index
      expect(response).to have_http_status(200)
    end
  end

  context 'when accessing sessions#login with a non-existing user' do
    it 'should redirect to users#new' do
      get :login, id: 'fake id'
      expect(response).to redirect_to(controller: 'users',
                                      action: 'new',
                                      id: 'fake id')
    end
  end

  context 'when accessing sessions#login with an existing user' do
    it 'should redirect to root' do
      user = valid_user
      user.save

      get :login, id: user.tvdb_id
      expect(response).to redirect_to(root_path)
    end
  end

  context 'when accessing sessions#logout' do
    it 'should destroy the session and redirect to root' do
      session[:uuid] = '0a9988b3-8c46-407c-bf67-7596e2d50100'

      get :logout
      expect(session).to be_empty
      expect(response).to redirect_to(root_path)
    end
  end
end
