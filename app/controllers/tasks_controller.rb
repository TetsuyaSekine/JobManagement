class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  helper_method :sort_column, :sort_direction
  # GET /tasks
  # GET /tasks.json

  include Common

  def index
    @tasks = Task.joins("LEFT OUTER JOIN code_msts ON tasks.status = code_msts.contents_cd")
    .select("tasks.*,code_msts.contents").where(code_msts: {category_cd: '0002',del_flg: 0})
    .order(sort_column + ' ' + sort_direction).page(params[:page])

    respond_to do |format|
      format.html
      format.xlsx do
        response.headers['Content-Disposition'] = "attachment; filename=task_list.xlsx"
      end
    end

  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
    getCodemst_for_options('0002')
  end

  # GET /tasks/1/edit
  def edit
    getCodemst_for_options('0002')
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save

        #メールを送信 ログインユーザーの登録メールアドレスにnoticeメールを送信する。
#        email_prop = MailProp.new email: current_user.email,
#              for_name: current_user.username, title: "テスト送信", contents: "Aさんがコメントを追加しました。",
#              anken_info: "案件ID:3 案件名:次世代マッチング" ,send_name: "taro.yamada", url: "http://openam.vagrant.local.com:3000/tasks"
#        PostMailer.notice_for_comment(email_prop).deliver_now
        @email = current_user.email
        @for_name = current_user.username
        @title = Settings.notice_info.create_comment.title
        @contents = Settings.notice_info.create_comment.contents
        @anken_info = Settings.notice_info.create_comment.anken_info
        @send_name = Settings.emails.for_name
        @url = Settings.notice_info.create_comment.url
        sendEmail

        format.html { redirect_to tasks_path, success: 'タスクは正常に登録されました。' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_path, success: 'タスクの更新が完了しました。' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :detail, :due, :status, :remark)
    end

    #コードマスタ情報と取得
    def getCodemst_for_options(categoryCd)
      @code_msts_for_options = CodeMst.where(category_cd: categoryCd).where(del_flg: 0)
    end

    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end

    def sort_column
      Task.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end

end
