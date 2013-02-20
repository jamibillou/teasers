class AddFromToNewsletters < ActiveRecord::Migration
  def change
    add_column :newsletters, :from, :string
  end
end
