class Pastry < ActiveRecord::Base
  belongs_to :user
  has_many :categories

  def slug
    self.name.strip.downcase.gsub /\W+/, '-'
  end

  def self.find_by_slug(slug)
    self.find {|obj| obj.slug == slug}
  end
end
