class PrototypesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to(root_path)
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    query = "SELECT * FROM comments WHERE prototype_id = #{@prototype.id}"
    @comments = Comment.find_by_sql(query)
  end

  def edit
    redirect_to(:index) unless user_signed_in?
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to(prototype_path(params[:id]))
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    render :index if prototype.destroy
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
end
