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

  def change_style(status)
    if status.present?
      if status == 6 || status == 7 || status == 8 || status == 9
         return "color_lightgray"
      end
    end
  end

  def change_style2(status)
    if status.present?
      if status == 3
        return true;
      end
    end
  end

  def isDisabled(bln)
    if bln
      return "disabled"
    end
  end

  def showDelflg
  end

  def sortable(column,title=nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction} btn btn-link" : "btn btn-link"
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

end
