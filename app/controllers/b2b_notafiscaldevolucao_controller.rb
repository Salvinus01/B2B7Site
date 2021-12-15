require 'will_paginate'
require 'csv'
require 'b2b'

class B2bNotafiscaldevolucaoController < ApplicationController
	
  def notafiscal_devolucao
	if (((params[:nmDataInicial].blank?) or (params[:nmDataFinal].blank?)) and (params[:nmNumNF].blank?)) \
		or (params[:nmDataInicial]["_"] == "_" or params[:nmDataFinal]["_"] == "_")
	else
		@pesquisa = B2bNotafiscaldevolucao.dados_notafiscaldevolucao.paginate :page => params[:page], :order => 'NumNF', :per_page => 5
		
		unless ((params[:nmDataFinal].blank?) or (params[:nmDataInicial].blank?)) or (params[:nmDataFinal]["_"] == ["_"] or params[:nmDataInicial]["_"] == ["_"])
			@pesquisa = @pesquisa.where("DataHoraEmissao between ? and ? ", "#{params[:nmDataInicial].to_date}", "#{params[:nmDataFinal].to_date}").group("NumNF") 
		end
	
		@pesquisa = @pesquisa.where("NumNF = ?", "#{params[:nmNumNF]}").group("NumNF") unless (params[:nmNumNF].blank?)
	end
	
	case params[:commit].to_s.upcase
		when "Visualizar".upcase then
			redirect_to "/b2b_notafiscaldevolucao/detalhe_devolucao/" + "#{params[:idRadio1]}"			
		when "Imprimir".upcase then
			redirect_to "/b2b_notafiscaldevolucao/imprimir/" + "#{params[:idRadio1]}"
		when "Download".upcase then
			download_notafiscaldevolucao
	end
  end

  def detalhe_devolucao
	@dadosemitente = B2bNotafiscaldevolucao.dados_emitente.where("nfd.NumNF = ?", "#{params[:id]}")    
	@dadosremetente = B2bNotafiscaldevolucao.dados_remetente.where("nfd.NumNF = ?", "#{params[:id]}")
	@dadosproduto = B2bNotafiscaldevolucao.dados_produto.where("nfd.NumNF = ?", "#{params[:id]}")
	@dados_notafiscaldevolucao = B2bNotafiscaldevolucao.dados_notafiscaldevolucao.where("NumNF = ?", "#{params[:id]}")
	
	respond_to do |format|
	  format.html 
      format.json { render json: @dadosemitente }
	end
  end	
	
  def imprimir	
	@dadosemitente = B2bNotafiscaldevolucao.dados_emitente.where("nfd.NumNF = ?", "#{params[:id]}")    
	@dadosremetente = B2bNotafiscaldevolucao.dados_remetente.where("nfd.NumNF = ?", "#{params[:id]}")
	@dadosproduto = B2bNotafiscaldevolucao.dados_produto.where("nfd.NumNF = ?", "#{params[:id]}")
	@dados_notafiscaldevolucao = B2bNotafiscaldevolucao.dados_notafiscaldevolucao.where("NumNF = ?", "#{params[:id]}")
  end
	
  def download_notafiscaldevolucao	
	@dadosemitente = B2bNotafiscaldevolucao.dados_emitente.where("nfd.NumNF = ?", "#{params[:idRadio1]}")    
	@dadosremetente = B2bNotafiscaldevolucao.dados_remetente.where("nfd.NumNF = ?", "#{params[:idRadio1]}")
	@dadosproduto = B2bNotafiscaldevolucao.dados_produto.where("nfd.NumNF = ?", "#{params[:idRadio1]}")
	@dados_notafiscaldevolucao = B2bNotafiscaldevolucao.dados_notafiscaldevolucao.where("NumNF = ?", "#{params[:idRadio1]}")
	
	csv_string = CSV.generate(:encoding => "UTF-8") do |csv| 
		csv << ["RazaoSocial", "Endereco", "Municipio", "CNPJ/CPF", "NumNF", "Estado", "IE", "DataEmissao", "CFOP"]
			@dadosemitente.each do |e|
				csv << [e.RazaoSocial,e.Endereco, e.Cidade, e.CNPJEmissor, e.NumNF, e.Estado, e.IEEmissor, e.DataHoraEmissao, e.CFOPPadrao]
			end
		csv << ["RazaoSocial","Endereco", "Municipio", "CNPJ/CPF", "Bairro", "Estado", "IE", "CEP"]
			@dadosremetente.each do |r|
				csv << [r.RazaoSocial, r.Endereco, r.Cidade, r.CGCFornecedor, r.Bairro, r.Estado, r.InscricaoEstadual, r.CEP]
			end
		csv << ["CodProduto","Descricao", "Sit.Trib.", "Unid.", "Quant.", "ValorUnitario", "ValorTotal", "AliquotaICMS"]
			@dadosproduto.each do |p|
				csv << [p.CodProduto, p.DescProduto, p.CodSitTributaria, p.UnidadeMedida, p.QtdeFaturada, p.VlrUnitarioBruto, p.VlrLiquidoTotal, p.TaxaAliquotaICMS]
			end
		csv << ["BaseCalcICMS","ValorICMS", "BaseCalcICMSSub", "ValorTotalProdutos", "ValorFrete", "ValorSeguro", "ValorTotalIPI", "ValorTotalNota"]
			@dados_notafiscaldevolucao.each do |p|
				csv << [p.VlrBaseCalcICMS, p.VlrTotalICMSSub, p.VlrBaseCalcICMSSub, p.VlrTotalMercadorias, p.VlrTotalFrete, p.VlrTotalSeguro, p.VlrTotalIPI, p.VlrTotalNota]
			end
		csv << ["RazaoSocial", "PesoBruto", "TipoFrete", "CNPJ", "PesoLiquido", "PlacaVeiculo"]
			@dados_notafiscaldevolucao.each do |t|
				csv << [t.NomeTransp, t.TotalPesoBruto, t.TipoFrete, t.CodEANCGCTransp, t.TotalPesoLiquido, t.IdentPlaca]
			end
	end	
	send_data csv_string, :type => "text/plain",
	:filename => "Nota Fiscal Devolucao.csv",
	:disposition => 'attachment'		
  end  

end
