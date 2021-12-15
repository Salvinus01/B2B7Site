class CreateB2bProdutos < ActiveRecord::Migration
  def change
    create_table :b2b_produtos do |t|
	  t.integer :CodProduto, :limit => 11
      t.string :Descricao, :limit => 45
      t.string :QtdNF, :limit => 11
	  t.string :QtdPedido, :limit => 11
	  t.decimal :CustoNF, :precision => 17, :scale => 2
	  t.decimal :CustoPedido, :precision => 17, :scale => 2
	  t.decimal :Divergencia, :precision => 17, :scale => 2
	  
      t.timestamps
    end
  end
end
