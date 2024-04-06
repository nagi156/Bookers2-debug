class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:update, :edit]
  
  def new
    @group = Group.new
  end
  
  def index
    @book = Book.new
    @group = Group.all
  end
  
  def show
    @group = Group.find(params[:id])
    @book = Book.new
  end
  
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @grooup.save
      redirect_to groups_path
    else
      render :
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
end
