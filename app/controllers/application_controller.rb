class ApplicationController < ActionController::API
    def encode_token(payload)
        JWT.encode(payload, 'secret1')
    end
end
