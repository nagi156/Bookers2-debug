class UsersController < ApplicationController
before_action :ensure_correct_user, only: [:update, :edit]
  def show
    @user = User.find(params[:id])
    # roomがcreateされた時に現在ログインしているユーザーと、
    # チャット相手になるユーザーの両方をEntriseテーブルから取得する。
    @current_entry = Entry.where(user_id: current_user.id)
    @another_entry = Entry.where(user_id: @user.id)
    # ログインしていないユーザーという条件にして
    # entryテーブル内にroom_idが存在するか確認
    unless @user.id == current_user.id
      @current_entry.each do |current|
        @another_entry.each do |another|
          if current.room_id == another.room_id　#同じroom_idが存在する場合
            @is_room = true #既にroomがあるということなのでroom_idの変数とroomが存在するかどうかの条件であるis_roomを渡す。
            @room_id = current.room_id
          end
        end
      end
      unless @is_room　#roomが存在しなければ新しく作る
        @room = Room.new
        @entry = Entry.new
      end
    end
    
    @books = @user.books
    @book = Book.new
    @show_favorite = false
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: "You have updated user successfully."
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
