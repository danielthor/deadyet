require 'sinatra'
require 'freebase-api'

get '/' do
  query = params[:q] || 'Dolly Parton'
  
  result = FreebaseAPI::Topic.search(query, filter: '(any type:/people/person)').first[1]

  resource = FreebaseAPI::Topic.get(result.id)

  @name = resource.name
  @is_deceased = resource.property('/people/deceased_person/date_of_death') != nil
  
  haml :index
end
