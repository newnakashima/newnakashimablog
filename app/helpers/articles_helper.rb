module ArticlesHelper
  def validPage?(page)
    return false if page.to_i <= 0 
    return true
  end
end
