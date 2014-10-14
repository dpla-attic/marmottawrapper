require 'marmottawrapper'
require 'rails'

module MarmottaWrapper
  class Railtie < Rails::Railtie
  	railtie_name :marmottawrapper

  	rake_tasks do
  	  load "marmottawrapper/tasks/marmottawrapper.rake"
  	end
  end
end
