# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111026115016) do

  create_table "b2b_abatimentocredito", :id => false, :force => true do |t|
    t.integer  "id",                                                                :null => false
    t.integer  "CodDominio",                                                        :null => false
    t.string   "NumAbatimento",        :limit => 10,                                :null => false
    t.integer  "NumAviso",                                                          :null => false
    t.integer  "CodResumo",                                                         :null => false
    t.integer  "Desdobro"
    t.integer  "CodLoja"
    t.decimal  "VlrAbatimentoCredito",               :precision => 17, :scale => 2
    t.datetime "created_at",                                                        :null => false
    t.datetime "updated_at",                                                        :null => false
  end

  create_table "b2b_avisocredito", :id => false, :force => true do |t|
    t.integer  "id",                                                                 :null => false
    t.integer  "CodDominio",                                                         :null => false
    t.integer  "NumAviso",                                                           :null => false
    t.boolean  "Situacao_Aviso"
    t.string   "EmpresaPagadora",      :limit => 100,                                :null => false
    t.date     "DataVencimento"
    t.decimal  "VlrBruto",                            :precision => 17, :scale => 2
    t.decimal  "VlrDesconto",                         :precision => 17, :scale => 2
    t.decimal  "VlrAbatimento",                       :precision => 17, :scale => 2
    t.decimal  "VlrDevolucao",                        :precision => 17, :scale => 2
    t.decimal  "VlrAbatimentoCredito",                :precision => 17, :scale => 2
    t.decimal  "VlrLiquido",                          :precision => 17, :scale => 2
    t.date     "DataAntecipacao"
    t.decimal  "VlrAntecipacao",                      :precision => 17, :scale => 2
    t.integer  "TamArquivo"
    t.string   "Domicilio",            :limit => 45
    t.boolean  "Situacao_Download",                                                  :null => false
    t.string   "Conta",                :limit => 10
    t.string   "Agencia",              :limit => 8
    t.integer  "Banco"
    t.string   "NumContrato",          :limit => 30
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
  end

  create_table "b2b_notafiscal", :id => false, :force => true do |t|
    t.integer  "id",                                                           :null => false
    t.integer  "CodDominio",                                                   :null => false
    t.string   "NumNF",           :limit => 10,                                :null => false
    t.string   "SerieNF",         :limit => 3,                                 :null => false
    t.integer  "NumAviso",                                                     :null => false
    t.integer  "CodResumo"
    t.date     "DataEmissao"
    t.date     "DataRecebimento"
    t.integer  "CodLoja"
    t.integer  "CGC"
    t.decimal  "VlrBruto",                      :precision => 17, :scale => 2
    t.decimal  "VlrDesconto",                   :precision => 17, :scale => 2
    t.decimal  "VlrAbatimento",                 :precision => 17, :scale => 2
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
  end

  create_table "b2b_notafiscaldevolucao", :id => false, :force => true do |t|
    t.integer  "id",                                                               :null => false
    t.integer  "CodDominio",                                                       :null => false
    t.string   "NumNFDevolucao",      :limit => 10,                                :null => false
    t.string   "SerieNFDevolucao",    :limit => 3,                                 :null => false
    t.integer  "NumAviso",                                                         :null => false
    t.integer  "CodResumo",                                                        :null => false
    t.date     "Data"
    t.integer  "CodLoja"
    t.decimal  "VlrBruto",                          :precision => 17, :scale => 2
    t.decimal  "VlrCreditoDevolucao",               :precision => 17, :scale => 2
    t.datetime "created_at",                                                       :null => false
    t.datetime "updated_at",                                                       :null => false
  end

  create_table "b2b_notafiscaldivergente", :id => false, :force => true do |t|
    t.integer  "id",                                                         :null => false
    t.integer  "CodDominio",                                                 :null => false
    t.string   "NumNF",        :limit => 10,                                 :null => false
    t.date     "DataEmissao"
    t.decimal  "VlrTotalNF",                  :precision => 17, :scale => 2
    t.integer  "CodProduto"
    t.string   "Descricao",    :limit => 100
    t.string   "QtdNF",        :limit => 11
    t.string   "QtdPedido",    :limit => 11
    t.decimal  "CustoNF",                     :precision => 17, :scale => 2
    t.decimal  "CustoPedido",                 :precision => 17, :scale => 2
    t.decimal  "Divergencia",                 :precision => 17, :scale => 2
    t.decimal  "AliquotaIPI",                 :precision => 7,  :scale => 2
    t.decimal  "AliquotaICMS",                :precision => 7,  :scale => 2
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
  end

  create_table "b2b_produtos", :force => true do |t|
    t.integer  "CodProduto"
    t.string   "Descricao",   :limit => 45
    t.string   "QtdNF",       :limit => 11
    t.string   "QtdPedido",   :limit => 11
    t.decimal  "CustoNF",                   :precision => 17, :scale => 2
    t.decimal  "CustoPedido",               :precision => 17, :scale => 2
    t.decimal  "Divergencia",               :precision => 17, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "b2b_resumovalores", :id => false, :force => true do |t|
    t.integer  "id",                                                      :null => false
    t.integer  "CodDominio",                                              :null => false
    t.integer  "CodResumo",                                               :null => false
    t.string   "Descricao",  :limit => 45,                                :null => false
    t.decimal  "VlrResumo",                :precision => 17, :scale => 2
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
  end

end
