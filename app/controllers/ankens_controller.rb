class AnkensController < ApplicationController
  before_action :anken_find, only: [:show,:edit,:update,:destroy]

  def index
    @ankens = Anken.find_by_sql(
    "select a.id,c.customer,a.anken_name,a.anken_summary,m.contents,t.tanto_name,a.anken_ball_cd,a.last_update,
    a.remark,a.created_at,a.updated_at from ankens a LEFT OUTER JOIN customers c ON a.customer_id = c.id
    LEFT OUTER JOIN tantos t ON a.tanto_id = t.id
    LEFT OUTER JOIN code_msts m ON a.anken_status_cd = m.contents_cd
    where c.del_flg=0 and t.del_flg = 0 and m.category_cd = '0001' and m.del_flg = 0")

    logger.debug @ankens.inspect
  end

  def new
    @anken = Anken.new

    #セレクトボックス用の値取得
    getCustomers_for_options
    getTantos_for_options
    getCodemst_for_options('0001')
  end

  def show
  end

  def edit

    #セレクトボックス用の値取得
    getCustomers_for_options
    getTantos_for_options
    getCodemst_for_options('0001')
  end

  def create
    @anken = Anken.new(anken_params)
    setLastUpdateUser

    #validationチェック
    if @anken.invalid?
      getCustomers_for_options
      getTantos_for_options
      getCodemst_for_options('0001')
      render :new, flash: {errors: @anken.errors.full_messages}
    else
      if @anken.save
        redirect_to ankens_path, success: '案件情報が登録されました。'
      else
        redirect_to ankens_new_path, danger: '案件情報の作成に失敗しました。'
      end
    end
  end

  def update
    #最終更新者をログインユーザーにセット
    setLastUpdateUser
    if @anken.update(anken_params)
      redirect_to ankens_path, success: '案件情報の更新が完了しました。'
    else
      redirect_to ankens_edit_path, danger: '案件の更新に失敗しました。'
    end
  end

  def destroy
    #最終更新者をログインユーザーにセット
    setLastUpdateUser
    if @anken.destroy
      redirect_to ankens_path, success: '案件情報の削除が完了しました。'
    else
      redirect_to ankens_path, danger: '案件の削除に失敗しました。'
    end
  end

  private
    #顧客情報を取得(有効なレコードのみ)
    def getCustomers_for_options
      @customers_for_options = Customer.where(del_flg: 0)
    end

    #担当者情報を取得(有効なレコードのみ)
    def getTantos_for_options
      @tantos_for_options = Tanto.where(del_flg: 0)
    end

    #コードマスタ情報と取得
    def getCodemst_for_options(categoryCd)
      @code_msts_for_options = CodeMst.where(category_cd: categoryCd).where(del_flg: 0)
    end

    def anken_find
      @anken = Anken.find(params[:id])
    end

    def anken_params
      params.require(:anken).permit(:customer_id,:anken_name,:anken_summary,
      :anken_status_cd,:tanto_id,:anken_ball_cd,:remark)
    end

    def setLastUpdateUser
      @anken.last_update = current_user.username
    end
end
