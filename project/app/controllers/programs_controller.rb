class ProgramsController < ApplicationController
  before_action :set_program, only: %i[ show edit update destroy ]
  before_action :authenticate, only: %i[ show edit update destroy new ]
  before_action :is_teacher, only: %i[new edit update]
  # GET /programs or /programs.json
  def index
    @programs = Program.all
  end

  # GET /programs/1 or /programs/1.json
  def show
  end

  # GET /programs/new
  def new
    @program = Program.new
  end

  def search
    @keyword = params[:keyword]
    @programs = Program.where("title LIKE ?", "%#{@keyword}%").all
  end

  # GET /programs/1/edit
  def edit
  end

  # POST /programs or /programs.json
  def create
    @user=current_user
    @program = Program.new(program_params)
    @program.user=@user

    respond_to do |format|
      if @program.save
        format.html { redirect_to program_url(@program), notice: "项目创建成功" }
        format.json { render :show, status: :created, location: @program }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /programs/1 or /programs/1.json
  def update
    respond_to do |format|
      if @program.update(program_params)
        format.html { redirect_to program_url(@program), notice: "项目信息更新成功" }
        format.json { render :show, status: :ok, location: @program }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programs/1 or /programs/1.json
  def destroy
    @program.destroy

    respond_to do |format|
      format.html { redirect_to programs_url, notice: "项目已经成功删除" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program
      @program = Program.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def program_params
      params.require(:program).permit(:title, :info)
    end

  def authenticate
    redirect_to login_users_url, alert: '请先登录！' unless current_user
  end

  def is_teacher
    redirect_to login_users_url, alert: '您不是老师！' unless current_user.Ident=="teacher"
  end

end
