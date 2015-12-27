Sequel.migration do
  change do
    add_column :users, :phone_number, String
  end
end
