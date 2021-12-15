class CreateB2bAbatimentocredito < ActiveRecord::Migration
  def change
    create_table :b2b_abatimentocredito do |t|
	  t.integer :CodDominio, :limit => 11
	  t.string :NumAbatimento, :limit => 10
	  t.integer :NumAviso, :limit => 11
	  t.integer :CodResumo, :limit => 11
	  t.integer :Desdobro, :limit => 11
	  t.integer :CodLoja, :limit => 11
	  t.decimal :VlrCreditoDevolucao, :precision => 17, :scale => 2

      t.timestamps
    end
  end
end
