class User < ActiveRecord::Base
  has_many :pastries

  def slug
    self.username.strip.downcase.gsub /\W+/, '-'
  end

  def self.find_by_slug(slug)
    self.find {|obj| obj.slug == slug}
  end

  has_secure_password

end
