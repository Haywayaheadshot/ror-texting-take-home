class SendMessage < ApplicationRecord
  has_secure_token :uuid
end
