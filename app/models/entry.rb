class Entry < ActiveRecord::Base
  validates_presence_of :name, :message

  MAX_LATESTS = 20

  scope :latest, -> { limit(MAX_LATESTS).order('created_at DESC') }
end
