# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

	def jquery_onload(&block)
    content_for(:jquery_onload) do
      javascript_tag "$(document).ready(function() { #{capture(&block)} });"
    end
  end

  def block_to_partial(partial_name, options={}, &block)
    options.merge!(:body => capture(&block))
    concat(render(:partial => partial_name, :local => options), block.building)
  end

	def page_title(title, htag=:h2)
	  @title = h(title)
	  content_tag htag, @title, :class => 'page_title'
	end
	
	def span_tag(value)
		content_tag :span, value
	end
	
	def button_link_to(name, options = {}, html_options = {})
		link_to(span_tag(name), options, html_options.merge(:class => 'button'))
	end

  def thumb_image_tag(source, options={})
    class_type = (options[:type] == :book) ? 'book' : ''
    content_tag :div, :class => "thumb #{class_type} float left" do
      image_tag(source, options)
    end
  end

  def empty_msg_for(collection, msg='항목이 없습니다.', tag=:div)
    content_tag tag, :class => 'empty rounded' do 
      msg 
    end if collection.empty?
  end
  def tr(name, value)
    "<tr><td>#{name}</td><td>#{value}</td>" #unless strip_links(value).blank?
  end

  def human_time(datetime)
    if datetime.to_date == Date.today
     ret = "오늘"
    else  
	    ret = datetime.year == Time.now.year ? datetime.to_s(:kmd) : datetime.to_s(:kymd)
    end  
	  ret += " #{datetime.to_s(:khm)}"
  end
  
  
end
