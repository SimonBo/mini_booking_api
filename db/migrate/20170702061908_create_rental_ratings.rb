class CreateRentalRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :rental_ratings do |t|
      t.references :user, foreign_key: true
      t.references :rental, foreign_key: true
      t.decimal :stars

      t.timestamps
    end
  end
end
