class CreateB2bNotafiscaldivergente < ActiveRecord::Migration
  def change
    create_table :b2b_notafiscaldivergente do |t|
	  t.integer :CodDominio, :limit => 11
	  t.string :NumNF, :limit => 10
	  t.date :DataEmissao
	  t.decimal :VlrTotalNF, :precision => 17, :scale => 2
	  t.integer :CodProduto, :limit => 11
	  t.string :Descricao, :limit => 100
	  t.string :QtdNF, :limit => 11
	  t.string :QtdPedido, :limit => 11
	  t.decimal :CustoNF, :precision => 17, :scale => 2
	  t.decimal :CustoPedido, :precision => 17, :scale => 2
	  t.decimal :Divergencia, :precision => 17, :scale => 2
	  t.decimal :AliquotaIPI, :precision => 7, :scale => 2
	  t.decimal :AliquotaICMS, :precision => 7, :scale => 2
	  
      t.timestamps
    end
  end
end
