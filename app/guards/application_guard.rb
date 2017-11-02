class ApplicationGuard
  attr_reader :request, :scope

  def initialize(request, scope)
    @request = request
    @scope = scope
  end

  def authenticate
    true
  end
end
