class ApplicationRecord < ActiveRecord::Base
  include Searchable
  include TranslateEnum
  primary_abstract_class
end
