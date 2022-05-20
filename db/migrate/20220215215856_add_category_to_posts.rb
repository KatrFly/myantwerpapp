class AddCategoryToPosts < ActiveRecord::Migration[6.1]
  def up 
    execute <<-SQL
    CREATE TYPE post_category AS ENUM ('guide', 'review', 'interview');
    SQL
    add_column :posts, :category, :post_category
  end

  def down
    remove_column :posts, :category
    execute <<-SQL
      DROP TYPE post_category
    SQL
  end
end