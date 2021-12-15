require 'csv'
require 'will_paginate'

class B2bAvisocreditoController < ApplicationController
	def erro
		session[:asp_session] = nil
	end
	
	def avisocredito_antecipacao
		redirect_to "http://desenv.edivan.com.br/Aplicativos/b2b7/SessionVar.asp?Prox=b2b_avisocredito/avisocredito_antecipacao_validado"
	end
	
	def avisocredito_antecipacao_validado
		if (((params[:nmDataInicial].blank?) or (params[:nmDataFinal].blank?)) and (params[:nmNumNF].blank?) and (params[:nmItensBaixados].blank?)) \
			or (params[:nmDataInicial]["_"] == "_" or params[:nmDataFinal]["_"] == "_")
		else
			@pesquisa = B2bAvisocredito.aviso_antecipacao.paginate :page => params[:page], :order => 'NumAviso', :per_page => 5
	
			unless ((params[:nmDataFinal].blank?) or (params[:nmDataInicial].blank?)) or (params[:nmDataFinal]["_"] == "_" or params[:nmDataInicial]["_"] == "_")
				@pesquisa = @pesquisa.where(["DataVencimento between ? and ? ", "#{params[:nmDataInicial].to_date}", "#{params[:nmDataFinal].to_date}"])
			end
	
			@pesquisa = @pesquisa.where(["FlgDownload = ?", "#{params[:nmItensBaixados]}"]) unless params[:nmItensBaixados].blank?
	
			@pesquisa = @pesquisa.notafiscal.where("nf.NumNF = ?", "#{params[:nmNumNF]}").group("av.NumAviso") unless params[:nmNumNF].blank?
		end
	
		case params[:commit].to_s.upcase
			when "Visualizar".upcase then
				param = params[:Checkbox][0]
				redirect_to "/b2b_avisocredito/detalhe_avisocredito/" + "#{param}"
			when "Calcular Antecipação".upcase then
				solicitar_antecipacao
					respond_to do |format|
					format.html{render "solicitar_antecipacao"}
					end
			when "Solicitar Antecipação".upcase then
				sucesso_antecipacao
					respond_to do |format|
					format.html{render "sucesso_antecipacao"}
					end
			when "Imprimir".upcase then
				imprimir_avisocredito
					respond_to do |format|
					format.html{render "imprimir_avisocredito"}
					end
			when "Download".upcase then
				download_avisocredito
		end
	end
	
	def solicitar_antecipacao
		redirect_to "http://desenv.edivan.com.br/Aplicativos/b2b7/SessionVar.asp?Prox=b2b_avisocredito/solicitar_antecipacao_validado"
	end
	
	def solicitar_antecipacao_validado
		i=0
		check = Array.new
		while i < params[:Checkbox].size
			check[i] = params[:Checkbox][i]
			i=i+1
		end
		@arrayavisocredito = Array.new
		check.each do |f|
			@avisocredito = B2bAvisocredito.aviso_antecipacao.where("NumAviso = ?", "#{f}")
			@arrayavisocredito = @arrayavisocredito + @avisocredito
		end
	end
	
	def sucesso_antecipacao
		redirect_to "http://desenv.edivan.com.br/Aplicativos/b2b7/SessionVar.asp?Prox=b2b_avisocredito/sucesso_antecipacao_validado"
	end
	
	def sucesso_antecipacao_validado
		i=0
		check = Array.new
		while i < params[:Checkbox].size
			check[i] = params[:Checkbox][i]
			i=i+1
		end
		check.each do |x|
			B2bAvisocredito.update_all("FlgAntecipacao = 3", "NumAviso = #{x}")
		end
	end
	
	def avisocredito_realizado
		redirect_to "http://desenv.edivan.com.br/Aplicativos/b2b7/SessionVar.asp?Prox=b2b_avisocredito/avisocredito_realizado_validado"
	end
	
	def avisocredito_realizado_validado
		if (((params[:nmDataInicial].blank?) or (params[:nmDataFinal].blank?)) and (params[:nmNumNF].blank?) and (params[:nmItensBaixados].blank?)) \
			or (params[:nmDataInicial]["_"] == "_" or params[:nmDataFinal]["_"] == "_")
		else
			@pesquisa = B2bAvisocredito.aviso_realizado.paginate :page => params[:page], :order => 'NumAviso', :per_page => 5
	
			unless ((params[:nmDataFinal].blank?) or (params[:nmDataInicial].blank?)) or ((params[:nmDataFinal]["_"] == "_") or (params[:nmDataInicial]["_"] == "_"))
				@pesquisa = @pesquisa.where(["DataVencimento between ? and ? ", "#{params[:nmDataInicial].to_date}", "#{params[:nmDataFinal].to_date}"])
			end
	
			@pesquisa = @pesquisa.where(["FlgDownload = ?", "#{params[:nmItensBaixados]}"]) unless params[:nmItensBaixados].blank?
	
			@pesquisa = @pesquisa.notafiscal.where("nf.NumNF = ?", "#{params[:nmNumNF]}") unless params[:nmNumNF].blank?
		end
	
		case params[:commit].to_s.upcase
			when "Visualizar".upcase then
				param = params[:Checkbox][0]
				redirect_to "/b2b_avisocredito/detalhe_avisocredito/" + "#{param}"
			when "Imprimir".upcase then
				imprimir_avisocredito
					respond_to do |format|
					format.html{render "imprimir_avisocredito"}
					end
			when "Download".upcase then
				download_avisocredito
		end
	end
	
	def detalhe_avisocredito
		redirect_to "http://desenv.edivan.com.br/Aplicativos/b2b7/SessionVar.asp?Prox=b2b_avisocredito/detalhe_avisocredito_validado"
	end
	
	def detalhe_avisocredito_validado
		@origem = B2bAvisocredito.avisocredito.where("NumAviso = ?", "#{params[:id]}")
	
		@avisocredito = B2bAvisocredito.avisocredito.where("NumAviso = ?", "#{params[:id]}")
	
		@notasfiscais = B2bAvisocredito.paginate :page => params[:page], :order => 'NumNF', :per_page => 10
		@notasfiscais = B2bAvisocredito.notafiscal.where("av.NumAviso = ?", "#{params[:id]}")
	
		@notasfiscaisdevolucao = B2bAvisocredito.paginate :page => params[:page], :order => 'nf.NumNF', :per_page => 10
		@notasfiscaisdevolucao = B2bAvisocredito.notafiscaldevolucao.select("nf.NumNF as Nota, nf.SerieNF as Serie").where("av.NumAviso = ?", "#{params[:id]}")
	
		@abatimentocredito = B2bAvisocredito.paginate :page => params[:page], :order => 'CodAjuste', :per_page => 10
		@abatimentocredito = B2bAvisocredito.abatimentocredito.where("av.NumAviso = ?", "#{params[:id]}")
	
		@quadroresumo = B2bAvisocredito.quadroresumo.where("av.NumAviso = ?", "#{params[:id]}")
	
		@divergente = B2bAvisocredito.all
	
		case params[:commit].to_s.upcase
			when "Imprimir".upcase then
				imprimir_detalhes_aviso
					respond_to do |format|
					format.html{render "imprimir_detalhes_aviso"}
					end
			when "Download".upcase then
				download_detalhes_aviso
		end
	end
	
	def detalhe_abatimento
		redirect_to "http://desenv.edivan.com.br/Aplicativos/b2b7/SessionVar.asp?Prox=b2b_avisocredito/detalhe_abatimento_validado"
	end
	
	def detalhe_abatimento_validado
		@abatimento = B2bAvisocredito.abatimentodesconto.where("nf.NumNF = ? and nf.SerieNF = ?", "#{params[:nota]}","#{params[:serie]}")
	end
	
	def detalhe_desconto
		redirect_to "http://desenv.edivan.com.br/Aplicativos/b2b7/SessionVar.asp?Prox=b2b_avisocredito/detalhe_desconto_validado"
	end
	
	def detalhe_desconto_validado
		@desconto = B2bAvisocredito.abatimentodesconto.where("nf.NumNF = ? and nf.SerieNF = ?", "#{params[:nota]}","#{params[:serie]}")
	end
	
	def download_avisocredito
		@notafiscal = Array.new
		@notafiscaldevolucao = Array.new
		@abatimentocredito = Array.new
		@quadroresumo = Array.new
	
		params[:Checkbox].each do |x|
			B2bAvisocredito.update_all("FlgDownload = '1'", "NumAviso = #{x}")
	
			@pesquisa1 = B2bAvisocredito.notafiscal.where("nf.NumAviso = ?", x)
			@notafiscal = @notafiscal + @pesquisa1
	
			@pesquisa2 = B2bAvisocredito.notafiscaldevolucao.where("nf.NumAviso = ?", x)
			@notafiscaldevolucao = @notafiscaldevolucao + @pesquisa2
	
			@pesquisa3 = B2bAvisocredito.abatimentocredito.where("ad.NumAviso = ?", x)
			@abatimentocredito = @abatimentocredito + @pesquisa3
	
			@pesquisa4 = B2bAvisocredito.quadroresumo.where("qr.NumAviso = ?", x)
			@quadroresumo = @quadroresumo + @pesquisa4
		end
	
		csv_string = CSV.generate(:encoding => "UTF-8") do |csv|
			csv << ["NumNF","SerieNF", "Emissao", "Recebimento", "Bruto", "Desconto"]
				@notafiscal.each do |e|
					csv << [e.NumNF,e.SerieNF, e.DataHoraEmissao, e.DataHoraEntrega, e.VlrTotalFatura, e.VlrTotalDescontos]
				end
			csv << ["NumNF","SerieNF", "Data", "Bruto"]
				@notafiscaldevolucao.each do |e|
					csv << [e.NumNF, e.SerieNF, e.DataHoraEmissao, e.VlrBrutoTotal]
				end
			csv << ["NumAbatimento","Desdobro", "Loja", "CodResumo", "Descricao", "SinalAjuste", "Valor"]
				@abatimentocredito.each do |e|
			# Falta NumAbatimento - Desdobro - CodLoja
			#		csv << [e.NumAbatimento, e.Desdobro, e.CodLoja, e.CodAjuste, e.Referencia, e.SinalAjuste, e.VlrTotalAjuste]
					csv << [e.CodAjuste, e.CodAjuste, e.CodAjuste, e.CodAjuste, e.Referencia, e.SinalAjuste, e.VlrTotalAjuste]
				end
			csv << ["Codigo","Descricao", "Valor"]
				@quadroresumo.each do |e|
					csv << [e.CodAjuste, e.Referencia, e.VlrTotalAjuste]
				end
		end
		send_data csv_string, :type => "text/plain",
		:filename => "Aviso_Credito.csv",
		:disposition => 'attachment'
	end
	
	def download_detalhes_aviso
		@notafiscal = B2bAvisocredito.notafiscal.where("nf.NumAviso = ?", "#{params[:nmNumAviso]}")
		@notafiscaldevolucao = B2bAvisocredito.notafiscaldevolucao.where("nf.NumAviso = ?", "#{params[:nmNumAviso]}")
		@abatimentocredito = B2bAvisocredito.abatimentocredito.where("ad.NumAviso = ?", "#{params[:nmNumAviso]}")
		@quadroresumo = B2bAvisocredito.quadroresumo.where("qr.NumAviso = ?", "#{params[:nmNumAviso]}")
	
		csv_string = CSV.generate(:encoding => "UTF-8") do |csv|
			csv << ["NumNF","SerieNF", "Emissao", "Recebimento", "Bruto", "Desconto"]
				@notafiscal.each do |e|
					csv << [e.NumNF,e.SerieNF, e.DataHoraEmissao, e.DataHoraEntrega, e.VlrTotalFatura, e.VlrTotalDescontos]
				end
			csv << ["NumNF","SerieNF", "Data", "Bruto"]
				@notafiscaldevolucao.each do |e|
					csv << [e.NumNF, e.SerieNF, e.DataHoraEmissao, e.VlrBrutoTotal]
				end
			csv << ["NumAbatimento","Desdobro", "Loja", "CodResumo", "Descricao", "SinalAjuste", "Valor"]
				@abatimentocredito.each do |e|
			# Falta NumAbatimento - Desdobro - CodLoja
			#		csv << [e.NumAbatimento, e.Desdobro, e.CodLoja, e.CodAjuste, e.Referencia, e.SinalAjuste, e.VlrTotalAjuste]
					csv << [e.CodAjuste, e.CodAjuste, e.CodAjuste, e.CodAjuste, e.Referencia, e.SinalAjuste, e.VlrTotalAjuste]
				end
			csv << ["Codigo","Descricao", "Valor"]
				@quadroresumo.each do |e|
					csv << [e.CodAjuste, e.Referencia, e.VlrTotalAjuste]
				end
		end
		send_data csv_string, :type => "text/plain",
		:filename => "Detalhes_AvisoCredito.csv",
		:disposition => 'attachment'
	end
	
	def imprimir_avisocredito
		redirect_to "http://desenv.edivan.com.br/Aplicativos/b2b7/SessionVar.asp?Prox=b2b_avisocredito/imprimir_avisocredito_validado"
	end
	
	def imprimir_avisocredito_validado
		i=0
		check = Array.new
		while i < params[:Checkbox].size
			check[i] = params[:Checkbox][i]
			i=i+1
		end
		@arrayavisocredito = Array.new
		@arraynotasfiscais = Array.new
		@arraynotasfiscaisdevolucao = Array.new
		@arrayabatimentocredito = Array.new
		@arrayquadroresumo = Array.new
	
		check.each do |f|
			@avisocredito = B2bAvisocredito.avisocredito.where("NumAviso = ?", "#{f}")
			@arrayavisocredito = @arrayavisocredito + @avisocredito
	
			@notasfiscais = B2bAvisocredito.notafiscal.where("nf.NumAviso = ?", "#{f}")
			@arraynotasfiscais = @arraynotasfiscais + @notasfiscais
	
			@notasfiscaisdevolucao = B2bAvisocredito.notafiscaldevolucao.where("nf.NumAviso = ?", "#{f}")
			@arraynotasfiscaisdevolucao = @arraynotasfiscaisdevolucao + @notasfiscaisdevolucao
	
			@abatimentocredito = B2bAvisocredito.abatimentocredito.where("ad.NumAviso = ?", "#{f}")
			@arrayabatimentocredito = @arrayabatimentocredito + @abatimentocredito
	
			@quadroresumo = B2bAvisocredito.quadroresumo.where("qr.NumAviso = ?", "#{f}")
			@arrayquadroresumo = @arrayquadroresumo + @quadroresumo
		end
	end
	
	def imprimir_detalhes_aviso
		redirect_to "http://desenv.edivan.com.br/Aplicativos/b2b7/SessionVar.asp?Prox=b2b_avisocredito/imprimir_detalhes_aviso_validado"
	end
	
	def imprimir_detalhes_aviso_validado
		@avisocredito = B2bAvisocredito.avisocredito.where("NumAviso = ?", "#{params[:nmNumAviso]}")
		@notasfiscais = B2bAvisocredito.notafiscal.where("nf.NumAviso = ?", "#{params[:nmNumAviso]}")
		@notasfiscaisdevolucao = B2bAvisocredito.notafiscaldevolucao.where("nf.NumAviso = ?", "#{params[:nmNumAviso]}")
		@abatimentocredito = B2bAvisocredito.abatimentocredito.where("ad.NumAviso = ?", "#{params[:nmNumAviso]}")
		@quadroresumo = B2bAvisocredito.quadroresumo.where("qr.NumAviso = ?", "#{params[:nmNumAviso]}")
	end
end