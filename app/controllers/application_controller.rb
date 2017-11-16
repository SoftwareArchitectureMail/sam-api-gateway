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
    host = "-"
    case ms
    when "sm" #send mail
      host = ENV["SANTIAGO"] + "3034"
    when "in" #Inbox
      host = ENV["SANTIAGO"] + "3032"
    when "nt" #Notifications
      host = ENV["SANTIAGO"] + "3033"
    when "rg" #Register
      host = ENV["REG"] + "3034"
    when "ss" #Sessions
      host = ENV["SESS"] + "3035"
    when "schs" # programacion
      host = ENV["PROG"] + "3006"
    when "ldap" # programacion
      host = ENV["LDAP"] + "4001"
    end
    return host
  end

end
