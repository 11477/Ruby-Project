class RelationsController < ApplicationController
  before_action :set_relation, only: %i[ show edit update destroy ]

  # GET /relations or /relations.json
  def index
    @relations = Relation.all
  end

  # GET /relations/1 or /relations/1.json
  def show
  end

  # GET /relations/new
  def new
    @relation = Relation.new
  end

  # GET /relations/1/edit
  def edit
  end

  def follow
  end

  def do_follow
    @program=Program.find(params[:program_id])
    @relation = Relation.new(relation_params)
    @relation.program=@program
    @user=current_user
    @relation.user=@user

    if @relation.save
      format.html { redirect_to @program, notice: "关注成功" }
    else
      format.html { redirect_to @program, notice: "关注失败！" }
    end
  end

  # POST /relations or /relations.json
  def create
    @program=Program.find(params[:program_id])
    @user=current_user
    relation = Relation.where(user: @user,program: @program).first
    @relation = Relation.new(user: @user,program: @program)

    respond_to do |format|
      if relation
          @relation = Relation.where(user: @user,program: @program).first
          @relation.destroy
          format.html { redirect_to @program, notice: "取消关注成功" }
          format.json { head :no_content }
      else
        if @relation.save
          format.html { redirect_to @program, notice: "关注成功" }
          format.json { render :show, status: :created, location: @relation }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @relation.errors, status: :unprocessable_entity }
        end
      end

    end
  end

  # PATCH/PUT /relations/1 or /relations/1.json
  def update
    respond_to do |format|
      if @relation.update(relation_params)
        format.html { redirect_to relation_url(@relation), notice: "Relation was successfully updated." }
        format.json { render :show, status: :ok, location: @relation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @relation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /relations/1 or /relations/1.json
  def destroy
    @relation.destroy

    respond_to do |format|
      format.html { redirect_to @program, notice: "取消关注成功" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_relation
      @relation = Relation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def relation_params
      params.require(:relation).permit(:user_id, :program_id)
    end
end
