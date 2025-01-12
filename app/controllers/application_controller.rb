require 'net/http'
require 'json'
require 'uri'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def build_uri(api_url, variables)
    variable_str = ''
    variables.each_key {|key| variable_str += "#{key}=#{variables[key]}&"}
    return URI("#{api_url}?#{variable_str}")
  end

  def fetch_from_api(uri)    
    response = Net::HTTP.get_response(uri)
    return JSON.parse(response.body)
  end 

  # Save conditions to database for all backdated parameters
  def backdate_database(params)
    params.each{|condition_param|
      puts '...initializing database'
      create_new_condition(condition_param)
    }

    puts 'database initialized'
  end

  # Save individual condition to database
  def create_new_condition(params)
    @condition = Condition.new(params)
    @condition.save
    return @condition
  end
end
