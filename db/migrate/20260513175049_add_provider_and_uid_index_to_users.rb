class AddProviderAndUidIndexToUsers < ActiveRecord::Migration[6.1]
  def change
    add_index :o_auth_providers, [:provider, :uid]
  end
end
