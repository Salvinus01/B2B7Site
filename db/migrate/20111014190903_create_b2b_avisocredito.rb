class CreateB2bAvisocredito < ActiveRecord::Migration
  def change
    create_table :b2b_avisocredito do |t|
	  t.integer :CodDominio, :limit => 11
      t.integer :NumAviso, :limit => 11
      t.integer :Situacao_Aviso, :limit => 11
      t.string :EmpresaPagadora, :limit => 100
      t.date :DataVencimento
      t.decimal :VlrBruto, :precision => 17, :scale => 2
      t.decimal :VlrDesconto, :precision => 17, :scale => 2
      t.decimal :VlrAbatimento, :precision => 17, :scale => 2
      t.decimal :VlrDevolucao, :precision => 17, :scale => 2
      t.decimal :VlrAbatimentoCredito, :precision => 17, :scale => 2
      t.decimal :VlrValorLiquido, :precision => 17, :scale => 2
      t.date :DataAntecipacao
      t.decimal :VlrAntecipacao, :precision => 17, :scale => 2
      t.integer :TamArquivo
      t.string :Domicilio, :limit => 45
      t.boolean :Status_Download
	  
      t.timestamps
    end
  end
end