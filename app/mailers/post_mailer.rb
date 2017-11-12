class PostMailer < ApplicationMailer

    def notice_for_comment(email_prop)
      @email_prop = email_prop
      mail(to: @email_prop.email, subject: @email_prop.title) do |format|
        format.text
      end
    end

end
