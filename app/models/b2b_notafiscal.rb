class B2bNotafiscal < ActiveRecord::Base
  set_table_name "B2B_NotaFiscal"

	def self.res_cancelamento
	   return B2bNotafiscal.select("*").where("FlgCancelamento = 'N'").group("NumNF, SerieNF")
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
