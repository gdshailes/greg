module ApplicationHelper

  class DiaryHTMLRenderer < Redcarpet::Render::HTML

    def codespan(code)
      "<code class='inline'>#{code}</code>"
    end

    def block_code(code, language)
      "<pre class='block-code #{language}'>#{code}</pre>"
    end

  end

  def markdown(text)
    if @markdown.nil?
      options = {:hard_wrap => true}
      extensions = { :fenced_code_blocks => true }
      renderer = DiaryHTMLRenderer.new(options)
      @markdown ||= Redcarpet::Markdown.new(renderer, extensions)
    end
    @markdown.render(text).html_safe
  end

end
