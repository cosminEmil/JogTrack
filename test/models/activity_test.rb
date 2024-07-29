require "test_helper"

class ActivityTest < ActiveSupport::TestCase
    def setup
      @user = users(:michael)
      @activity = @user.activities.build(distance:  10, hours: 0, minutes: 54, seconds: 23, run_at: '2024-04-15 19:44:00', title: "Evening Run", description: "It was my best run")
    end

    test "should be valid" do 
      assert @activity.valid?
    end

    test "user id should be present" do
      @activity.user_id = nil
      assert_not @activity.valid? 
    end

    test "distance should be greater than zero" do
      @activity.distance = -1
      assert_not @activity.valid?
    end
    
    test "hours should be positive" do 
      @activity.hours = -1
      assert_not @activity.valid?
    end

    test "minutes should be positive and less than or equal to 60" do
      @activity.minutes = -1;
      assert_not @activity.valid?
      @activity.minutes = 61
      assert_not @activity.valid?
    end

    test "seconds should be greater than zero and less than or equal to 60" do
      @activity.seconds = -1
      assert_not @activity.valid?
      @activity.seconds = 61
      assert_not @activity.valid?
    end

    test "activity must have a date and time" do 
      @activity.run_at = "    "
      assert_not @activity.valid?
    end


    test "desciption should be at most 140 characters" do 
      @activity.description = "a" * 141
      assert_not @activity.valid?
    end
    
    test "order should be most recent first" do
      assert_equal activities(:most_recent), Activity.first
    end  

end
