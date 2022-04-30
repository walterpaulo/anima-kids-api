
SECRET_KEY = "123123"

class JsonWebToken
  def self.encode(dado, exp)
    dado[:exp] = exp.to_i
    JWT.encode(dado, SECRET_KEY)
  end

  def self.decode(dado)
    decoded = JWT.decode(dado, SECRET_KEY, false)[0]
    HashWithIndifferentAccess.new(decoded)
  end
end