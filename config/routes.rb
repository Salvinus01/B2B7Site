ProjetoB2B::Application.routes.draw do
	match 'admin/error' => 'admin#error'

	root :to => 'b2b_avisocredito#avisocredito_antecipacao'
	resources :b2b_avisocredito do
		collection do
			get 'avisocredito_antecipacao', 'avisocredito_realizado', 'detalhe_avisocredito', 'solicitar_antecipacao', 
				'sucesso_antecipacao', 'detalhe_divergente','detalhe_abatimento', 'detalhe_desconto', 'imprimir',
				'avisocredito_antecipacao_validado', 'avisocredito_realizado_validado', 'detalhe_avisocredito_validado', 
				'solicitar_antecipacao_validado', 'sucesso_antecipacao_validado', 'detalhe_divergente_validado', 
				'detalhe_abatimento_validado', 'detalhe_desconto_validado', 'imprimir_validado'
		end
	end
	
	resources :b2b_notafiscal do
		collection do
			get 'cancelar_notafiscal', 'sucesso_cancelamento'
		end
	end
	
	resources :b2b_notafiscaldevolucao do
		collection do
			get 'notafiscal_devolucao', 'detalhe_devolucao', 'credito_devolucao', 'imprimir'
		end
	end
	
	match 'b2b_avisocredito/avisocredito_antecipacao', :as => :avisocredito_antecipacao
	match 'b2b_avisocredito/avisocredito_realizado', :as => :avisocredito_realizado
	match 'b2b_avisocredito/detalhe_avisocredito', :as => :detalhe_avisocredito
	match 'b2b_avisocredito/solicitar_antecipacao', :as => :solicitar_antecipacao
	match 'b2b_avisocredito/sucesso_antecipacao', :as => :sucesso_antecipacao
	match 'b2b_avisocredito/detalhe_divergente', :as => :detalhe_divergente
	match 'b2b_avisocredito/detalhe_abatimento', :as => :detalhe_abatimento
	match 'b2b_avisocredito/detalhe_desconto', :as => :detalhe_desconto
	match 'b2b_avisocredito/imprimir', :as => :imprimir
	match 'b2b_notafiscaldevolucao/notafiscal_devolucao', :as => :notafiscal_devolucao
	match 'b2b_notafiscal/cancelar_notafiscal', :as => :cancelar_notafiscal
	match 'b2b_notafiscal/sucesso_cancelamento', :as => :sucesso_cancelamento
	match 'b2b_notafiscaldevolucao/credito_devolucao', :as => :credito_devolucao
	
	
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
   match ':controller(/:action(/:id(.:format)))'
end
