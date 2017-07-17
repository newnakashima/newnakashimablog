module ArticlesHelper
  def validPage?(page)
    return false if page.to_i <= 0 
    return true
  end

  def translateImageTag(text)
    newText = ""
    text.each_line("\n") {|line|
      newText += line.gsub(/\[img:\s(.*)\]/, '<img \1>')
    }
    return newText
  end
end
