class User < ApplicationRecord
  authenticates_with_sorcery!

  # パスワードの長さが3文字以上であることを検証
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  # パスワードとパスワード確認が一致していることを検証
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  # パスワード確認の存在を検証
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  # 姓の存在と長さ（最大255文字）を検証
  validates :first_name, presence: true, length: { maximum: 255 }
  # 名の存在と長さ（最大255文字）を検証
  validates :last_name, presence: true, length: { maximum: 255 }
  # メールの存在、ユニーク性を検証
  validates :email, presence: true, uniqueness: true

  has_many :boards, dependent: :destroy
end
