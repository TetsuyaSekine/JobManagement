module Common
  extend ActiveSupport::Concern

  def sendEmail

    email_prop = MailProp.new(
        email: @email,
        ccEmails: @ccEmails,
        for_name: @for_name,
        title: @mail_title,
        contents: @contents,
        anken_info: @anken_info,
        send_name: @send_name,
        url: @url
    )
    PostMailer.notice_for_comment(email_prop).deliver_now

  end

  def getEmailsOfSection
    mail_users = User.where(section_id: current_user.section_id)

    logger.debug mail_users

    @ccEmails = []
    mail_users.each do |user|
      @ccEmails.push(user.email)
    end
  end

end
