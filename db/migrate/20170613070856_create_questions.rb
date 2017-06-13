class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :pregunta
      t.string :respuesta

      t.timestamps null: false
    end
  end
end
