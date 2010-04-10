# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def error_messages_for(*params)
    options = params.extract_options!.symbolize_keys

    if object = options.delete(:object)
      objects = [object].flatten
    else
      objects = params.collect {|object_name| instance_variable_get("@#{object_name}") }.compact
    end

    count  = objects.inject(0) {|sum, object| sum + object.errors.count }
    unless count.zero?
      html = {}
      [:id, :class].each do |key|
        if options.include?(key)
          value = options[key]
          html[key] = value unless value.blank?
        else
          html[key] = 'errorExplanation'
        end
      end
      options[:object_name] ||= params.first

      I18n.with_options :locale => options[:locale], :scope => [:activerecord, :errors, :template] do |locale|
        header_message = if options.include?(:header_message)
          options[:header_message]
        else
          object_name = options[:object_name].to_s.gsub('_', ' ')
          object_name = I18n.t(object_name, :default => object_name, :scope => [:activerecord, :models], :count => 1)
          locale.t :header, :count => count, :model => object_name
        end

        error_messages = objects.sum {|object| object.errors.full_messages.map {|msg| ERB::Util.html_escape(msg)+" , " } }.join.strip!.chop! + "."
        header_message = header_message+error_messages
        contents = ''
        contents << content_tag(options[:header_tag] || :h2, header_message) unless header_message.blank?

        content_tag(:div, contents, html)
      end
    else
      ''
    end
  end

end
