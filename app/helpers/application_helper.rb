module ApplicationHelper
  def full_name
    "#{self.l_name} #{self.f_name}"
  end

  def full_name_kana
    "#{self.l_name_kana} #{self.f_name_kana}"
  end

  def birthday
    "#{BirthYyyy.find(self.birth_yyyy_id).year}/#{BirthMm.find(self.birth_mm_id).month}/#{BirthDd.find(self.birth_dd_id).day}"
  end
end
