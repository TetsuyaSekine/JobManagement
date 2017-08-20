class TantosController < ApplicationController
  before_action :tanto_find, only: [:show,:edit,:update,:destroy]

  def index
    @tantos = Tanto.all
  end

  def new
    @tanto = Tanto.new
  end

  def show
  end

  def create
    @tanto = Tanto.new(tanto_params)
    if @tanto.invalid?
      render :new, flash: {error: @tanto.errors.full_messages}
    else
      if @tanto.save
        redirect_to tantos_path, success: '担当者情報を登録しました。'
      else
        redirect_to tantos_new_path, danger: '担当者情報の登録に失敗しました。'
      end
    end
  end

  def edit
  end

  def update
    if @tanto.invalid?
      render :edit, flash: {errors: @tanto.errors.full_messages}
    else
      if @tanto.update(tanto_params)
        redirect_to tantos_path, success: '担当者情報を更新しました。'
      else
        redirect_to tantos_edit_path, danger: '担当者情報の更新に失敗しました。'
      end
    end
  end

  def destroy
    if @tanto.destroy
      redirect_to tantos_path, success: '担当者情報を削除しました。'
    else
      redirect_to tantos_path, danger: '担当者情報の削除に失敗しました。'
    end
  end

  private
    def tanto_find
      @tanto = Tanto.find(params[:id])
    end

    def tanto_params
      params.require(:tanto).permit(:tanto_name,:del_flg)
    end

end
