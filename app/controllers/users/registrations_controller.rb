class Users::RegistrationsController < Devise::RegistrationsController
  before_action :getSections_for_options, only: [:new,:edit]

  def cancel
    super
  end
  def create
    super
  end
  def new
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
  private
    def getSections_for_options
      @sections_for_options = Section.where(del_flg: '0')
    end
end
