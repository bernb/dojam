FactoryBot.define do
  factory :path do
    termlist {nil}

    transient do
      term_id {nil}
      term_ids {nil}
    end

    if term_id.present?
      path {"/#{term_id}"}
    end
    if term_ids.present?
      path {term_ids.map{|n| "/#{n}"}.reduce(:+)}
    end
  end
end