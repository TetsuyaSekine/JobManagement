class AnkensController < ApplicationController
  before_action :anken_find, only: [:edit,:update,:destroy]
  before_action :getCustomers_for_options, only: [:index,:new,:edit]
  before_action :getTantos_for_options, only: [:index,:new,:edit]
  before_action -> {getCodemst_for_options('0001')}, only: [:index,:new,:edit]
  before_action :getSections_for_options, only: [:index,:new,:edit]
  before_action :comment_find, only: [:comment_edit,:comment_update,:comment_destroy]
  helper_method :sort_column, :sort_direction

  def index

    @anken = Anken.new
    #検索条件用オブジェクト
    @anken_search = Anken.new
    anken_search = @anken_search

    #POSTされた場合
    if params[:anken].present?
      @anken.anken_name = params[:anken][:anken_name]
      @anken.anken_summary = params[:anken][:anken_summary]
      @anken.customer_id = params[:anken][:customer_id]
      @anken.tanto_id = params[:anken][:tanto_id]
      if params[:anken][:anken_status_cd].present?
        @anken.anken_status_cd = params[:anken][:anken_status_cd].map(&:to_i)
      else
        @anken.anken_status_cd = nil
      end
      if params[:anken][:section_cd].present?
        @anken.section_cd = params[:anken][:section_cd]
      else
        @anken.section_cd = nil
      end

      @ankens = Anken.get_by_section_cd(params[:anken][:section_cd]).get_by_name(params[:anken][:anken_name])
      .get_by_summary(params[:anken][:anken_summary]).get_by_customer_id(params[:anken][:customer_id])
      .get_by_tanto_id(params[:anken][:tanto_id]).get_by_anken_status_cd(params[:anken][:anken_status_cd]).order(sort_column + ' ' + sort_direction).page(params[:page])

      #検索条件をセッションに格納する
      session[:section_cd] = params[:anken][:section_cd]
      session[:anken_name] = params[:anken][:anken_name]
      session[:anken_summary] = params[:anken][:anken_summary]
      session[:customer_id] = params[:anken][:customer_id]
      session[:tanto_id] = params[:anken][:tanto_id]
      session[:anken_status_cd] = params[:anken][:anken_status_cd]


      #検索条件を、画面の検索フィールドに戻す
      @anken_search.section_cd_search = params[:anken][:section_cd]
      @anken_search.anken_name = params[:anken][:anken_name]
      @anken_search.anken_summary = params[:anken][:anken_summary]
      @anken_search.customer_id = params[:anken][:customer_id]
      @anken_search.tanto_id = params[:anken][:tanto_id]
      @anken_search.anken_status_cd_search = params[:anken][:anken_status_cd]
    #GETされた場合
    else
      #検索条件が存在した場合は、検索条件を指定した案件検索を行う。
      getSearchCondition(anken_search)

      #初期表示するときに、ログインユーザーの部署の案件で絞られる
      if anken_search.section_cd_search.blank?
        arr = Array.new
        anken_search.section_cd_search = arr.push(current_user.section_id)

      end

      if anken_search.present?
        @ankens = Anken.get_by_section_cd(anken_search.section_cd_search).get_by_name(anken_search.anken_name)
        .get_by_summary(anken_search.anken_summary).get_by_customer_id(anken_search.customer_id)
        .get_by_tanto_id(anken_search.tanto_id).get_by_anken_status_cd(anken_search.anken_status_cd_search).order(sort_column + ' ' + sort_direction).page(params[:page])

      else
        @ankens = Anken.includes([:customer,:tanto,:code_mst,:section])
          .where(sections: {del_flg: 0},customers: {del_flg: 0},tantos: {del_flg: 0},code_msts: {category_cd: '0001',del_flg: 0}).order(sort_column + ' ' + sort_direction).page(params[:page])
      end
    end
  end

  def report
    @ankens = Anken.includes([:customer,:tanto,:code_mst,:section])
      .where(sections: {del_flg: 0},customers: {del_flg: 0},tantos: {del_flg: 0},code_msts: {category_cd: '0001',del_flg: 0})

    respond_to do |format|
      format.xlsx do
        response.headers['Content-Disposition'] = "attachment; filename=案件一覧.xlsx"
      end
    end
  end

  def new
    @anken = Anken.new
  end

  def show
    @anken = Anken.includes([:customer,:tanto,:code_mst,:section])
      .where(ankens: {id: params[:id]},sections: {del_flg: 0}, customers: {del_flg: 0},tantos: {del_flg: 0},
        code_msts: {category_cd: '0001',del_flg: 0})
  end

  def edit
  end

  def create
    @anken = Anken.new(anken_params)
    #最終更新者をログインユーザーにセット
    setLastUpdateUser
    #validationチェック
    if @anken.invalid?
      getCustomers_for_options
      getTantos_for_options
      getCodemst_for_options('0001')
      getSections_for_options
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

  def comment
    @anken = Anken.find(params[:anken_id])
    @comment = Comment.new
    @title = "コメント登録"
  end

  def comment_show
    @anken = Anken.find(params[:id])
  end

  def comment_edit
    @anken = Anken.find(params[:anken_id])
    @comment = Comment.find(params[:id])
    @title = "コメント更新"
  end

  def comment_create
    @comment = Comment.new(comment_params)
    @comment.anken_id = params[:id]
    @comment.last_update = current_user.username
    if @comment.invalid?
      render :comment, flash: {errors: @comment.errors.full_messages}
    else
      if @comment.save
        @anken_by_comment = Anken.find(@comment.anken_id)
        @anken_by_comment.update_attributes(updated_at: Time.zone.now)
        redirect_to ankens_path, success: 'コメントが登録されました。'
      else
        redirect_to comments_path, danger: 'コメントの作成に失敗しました。'
      end
    end
  end

  def comment_update
    @comment.last_update = current_user.username
    if @comment.update(comment_params)
      @anken_by_comment = Anken.find(@comment.anken_id)
      @anken_by_comment.update_attributes(updated_at: Time.zone.now)
      redirect_to ankens_path, success: 'コメント更新が完了しました。'
    else
      redirect_to comments_path, danger: 'コメントの更新に失敗しました。'
    end
  end

  def comment_destroy
    if @comment.destroy
      redirect_to ankens_path, success: 'コメントの削除が完了しました。'
    else
      redirect_to ankens_path, danger: 'コメントの削除に失敗しました。'
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

    #コードマスタ情報を取得
    def getCodemst_for_options(categoryCd)
      @code_msts_for_options = CodeMst.where(category_cd: categoryCd).where(del_flg: 0)
    end

    #部署マスタ情報を取得
    def getSections_for_options
      @sections_for_options = Section.where(del_flg: 0)
    end

    def anken_find
      @anken = Anken.find(params[:id])
    end

    def comment_find
      @comment = Comment.find(params[:id])
    end

    def anken_params
      params.require(:anken).permit(:section_cd,:customer_id,:anken_name,:anken_summary,:budget_size,
      :start_date,:end_date,:pm,:asign_info,:anken_status_cd,:tanto_id,:anken_ball_cd,:remark)
    end

    def comment_params
      params.require(:comment).permit(:anken_id,:ymd,:anken_comment,:last_update)
    end

    def getSearchCondition(anken_search)
      anken_search.section_cd_search = session[:section_cd] == nil ? [] : session[:section_cd]
      anken_search.section_cd = session[:section_cd] == nil ? [] : session[:section_cd]
      anken_search.anken_name = session[:anken_name] == nil ? "" : session[:anken_name]
      anken_search.anken_summary = session[:anken_summary] == nil ? "" : session[:anken_summary]
      anken_search.customer_id = session[:customer_id] == nil ? "" : session[:customer_id]
      anken_search.tanto_id = session[:tanto_id] == nil ? "" : session[:tanto_id]
      anken_search.anken_status_cd_search = session[:anken_status_cd] == nil ? [] : session[:anken_status_cd]
      anken_search.anken_status_cd = session[:anken_status_cd] == nil ? [] : session[:anken_status_cd]
    end

    def searchConditionClear
      session[:section_cd] = nil
      session[:anken_name] = nil
      session[:anken_summary] = nil
      session[:customer_id] = nil
      session[:tanto_id] = nil
      session[:anken_status_cd] = nil
    end

    def setSectionCd
      @anken.section_cd = current_user.section_id
    end

    def setLastUpdateUser
      @anken.last_update = current_user.username
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def sort_column
      Task.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

end
