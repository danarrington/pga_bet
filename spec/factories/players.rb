FactoryGirl.define do
  factory :player do
    name {Faker::Name.name}
  end

  factory :player_hash, class: Hashie::Mash do
    name {Faker::Name.name}
  end
end
