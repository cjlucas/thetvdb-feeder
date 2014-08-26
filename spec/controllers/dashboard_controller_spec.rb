require 'rails_helper'

describe DashboardController, :type => :controller do
  context 'when accessing dashboard#index' do
    it 'should redirect to login if user is not logged in' do
      get :index
      expect(response).to redirect_to(login_path)
    end

    it 'should redirect to login if session exists but cant be found in db' do
      session[:uuid] = '85d5ff0e-1748-45e7-9017-7a9c909e6c03'
      get :index
      expect(response).to redirect_to(login_path)
    end

    it 'should respond with status code 200 if user is logged in' do
      uuid = '85d5ff0e-1748-45e7-9017-7a9c909e6c03'
      user = valid_user(uuid: uuid)
      user.save
      session[:uuid] = '85d5ff0e-1748-45e7-9017-7a9c909e6c03'

      expect(response).to have_http_status(200)
    end
  end
end
