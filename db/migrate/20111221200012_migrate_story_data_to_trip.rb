class MigrateStoryDataToTrip < ActiveRecord::Migration
  def up
    # Migrating story data from ride to trip.
    # A Ride has an optional title string and a stroy text
    # A trip has only a story as a text so we want the former ride stories
    # to look like that in markdown at trip.story:
    #   Ride 1 - Ride Title
    #   -------------------
    #   Ride story
    #
    #   Ride 3 - Ride Title 2
    #   ---------------------
    #   2nd Ride story etc...

    Trip.includes(:rides).where(['rides.story IS NOT NULL']).all.each do |trip|
      string = ''
      trip.rides.each do |ride|
        unless ride.story.blank?
          string << "Ride #{ride.number}"
          string << " - #{ride.title}" unless ride.title.blank?
          string << "\n---------------\n\n"
          string << ride.story
          string << "\n\n"
        end
      end
      trip.story = string
      trip.save!
    end
  end

  def self.down
    Trip.all.each{|trip| trip.story = nil; trip.save!}
  end
end