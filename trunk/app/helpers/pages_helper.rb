module PagesHelper

  def wikilize(text)
    text.gsub(/\[\[(.*?)\]\]/, '<a href="/pages?title=\1" class="wikilink">\1</a>') unless text.blank?
  end
  
  alias_method :w, :wikilize
  
  def strip_wiki(text)
    text.gsub(/\[\[(.*?)\]\]/, '\1')
  end
  
  def strip_tags_and_wiki(text)
    strip_wiki(strip_tags(text))
  end
  
end
