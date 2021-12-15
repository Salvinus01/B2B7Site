class CreateB2bResumovalores < ActiveRecord::Migration
  def change
    create_table :b2b_resumovalores do |t|
	  t.integer :CodDominio, :limit => 11
	  t.integer :CodResumo, :limit => 11
	  t.string :Descricao, :limit => 45
	  t.decimal :VlrResumo, :precision => 17, :scale => 2
	  
      t.timestamps
    end
  end
end
