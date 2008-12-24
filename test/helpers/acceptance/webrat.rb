require "sinatra"
require "sinatra/test/unit"
require Integrity.root / "app"
require "webrat/sinatra"

module WebratIntegrationHelper
  include Webrat::Methods
  
  %w(head get post put delete).each do |meth|
    define_method(meth) do |*args|
      args << {} if args.size == 1
      webrat_session.send(meth, *args)
    end
  end
  
  def body
    webrat_session.response_body
  end
  
  def status
    webrat_session.response_code
  end
end

class Webrat::SinatraSession
  attr_reader :response
end
