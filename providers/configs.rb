action :create do
  template new_resource.name do
    source    new_resource.source
    variables new_resource.variables
    mode      '644'
    owner     'root'
    group     'root'
  end
end
