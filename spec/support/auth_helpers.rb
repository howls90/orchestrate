module AuthHelpers
  def auth
    @user = User.create(email: "oocran@oocran.es", password: "oocran", password_confirmation: "oocran")

    post '/auth', params: {email: @user.email, password: 'oocran'}
    @jwt = JSON.parse(response.body)['auth_token']
  end
end
