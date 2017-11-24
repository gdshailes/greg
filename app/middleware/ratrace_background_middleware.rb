class RatraceBackgroundMiddleware
  def initialize(app, count = 5)
    @app = app
    @count = count
  end

  def call(env)
    if env["PATH_INFO"] == "/ratrace-background.jpg"
      [302, {"Location" => "/assets/ratrace-background-#{rand(@count)}.jpg"}, '']
    else
      @app.call(env)
    end
  end
end