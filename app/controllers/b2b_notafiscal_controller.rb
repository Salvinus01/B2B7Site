require 'will_paginate'
require 'csv'
require 'b2b'

class B2bNotafiscalController < ApplicationController
  
  def cancelar_notafiscal
	if (((params[:nmDataInicial].blank?) or (params[:nmDataFinal].blank?)) and (params[:nmNumNF].blank?)) \
		or (params[:nmDataInicial]["_"] == "_" or params[:nmDataFinal]["_"] == "_")
	else
		@pesquisa = B2bNotafiscal.res_cancelamento.paginate :page => params[:page], :order => 'NumNF', :per_page => 5
		
		@pesquisa = @pesquisa.where(["NumNF = ?", "#{params[:nmNumNF]}"]).group("NumNF, SerieNF") unless params[:nmNumNF].blank?
		
		unless params[:nmDataFinal].blank? or params[:nmDataInicial].blank?
			@pesquisa = @pesquisa.where(["DataHoraEmissao between ? and ? ", "#{params[:nmDataInicial].to_date}", "#{params[:nmDataFinal].to_date}"]).group("NumNF")
		end
	end	
	
	if params[:commit].to_s.upcase == "Cancelar".upcase
		redirect_to "/b2b_notafiscal/sucesso_cancelamento?" + "#{params[:idRadio1]}" + "#{params[:SerieNF]}"
	end
  end
  
  def sucesso_cancelamento	
	B2bNotafiscal.update_all("FlgCancelamento = 'S'", ["NumNF = ? and SerieNF = ?", params[:id], params[:SerieNF]])
	respond_to do |format|
      format.html 
      format.json { render json: @pesquisa }
    end
  end 
  
end
