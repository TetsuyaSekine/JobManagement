module AnkensHelper

  def chk_checked(array,value)
    if array.present?
      if array.find{|n| n == value.to_s}.present?
        return true
      else
        return false
      end
    else
      return false
    end
  end
end
