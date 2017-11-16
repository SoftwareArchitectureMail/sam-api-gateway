class ApplicationController < ActionController::API

   before_action :validate_token

   private

   def validate_token
    begin
      decoded_token = JWT.decode request.headers['AUTHORIZATION'], ::RSAPublic, true, { :algorithm => 'RS256' }
    rescue JWT::ExpiredSignature
      render status: 401
      return 1
    rescue Exception
      render status: 400
      return 1
    end
    if decoded_token[0]["typ"] != "Authorization"
      render status: 400
    else
      @username = decoded_token[0]["sub"]
    end
  end


  def ms_ip(ms)
    host = "http://192.168.99.101:"
    hostr = "http://192.168.99.102:"
    hosts = "http://192.168.99.103:"
    host2 = "http://168.176.38.67:"
    case ms
    when "sm" #send mail
      host2 += "3034"
    when "in" #Inbox
      host2 += "3032"
    when "nt" #Notifications
      host2 += "3033"
    when "rg" #Register
      hostr += "3034"
    when "ss" #Sessions
      hosts += "3035"
    when "schs" # programacion
      host += "3006"
    when "ldap" # programacion
      host += "4001"
    end
    return host
  end

end
