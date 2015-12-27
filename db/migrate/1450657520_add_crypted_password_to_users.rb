Sequel.migration do
  up do
    add_column :users, :crypted_password, String
    alter_table(:users) { set_column_not_null(:crypted_password) }
  end

  down do
    drop_column :users, :crypted_password
  end
end
