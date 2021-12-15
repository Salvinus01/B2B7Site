class CreateB2bNotafiscaldevolucao < ActiveRecord::Migration
  def change
    create_table :b2b_notafiscaldevolucao do |t|
	  t.integer :CodDominio, :limit => 11
	  t.string :NumNFDevolucao, :limit => 10
	  t.string :SerieNF, :limit => 3
	  t.integer :NumAviso, :limit => 11
	  t.integer :CodResumo, :limit => 11
	  t.date :Data
	  t.integer :CodLoja, :limit => 11
	  t.decimal :VlrBruto, :precision => 17, :scale => 2
	  t.decimal :VlrCreditoDevolucao, :precision => 17, :scale => 2
	  
      t.timestamps
    end
  end
end
