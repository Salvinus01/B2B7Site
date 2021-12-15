class CreateB2bNotafiscal < ActiveRecord::Migration
  def change
    create_table :b2b_notafiscal do |t|
	  t.integer :CodDominio, :limit => 11
	  t.string :NumNF, :limit => 10
	  t.string :SerieNF, :limit => 3
	  t.integer :NumAviso, :limit => 11
	  t.integer :CodResumo, :limit => 11
	  t.date :DataEmissao
	  t.date :DataRecebimento
	  t.integer :CodLoja, :limit => 11
	  t.integer :CGC, :limit => 4
	  t.decimal :VlrBruto, :precision => 17, :scale => 2
	  t.decimal :VlrDesconto, :precision => 17, :scale => 2
	  t.decimal :VlrAbatimento, :precision => 17, :scale => 2
	  
      t.timestamps
    end
  end
end
