class CustomersController < ApplicationController
  before_action :customer_find, only: [:show,:edit,:update,:destroy]

  def index
    @customers = Customer.all.page(params[:page])
  end

  def new
    @customer = Customer.new
  end

  def show
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.invalid?
      #バリデーションエラーはエラー内容を返却。@customer.errors
      render :new, flash: {errors: @customer.errors.full_messages}
    else
      if @customer.save
        redirect_to customers_path, success: '顧客登録が完了しました。'
      else
        redirect_to customers_new_path, danger: '登録できませんでした。'
      end
    end
  end

  def edit
  end

  def update

    logger.debug "cutomer updating......"
    if @customer.invalid?

      logger.debug "customer.valid erorr....."
      render :edit, flash: {errors: @customer.errors.full_messages}

    else
      if @customer.update(customer_params)
        logger.debug "customer update complete!!"

       redirect_to customers_path, success: '顧客情報の更新が完了しました。'
      else
        logger.debug "customer update error!!"

        redirect_to customers_edit_path, danger: '更新ができませんでした。'
      end
    end
  end

  def destroy
    if @customer.destroy
      redirect_to customers_path, success: '顧客情報の削除が完了しました。'
    else
      redirect_to customers_path, danger: '顧客情報の削除ができませんでした。'
    end
  end

  private
    def customer_find
      @customer = Customer.find(params[:id])
    end

    def customer_params
      params.require(:customer).permit(:customer,:del_flg)
    end

end
