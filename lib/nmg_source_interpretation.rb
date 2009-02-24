module SetSource

  protected

    def set_source
      # Logic: Is there an source= variable in the URL?
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

end