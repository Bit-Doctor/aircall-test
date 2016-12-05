class Call < ApplicationRecord
  belongs_to :respondent_number, class_name: 'UserNumber', foreign_key: 'user_number_id', optional: true
  belongs_to :respondent, class_name: 'User', foreign_key: 'user_id', optional: true
  belongs_to :company_number
end
