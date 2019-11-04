class Event < ApplicationRecord
  has_many :participations

  validates :start_date, presence: true
  validate :event_past

  validates :duration, presence: true, :numericality => { :greater_than_or_equal_to => 0}
  validate :divisible_by_five

	validates :title,
		presence: true,
    length: { in: 5..140 }
    
  validates :description,
		presence: true,
    length: { in: 20..10000 }

  validates :price, presence: true
    validates_inclusion_of :price, :in => 1..1000 

  validates :location,
    presence: true

    def event_past
      if start_date < DateTime.now
        errors.add(:start_date, "Event can't start in the past")
      end
    end

    def divisible_by_five
      if (self.duration % 5) != 0
        self.errors[:base] << "Number must be divisible by 5!"
      end
    end
  end
