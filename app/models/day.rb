class Day < ActiveRecord::Base
    has_many :panelties, dependent: :destroy
    belongs_to :user
end
