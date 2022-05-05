class LoginController < ApplicationController
  def index
    @usuarios = Usuario.last

    render json: @usarios
  end

  def logar
    @user = Usuario.find_by_email(params[:email])
    if @user && @user.validar_password == params[:password]
      token = encode_token({ user_id: @user.id})
      user_tdo = UserTdo.new(name: @user.name, email: @user.email)
      render json: { user: user_tdo, token: token }, status: :ok
    else
      render json: :errors, status: 401
    end
  end

  private

  def params_login
    email = params['email']
    password = params['password']
    [email, password]
  end

  def mgs_error_login
    render json: 'Email ou senha inválidos', status: :unprocessable_entity
  end
end