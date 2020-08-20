class RandomImageMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    if (/^\/img\/.*\/random$/ =~ env['PATH_INFO'])
      redirect_to_random_image(env['PATH_INFO'])
    else
      @app.call(env)
    end
  end


  private


  def redirect_to_random_image(path_info)

    path_info = path_info.slice(1..-7)
    directory = Rails.root.join('public', path_info)
    filename = Dir.glob("#{directory.join('**', '*')}[!random/]").sample

    return four_oh_four(path_info) if filename.nil?

    [302, {'Location' => "/#{path_info}#{filename.split('/').last}"}, []]

  end

  def four_oh_four(path_info)
    message = "No images found in #{path_info}"
    Bugsnag.notify(message)
    [404, {'Content-Type' => 'text/html', 'Content-Length' => message.size.to_s}, [message]]
  end

end
