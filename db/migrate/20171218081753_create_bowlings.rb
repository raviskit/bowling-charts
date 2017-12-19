class CreateBowlings < ActiveRecord::Migration[5.1]
  def change
    create_table :bowlings do |t|
    	
      t.timestamps
    end
  end
end
