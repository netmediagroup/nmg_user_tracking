module NmgUserTracking

  protected

    # Inclusion hook to make methods available as ActionView helper methods.
    def self.included(base)
      base.send :helper_method, :current_source, :current_affiliate_id, :original_orgin
    end


    #
    # Source
    #

    # Accesses the current source from the session.
    def current_source
      @current_source ||= set_source
    end
    # Store the given source in the session and cookie.
    def current_source=(value)
      session[:nmg_source] = value
      cookies[:nmg_source] = { :value => value, :expires => 1000.day.from_now } if value
      @current_source = value || false
    end

    # Set the source from methods in this order
    def set_source
      set_source_from_params || set_source_from_session || set_source_from_cookie || set_source_from_orgin || set_source_from_default
    end
    # Set the source based on a params variable.
    def set_source_from_params
      self.current_source = params[:source] unless params[:source].blank?
    end
    # Set the source based on the stored session.
    def set_source_from_session
      self.current_source = session[:source] unless session[:source].blank?
    end
    # Set the source based on the stored cookie.
    def set_source_from_cookie
      self.current_source = cookies[:nmg_source] unless cookies[:nmg_source].blank? || session[:source] == cookies[:nmg_source]
    end
    # Set the source based on the original orgin.
    def set_source_from_orgin
      self.current_source = 'seo' unless self.original_orgin.blank?
    end
    # # Set the source based on the referring url.
    # def set_source_from_referer
    #   self.current_source = 'seo' unless request.env['HTTP_REFERER'].blank?
    # end
    # Set the source to this defaulted value.
    def set_source_from_default
      self.current_source = 'type-in'
    end


    #
    # Affiliate ID
    #

    # Accesses the current affiliate id from the session.
    def current_affiliate_id
      @current_affiliate_id ||= set_affiliate_id
    end
    # Store the given affiliate id in the session.
    def current_affiliate_id=(value)
      session[:affiliate_id] = value
      # cookies[:affiliate_id] = { :value => value, :expires => 1000.day.from_now } if value
      @current_affiliate_id = value || false
    end

    # Set the affiliate id from methods in this order
    def set_affiliate_id
      set_affiliate_id_from_params || set_affiliate_id_from_session
    end
    # Set the affiliate id based on a params variable.
    def set_affiliate_id_from_params
      if !params[:a_aid].blank?
        self.current_affiliate_id = params[:a_aid]
        session[:moolamoola_affiliate] = true
      elsif !params[:aff_id].blank?
        self.current_affiliate_id = params[:aff_id]
      end
    end
    # Set the affiliate id based on the stored session.
    def set_affiliate_id_from_session
      self.current_affiliate_id = session[:affiliate_id] unless session[:affiliate_id].blank?
    end
    # Set the affiliate id based on the stored cookie.
    def set_affiliate_id_from_cookie
      self.current_affiliate_id = cookies[:affiliate_id] unless cookies[:affiliate_id].blank? || session[:affiliate_id] == cookies[:affiliate_id]
    end


    #
    # Orgin
    #

    # Accesses the original orgin from the session.
    def original_orgin
      @original_orgin ||= set_orgin unless @original_orgin == false
    end
    # Store the given orgin in the session.
    def original_orgin=(value)
      session[:original_orgin] = value
      @original_orgin = value || false
    end

    # Set the orgin from methods in this order
    def set_orgin
      set_orgin_from_session || set_orgin_from_referer || set_orgin_from_default
    end
    # Set the orgin based on the stored session.
    def set_orgin_from_session
      self.original_orgin = session[:original_orgin] unless session[:original_orgin].nil?
    end
    # Set the orgin based on the referring url.
    def set_orgin_from_referer
      self.original_orgin = request.env['HTTP_REFERER'] unless request.env['HTTP_REFERER'].blank?
    end
    # Set the source to this defaulted value.
    def set_orgin_from_default
      self.original_orgin = ''
    end

end
