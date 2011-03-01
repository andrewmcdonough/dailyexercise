require 'sinatra'

# Specify the list of developers and the start date for the rotation
# --
EXERCISES = ["Plank","Wall Squat"]
START_DATE = Time.mktime(2011,02,04)

# --
SATURDAY_OFFSET = 6 - START_DATE.wday
SUNDAY_OFFSET =  7 - START_DATE.wday

get '/' do
  @who = what_exercise(Time.now)
  erb :index
end

def what_exercise(date)
  what_exercise_on_day(days_since_start(date))
end

def what_exercise_on_day(day)
  developers = EXERCISES.clone
  (1..day).each do |i|
    next if [SATURDAY_OFFSET,SUNDAY_OFFSET].include? i % 7 # Don't rotate at weekends
    developers.rotate!
  end
  return developers[0]
end

def days_since_start(date)
  ((date - START_DATE) / (60*60*24)).floor
end


