module ProductsHelper

  # 金額に","を追加
  def converting_to_jpy(price)
    "#{price.to_s(:delimited, delimiter: ',')}"
  end

end
