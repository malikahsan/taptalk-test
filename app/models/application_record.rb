class ApplicationRecord < ActiveRecord::Base
  include GeneralHelper
  self.abstract_class = true
end
