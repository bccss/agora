class SessionsController < Devise::SessionsController
  skip_before_filter :authenticate_user!, :only => [:create, :new]
  skip_before_filter :verify_signed_out_user
  # skip_authorization_check only: [:create, :failure, :show_current_user, :options, :new]
  respond_to :json

  def new
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

  def create
    respond_to do |format|
      format.html {
        super
      }
      # curl -H "Content-type: application/json" -H "Accept: application/json"\
      # -d '{"email":"test@test.test","password":"testtest"}' -X POST\
      # http://api.lvh.me:3000/users/sign_in
      format.json {
        resource = resource_from_credentials
        return invalid_login_attempt unless resource

        if resource.valid_password?(params[:password])
          render :json => { user: { email: resource.email, :auth_token => resource.authentication_token }, success: true }, success: true, status: :created
        else
          invalid_login_attempt
        end
      }
    end
  end

  def destroy
    respond_to do |format|
      format.html {
        super
      }
      format.json {
        user = User.find_by(authentication_token: request.headers['X-AUTH-TOKEN'])
        if user
          user.reset_authentication_token
          render :json => { :message => 'Session deleted.' }, :success => true, :status => 204
        else
          render :json => { :message => 'Invalid token.' }, :success => false, :status => 404
        end
      }
    end
  end

  protected
  def invalid_login_attempt
    warden.custom_failure!
    render json: { success: false, message: 'Error with your login or password' }, status: 401
  end

  def resource_from_credentials
    data = { email: params[:email] }
    if res = resource_class.find_for_database_authentication(data)
      if res.valid_password?(params[:password])
        res
      end
    end
  end
end
