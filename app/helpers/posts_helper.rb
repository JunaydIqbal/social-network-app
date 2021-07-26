module PostsHelper
  def published_tag(boolean, options={})
    options[:public_text] ||= ''
    options[:private_text] ||= ''

    if boolean
      content_tag(:span, options[:public_text], :class => 'status true')
    else
      content_tag(:span,options[:private_text], :class => 'status false')
    end
  end
end
