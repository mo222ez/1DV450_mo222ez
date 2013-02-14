class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
	  t.references :user, :project, :status    

      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
