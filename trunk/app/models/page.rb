class Page < ActiveRecord::Base
  has_and_belongs_to_many :titles
  belongs_to :user

  validates_presence_of :title

  simply_versioned :keep => 10 #, :automatic => false

  #named_scope :titled, lambda { |title| { :conditions => ['REPLACE(title, " ", "") = ?', title.gsub(' ', '')] }}
  named_scope :titled, lambda { |title| { :conditions => ['title = ?', title] }}
  named_scope :recent, lambda { |*args| { :limit => args.first || 5, :order => 'updated_at DESC' }}

  def related_pages
    titles = Title.of(self.title)
    titles.inject([]) { |arr, title| arr << title.pages }.flatten.uniq - [self]
  end

  # callbacks
  after_save :reindex_titles

  protected
  
  # TODO: code optimization
  def reindex_titles
    self.titles.destroy_all
    titles = self.body.scan(/\[\[(.*?)\]\]/).flatten
    titles.each do |title|
      self.titles << Title.create(:text => title)
    end
  end
  
end
