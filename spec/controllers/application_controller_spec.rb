require 'rails_helper'

describe ApplicationController, :type => :controller do
  context 'when accessing application#index' do
    it 'should redirect to login if no cookies set' do
      get :index
      expect(response).to redirect_to(login_path)
    end

    it 'should redirect to login if cookies are set, but user doesnt exist' do
      session[:uuid] = 'some uuid'

      get :index
      expect(response).to redirect_to(login_path)
    end

    it 'should redirect to dashboard if cookies set and user exists' do
      uuid = '0a9988b3-8c46-407c-bf67-7596e2d50100'
      user = valid_user(uuid: uuid).save
      session[:uuid] = uuid

      get :index
      expect(response).to redirect_to(dashboard_path)
    end
  end
end
