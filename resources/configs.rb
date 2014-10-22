actions :create
default_action :create
attribute :source, :required => true, :kind_of => String
attribute :variables, :default => {}, :kind_of => Object
