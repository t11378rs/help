module ApplicationHelper
	# ページごとの完全なタイトルを返します。
  def full_title(page_title)
    base_title = "HELP! demo"
    if page_title.empty?
      base_title #暗黙の返り値
    else
      "#{base_title} | #{page_title}" #文字列の式展開
    end
  end
end
