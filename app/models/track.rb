class Track < ActiveRecord::Base
  validates :title, :track_type, :album_id, presence: true
  validates :title, uniqueness: {scope: :album_id}

  belongs_to :album,
    class_name: 'Album',
    foreign_key: :album_id,
    primary_key: :id

  has_one :band,
    through: :album,
    source: :band
    
  has_many :notes,
    dependent: :destroy,
    class_name: 'Note',
    foreign_key: :track_id,
    primary_key: :id
end
