class ApiVersion
  def initialize(version, default=false)
    @version = version
    @default = default
  end

  def matches?(request)
    @default || check_headers(request.headers)
  end

  private

  def check_headers(headers)
    headers["Accept"]&.include?("application/vnd.eventerapi.#{@version}+json")
  end
end
