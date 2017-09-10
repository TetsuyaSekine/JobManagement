class CodeMstsController < ApplicationController
  before_action :code_mst_find, only: [:show,:edit,:update,:destroy]

  def index
    @code_msts = CodeMst.all.page(params[:page])
  end

  def new
    @code_mst = CodeMst.new

    logger.debug @code_mst.inspect
  end

  def show
  end

  def create
    @code_mst = CodeMst.new(code_mst_params)
    if @code_mst.invalid?
      render :new, flash: {error: @code_mst.errors.full_messages}
    else
      if @code_mst.save
        redirect_to code_msts_path, success: 'コードマスタ登録が完了しました。'
      else
        redirect_to code_msts_new_path, danger: 'コードマスタ登録ができませんでした。'
      end
    end
  end

  def edit
  end

  def update
    if @code_mst.update(code_mst_params)

      if @code_mst.invalid?
        logger.debug @code_mst.errors.full_messages.inspect
        render :edit, flash: {error: @code_mst.errors.full_messages}
      else
        redirect_to code_msts_path, success: 'コードマスタの更新が完了しました。'
      end
    else
      redirect_to code_msts_edit_path, danger: 'コードマスタ更新ができませんでした。'
    end
  end

  def destroy
    if @code_mst.destroy
      redirect_to code_msts_path, success: 'コードマスタの削除が完了しました。'
    else
      redirect_to code_msts_path, danger: 'コードマスタ削除ができませんでした。'
    end
  end

  private

    def code_mst_find
      @code_mst = CodeMst.find(params[:id])
    end

    def code_mst_params
      params.require(:code_mst).permit(:category_cd,:category_name,:contents_cd,
      :contents,:del_flg,:remark)
    end

end
