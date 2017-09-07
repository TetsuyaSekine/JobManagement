module AnkensHelper

  def chk_checked(array,value)
    if array.present?
      logger.debug "ログだよ"
      logger.debug array
      logger.debug value
      if array.find{|n| n == value.to_s}.present?
        logger.debug "trueなり"
        return true
      else
        logger.debug "falseなり"

        return false
      end
    else
      return false
    end
  end
end
