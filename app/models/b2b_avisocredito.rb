class B2bAvisocredito < ActiveRecord::Base
  set_table_name "B2B_AvisoCredito"

	def self.avisocredito
	   return \
	   B2bAvisocredito.select("*")
	end

	def self.aviso_antecipacao
	   return \
	   B2bAvisocredito.select("*")
	   .where("FlgAviso = '0'")
	end

	def self.aviso_realizado
	   return \
	   B2bAvisocredito.select("*")
	   .where("FlgAviso = '1'")
	end

	def self.notafiscal
		return \
		B2bAvisocredito.select("av.*, nf.*")
		.from("B2B_AvisoCredito as av, B2B_NotaFiscal as nf")
		.where("av.NumAviso = nf.NumAviso")
	end

	def self.notafiscaldevolucao
		return \
		B2bAvisocredito.select("av.*, nf.*, nfd.*")
		.from("B2B_AvisoCredito as av, B2B_NotaFiscalDevolucao as nf, B2B_NotaFiscalDevolucaoDetalhe as nfd")
		.where("av.NumAviso = nf.NumAviso and nf.NumNF = nfd.NumNF and nf.SerieNF = nfd.SerieNF")
	end

	def self.abatimentocredito
		return \
		B2bAvisocredito.select("av.*, ad.*")
		.from("B2B_AvisoCredito as av, B2B_AbatimentoDesconto as ad")
		.where("av.NumAviso = ad.NumAviso")
	end

	def self.quadroresumo
		return \
		B2bAvisocredito.select("av.*, qr.*")
		.from("B2B_AvisoCredito as av, B2B_QuadroResumo as qr")
		.where("av.NumAviso = qr.NumAviso")
	end
	
	def self.abatimentodesconto
		return \
		B2bAvisocredito.select("av.*, qr.*, nf.*")
		.from("B2B_AvisoCredito as av, B2B_QuadroResumo as qr, B2B_NotaFiscal as nf")
		.where("av.NumAviso = qr.NumAviso and qr.CodEANEmissor = nf.CodEANEmissor")
	end

	class << self
		  # number of records per page, from the will_paginate docs
		  def per_page
			16
		  end
		  # takes a hash of finder conditions and returns a page number
		  # returns 1 if nothing was found, as not to break pagination by passing page=0
		  def last_page_number(conditions=nil)
			total = count :all, :conditions => conditions
			[((total - 1) / per_page) + 1, 1].max
		  end
	end

end
