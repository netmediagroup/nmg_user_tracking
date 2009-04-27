module SetSource

  protected

    def set_source
      # Logic:
      # Is there a source= variable in the URL?
      #   If so, that is the new source -> Cookie It -> end
      # Is there a currently set nmg_source cookie?
      #   If so, that is the current source -> end
      # Is there a referring URL?
      #   If so, source = SEO -> Cookie It -> end
      # Source = Type-In -> Cookie It -> end

      if !params[:source].blank?
        source = params[:source]
      elsif !cookies[:nmg_source].blank?
        source = cookies[:nmg_source] unless session[:nmg_source] == cookies[:nmg_source]
      elsif session[:job_agent_email_referer]
        source = 'job-agent-email'
      elsif !request.env['HTTP_REFERER'].blank?
        source = 'seo'
      else
        source = 'type-in'
      end

      if source
        session[:nmg_source] = source
        cookies[:nmg_source] = { :value => source, :expires => 1000.day.from_now }
      end
    end


    def set_affiliate_id
      # Logic:
      # Is there an a_aid= variable in the URL?
      #   If so, that is the new affiliate_id and that this is a MoolaMoola affiliate.
      # Is there an aff_id= variable in the URL?
      #   If so, that is the new affiliate_id.
      # Is there currently a affiliate_id cookie?
      #   If so, that is the affiliate_id unless it has already been set.

      if !params[:a_aid].blank?
        affiliate_id = params[:a_aid]
        session[:moolamoola_affiliate] = true
      elsif !params[:aff_id].blank?
        affiliate_id = params[:aff_id]
      elsif !cookies[:affiliate_id].blank?
        affiliate_id = cookies[:affiliate_id] unless session[:affiliate_id] == cookies[:affiliate_id]
      end

      if affiliate_id
        session[:affiliate_id] = affiliate_id
        cookies[:affiliate_id] = { :value => affiliate_id }
      end
    end

end