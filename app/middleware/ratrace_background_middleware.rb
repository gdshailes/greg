class RatraceBackgroundMiddleware
  def initialize(app, count = 5)
    @app = app
    @count = count
  end

  def call(env)
    if env["PATH_INFO"] == "/ratrace-background.jpg"
      [302, {"Location" => "/ratrace/backgrounds/ratrace-background-#{rand(@count)}.jpg"}, '']
    elsif env["PATH_INFO"] == "/ratrace-mobile-background.jpg"
      [302, {"Location" => "/ratrace/backgrounds/ratrace-background-mobile-#{rand(@count)}.jpg"}, '']
    else
      @app.call(env)
    end
  end
end