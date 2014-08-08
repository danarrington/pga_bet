FactoryGirl.define do
  factory :tournament do
    name "Dan Open"
    start Date.yesterday
    course_par 70
  end
end
