FactoryBot.define do
  factory :shelter do
    foster_program {true}
    name {'Bob'}
    city {"Dallas"}
    rank {1}
  end
end
