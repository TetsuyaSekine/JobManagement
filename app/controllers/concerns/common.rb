module Common
  extend ActiveSupport::Concern

  def sendEmail

    email_prop = MailProp.new(
        email: @email,
        for_name: @for_name,
        title: @title,
        contents: @contents,
        anken_info: @anken_info,
        send_name: @send_name,
        url: @url
    )
    PostMailer.notice_for_comment(email_prop).deliver_now

  end
end
