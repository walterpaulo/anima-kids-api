class ApplicationController < ActionController::API
  
  JWT_SECRET = ENV['JWT_SECRET']
  def encode_token(payload)
    JWT.encode(payload, JWT_SECRET)
  end

  def decode_token
    auth_header = request.headers['Authorization']
    if auth_header
      token = auth_header.split(' ').last
      begin
        JWT.decode(token, JWT_SECRET, true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def authorized_user
    decoded_token = decode_token
    if decoded_token
      user_id = decode_token[0]['user_id']
      @user = Usuario.find(user_id)
    end
  end

  def authorized
    render json: { message: 'Você precisa estar logado' }, status: :unauthorized unless authorized_user
  end
end
