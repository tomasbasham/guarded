class ApiConstraint
  attr_reader :version, :default

  # Create a new API constraint with a version
  # and a flag detailing whether this version
  # is the default version.
  def initialize(options = {})
    @version = options[:version]
    @default = options[:default]
  end

  # Check whether the request satisfies the
  # constraints.
  def matches?(request)
    versioned_accept_header?(request) || default_version?
  end

  private

  # Check whether the request contains a versioned
  # accept header.
  def versioned_accept_header?(request)
    request.headers[:accept].include?("application/vnd.api.v#{@version}+json")
  end

  # Check whether this constraint represents the
  # default API version.
  def default_version?
    @default.present?
  end
end
