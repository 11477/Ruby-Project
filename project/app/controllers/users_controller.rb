class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
  end

  # GET /users/1 or /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def following
    @title = "Following"
    @user = current_user
    @programs = Program.where(program: Relation.where(user: @user).all).all
    render 'show_follow'
  end

  def login
  end

  def do_login
    user = User.where(num: params[:num], password: params[:password]).first
    if user
      session[:current_userid] = user.id
      redirect_to programs_url, notice: '您已经成功登录'
    else
      redirect_to login_users_url, notice: '密码或学工号错误！'
    end
  end

  def logout
    session.delete(:current_userid)
    redirect_to login_users_url,  notice: '退出登录成功'
  end

  def register
  end

  def do_register
    password=params[:password]
    password_confirm=params[:password_confirmation]
    user1 = User.where(num: params[:num]).first
    if password != password_confirm
      redirect_to register_users_url, alert: '两次密码不一致！'
    elsif user1
      redirect_to register_users_url, alert: '学工号已存在！'
    else
      @user = User.new(username: params[:username], password: params[:password],num: params[:num],Ident: params[:Ident])
      if @user.save
        redirect_to login_users_url, notice: '用户注册成功，现在请登录'
      else
        redirect_to register_users_url, notice: '其它错误'
      end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :password, :Ident,:num,:password_confirmation)
    end
end
