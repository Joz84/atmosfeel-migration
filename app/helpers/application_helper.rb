module ApplicationHelper
  def atmosphere_bg(atmosphere)
    if !atmosphere.color.nil?
      "background: #{atmosphere.color};"
    else
      ''
    end
  end

  def atmosphere_style(atmosphere)
    if !atmosphere.color.nil?
      "#{atmosphere_bg(atmosphere)} color: #{atmosphere.text_color} !important"
    else
      ''
    end
  end

  def attribute_has_error(object, attribute)
    object.errors.messages.include?(attribute) ? 'has-error' : ''
  end

  def controller?(controller)
    if controller.include?(params[:controller])
      'active'
    end
  end

  def to_options(collection)
    collection.each_with_object([[option_all_label(collection), 0]]) do |i, opts| 
      opts << yield(i)
    end
  end

  private 

  def option_all_label(collection)
    t "select.option_all.#{collection.first.class.to_s.downcase}"
  end
end
