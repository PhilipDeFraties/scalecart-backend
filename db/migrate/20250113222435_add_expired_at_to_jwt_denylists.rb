class AddExpiredAtToJwtDenylists < ActiveRecord::Migration[7.2]
  def change
    add_column :jwt_denylists, :expired_at, :datetime
  end
end
