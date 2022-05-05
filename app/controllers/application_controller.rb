class ApplicationController < ActionController::API
  def encode_token(payload)
    JWT.encode(payload, 'secret1')
  end

  def decode_token
    auth_header = request.headers['Authorization']
    if auth_header
      token = auth_header.split(' ').last
      begin
        JWT.decode(token, 'secret1', true, algorithm: 'HS256')
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
