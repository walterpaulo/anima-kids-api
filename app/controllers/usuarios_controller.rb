class UsuariosController < ApplicationController
  before_action :set_usuario, only: %i[ show update destroy ]
  before_action :authorized, only: %i[ show create update destroy]

  # GET /usuarios
  def index
    render json: "API - ", status: :ok
  end

  # GET /usuarios/1
  def show
    user = UserTdo.new(id: @usuario.id, name: @usuario.name, email: @usuario.email)
    render json: user
  end

  # POST /usuarios
  def create
    @user = Usuario.new(usuario_params)

    if @user.save
      token = encode_token({ user_id: @user.id })
      user_tdo = UserTdo.new(id: @user.id, name: @user.name, email: @user.email)
      render json: { user: user_tdo, token: token }, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /usuarios/1
  def update
    if @usuario.update(usuario_params)
      render json: @usuario
    else
      render json: @usuario.errors, status: :unprocessable_entity
    end
  end

  # DELETE /usuarios/1
  def destroy
    @usuario.destroy
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_usuario
    @usuario = Usuario.find_by_id(params[:id])
    return render :not_found, :status => :not_found if @usuario.nil?
  end

  # Only allow a list of trusted parameters through.
  def usuario_params
    params.require(:usuario).permit(:name, :email, :type, :password)
  end
end
