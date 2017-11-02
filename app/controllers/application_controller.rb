class ApplicationController < ActionController::API
  include Guardsman
  include Pundit

  # Filters
  before_action :destroy_session
  before_action :authenticate
  before_action :set_resource_scope, only: [:index, :create]
  before_action :set_resource,       only: [:show, :update, :destroy]

  # Rescue controller actions
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from Guardsman::NotAuthenticatedError, with: :not_authenticated
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  # GET /{plural_resource_name}
  def index
    @resources = resource_scope
      .where(resource_query_params)
      .page(page_params[:number])
      .per(page_params[:limit])

    render json: @resources, include: relationships, meta: meta
  end

  # GET /{plural_resource_name}/1
  def show
    render json: resource
  end

  # POST /{plural_resource_name}
  def create
    @resource = resource_scope.new(resource_params)

    if @resource.save
      render json: @resource, status: :created, location: @resource
    else
      render json: @resource, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  # PATCH/PUT /{plural_resource_name}/1
  def update
    if resource.update(resource_params)
      render json: resource
    else
      render json: resource, status: :unprocessable_entity, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  # DELETE /{plural_resource_name}/1
  def destory
    resouce.destroy
    head :no_content
  end

  protected

  def current_user
    User.first
  end

  # APIs by definition are stateless and a session
  # is exactly the opposite of that. We must disable
  # the CSRF token and cookies
  def destroy_session
    request.session_options[:skip] = true
  end

  # Rails will raise an ActiveRecord::RecordNotFound
  # exception if a client requests a resource that
  # does not exist in our database. This will cause
  # Rails to return a 500 error, but what we actually
  # want here is to return a 404 error
  def not_found
    head :not_found
  end

  # Rails will raise a Guardsman::NotAuthenticatedError
  # exception if a client requests a resource and
  # they are not authenticated with the system.
  # This will cause Rails to return a 500 error,
  # but what we actually want is to return a 404
  # error.
  def not_authenticated
    head :unauthorized
  end

  # Rails will raise a Pundit::NotAuthorizedError
  # exception if a client requests a resource and
  # they are not authorized to access the resource.
  # This will cause Rails to return a 500 error,
  # but what we actually want is to return a 404
  # error.
  def not_authorized
    head :forbidden
  end

  private

  # Returns the resource from the created instance
  # variable
  #
  # @return [ActiveRecord::Base] Resource instance.
  def resource
    instance_variable_get("@#{resource_name}")
  end

  # Use callbacks to share common setup or contraintes
  # between actions
  def set_resource
    resource ||= resource_class.find(params[:id])
    instance_variable_set("@#{resource_name}", resource)
  end

  # Returns the resource class from the created instance
  # variable
  #
  # @return [Class] Resource class scope.
  def resource_scope
    instance_variable_get("@#{resource_name}_scope")
  end

  # Use callbacks to share common setup or constraints
  # between actions
  def set_resource_scope
    resource_scope ||= policy_scope(resource_class)
    instance_variable_set("@#{resource_name}_scope", resource_scope)
  end

  # The resource class based on the controller name for
  # the requested resource
  #
  # @return [Class] Resource class.
  def resource_class
    @resource_class ||= resource_name.classify.constantize
  end

  # The singular name of the resource class based on the
  # controller for the requested resource
  #
  # @return [String] Singular name of the resource class.
  def resource_name
    @resource_name ||= controller_name.singularize
  end

  # Only allow a trusted parameter "white list" through.
  # If a single resource is loaded for #create or #update,
  # then the controller for the resource must implement
  # the method "#{resource_name}_params" to limit permitted
  # parameters for the individual model.
  #
  # @return [Hash] Hash of white listed resource parameters and values.
  def resource_params
    @resource_params ||= send("#{resource_name}_params")
  end

  # Returns the allowed parameters for searching. Override
  # this method in each API controller to permit additional
  # parameters on which to search
  #
  # @return [Hash] Hash of white listed resource query parameters and values.
  def resource_query_params
    @resource_query_params ||= params["#{resource_name}_params"]
  end

  # Returns the permitted parameters for pagination so no
  # malicious values are used
  #
  # @return [Hash] Hash of pagination parameters and values.
  def page_params
    params.permit(page: {}).fetch(:page, {})
  end

  # Array of resources used as relationships on the current
  # resource
  #
  # @return [Array] Array of relationships.
  def relationships
    []
  end

  def meta
    { pages: @resources.total_pages }
  end
end
