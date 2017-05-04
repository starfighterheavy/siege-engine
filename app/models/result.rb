class Result < ActiveRecord::Base
  belongs_to :siege
  belongs_to :target
end
