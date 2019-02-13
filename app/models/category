class Category < ActiveRecord::Base
  has_many :pastries

  def slug
    self.name.strip.downcase.gsub /\W+/, '-'
  end

  def self.find_by_slug(slug)
    self.find {|obj| obj.slug == slug}
  end
end 
