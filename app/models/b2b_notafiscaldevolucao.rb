class B2bNotafiscaldevolucao < ActiveRecord::Base
  set_table_name "B2B_NotaFiscalDevolucao"
	
	def self.dados_emitente
		return \
		B2bNotafiscaldevolucao.select("nfd.*, f.*")
		.from("B2B_NotaFiscalDevolucao as nfd, B2B_FornecedorEAN as f")
		.where("nfd.CodEANEmissor = f.CodEANCliente and nfd.CNPJEmissor = f.CNPJ")
	end
	
	def self.dados_remetente
		return \
		B2bNotafiscaldevolucao.select("nfd.*, f.*")
		.from("B2B_NotaFiscalDevolucao as nfd, B2B_FornecedorEAN as f")
		.where("nfd.CodEANFornecedor = f.CodEANCliente and nfd.CGCFornecedor = f.CNPJ")
    end
	
	def self.dados_produto
		return \
		B2bNotafiscaldevolucao.select("nfd.*, p.*")
		.from("B2B_NotaFiscalDevolucaoDetalhe as nfd, B2B_Produtos as p")
		.where("p.CodEANProduto = nfd.CodEANProduto")
	end
	
	def self.dados_notafiscaldevolucao
		return \
		B2bNotafiscaldevolucao.select("*")
	end
	
	class << self 
		  # number of records per page, from the will_paginate docs 
		  def per_page 
			10
		  end 
		  # takes a hash of finder conditions and returns a page number 
		  # returns 1 if nothing was found, as not to break pagination by passing page=0 
		  def last_page_number(conditions=nil) 
			total = count :all, :conditions => conditions 
			[((total - 1) / per_page) + 1, 1].max 
		  end 
	end 
end
