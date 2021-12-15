# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
ProjetoB2B::Application.initialize!

ActiveRecord::Base.pluralize_table_names = false 
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8