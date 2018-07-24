module ApplicationHelper

  def markdown(text)
    if @markdown.nil?
      options = {:hard_wrap => true}
      extensions = { :fenced_code_blocks => true }
      renderer = Redcarpet::Render::HTML.new(options)
      @markdown ||= Redcarpet::Markdown.new(renderer, extensions)
    end
    @markdown.render(text).html_safe
  end

end
