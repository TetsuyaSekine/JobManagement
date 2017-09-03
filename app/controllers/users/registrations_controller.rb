class Users::RegistrationsController < Devise::RegistrationsController
  def cancel
    super
  end
  def create
    super
  end
  def new
    #組織マスタを取得する。
    @sections_for_options = Section.where(del_flg: '0')
    super
  end
  def edit
    super
  end
  def update
    super
  end
  def destroy
    super
  end
end
