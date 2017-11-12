class MailProp
  include ActiveModel::Model

  #メール送信に必要な属性を定義
  attr_accessor :email, :for_name, :title, :contents, :anken_info, :send_name, :url

end
