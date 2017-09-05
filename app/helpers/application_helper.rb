module ApplicationHelper

  def update_emphasis(div,updated_at)
    if updated_at.present?
      if Time.now.ago(3.days) < updated_at.to_time

        if div == :class_contents
          return "emphasis"
        else
          return "new2.ico"
        end
      end
    end
  end
end
