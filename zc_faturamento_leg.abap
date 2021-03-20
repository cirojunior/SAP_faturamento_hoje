@AbapCatalog.sqlViewName: 'ZCFATLEG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@Analytics.dataCategory: #CUBE
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Query para ligar com legado'
define view ZC_FATURAMENTO_LEG
  as select from    ZI_BillingDocumentItemCube (P_ExchangeRateType: 'M', P_DisplayCurrency: 'BRL') as Fat
    inner join      tvfkt                                                                          as Tipo        on  Tipo.fkart = Fat.BillingDocumentType
                                                                                                                  and Tipo.spras = 'P'
    inner join      t171t                                                                          as Regional    on  Regional.bzirk = Fat.SalesDistrict
                                                                                                                  and Regional.spras = 'P'
    inner join      makt                                                                           as Material    on Material.matnr = Fat.Material
    inner join      tvzbt                                                                          as Condicao    on  Condicao.zterm = Fat.CustomerPaymentTerms
                                                                                                                  and Condicao.spras = 'P'
    inner join      kna1                                                                           as Cliente     on Cliente.kunnr = Fat.SoldToParty
    inner join      knvv                                                                           as Grupo       on Grupo.kunnr = Fat.SoldToParty
    inner join      t151t                                                                          as GrupoDes    on  GrupoDes.kdgrp = Grupo.kdgrp
                                                                                                                  and GrupoDes.spras = 'P'
    inner join      tvk1t                                                                          as CanalDes    on  CanalDes.katr1 = Cliente.katr1
                                                                                                                  and CanalDes.spras = 'P'
    inner join      ZC_FATURAMENTO_LEG_DIFDATA                                                     as DatAtual    on DatAtual.NUMERO_FATURA = Fat.BillingDocument
    left outer join tvaut                                                                          as MOTIVORDDES on  MOTIVORDDES.augru = Fat.SDDocumentReason
                                                                                                                  and MOTIVORDDES.spras = 'P'
{
  Fat.BillingDocument                                        as NUMERO_FATURA,
  Fat.DocumentReferenceID                                    as NOTA_FISCAL,
  Fat.BillingDocument                                        as TRANS_NOTA_FISCAL,
  Fat.BillingDocumentType                                    as TIPO_DOCUMENTO,
  Tipo.vtext                                                 as TIPO_DOCUMENTO_DESC,
  Fat.BillingDocumentDate                                    as DATA_EMISSAO,
  Fat.BillingQuantityInBaseUnit                              as QUANTIDADE, //Zaniratti AMS-4033
  Fat.Subtotal1Amount                                        as RECEITA_MERCADORIAS,
  Fat.Subtotal19Amount                                       as FATURAMENTO_UNITARIO,
  Fat.SoldToParty                                            as CLIENTE,
  Fat.SoldToPartyName                                        as CLIENTE_NOME,
  Fat.SalesDistrict                                          as REGIONAL,
  Regional.bztxt                                             as REGIONAL_NOME,
  Fat.Plant                                                  as CENTRO,
  Fat.PlantName                                              as CENTRO_DESC,
  Fat.Representante                                          as REPRESENTANTE,
  Fat.RepresentanteName                                      as REPRESENTANTE_NOME,
  Fat.Material                                               as MATERIAL,
  Material.maktx                                             as MATERIAL_DESCRICAO,
  Fat.CustomerPaymentTerms                                   as CONDICAO_PGTO,
  Condicao.vtext                                             as CONDICAO_PGTO_DESC,
  Cliente.regio                                              as UF,
  Cliente.ort01                                              as CIDADE,
  Cliente.ort02                                              as BAIRRO,
  Grupo.kdgrp                                                as GRUPO_CLIENTES,
  GrupoDes.ktext                                             as GRUPO_CLIENTESDESC,
  Cliente.katr1                                              as CANAL,
  CanalDes.vtext                                             as CANALDESC,
  dats_days_between( Fat.LastChangeDate, DatAtual.DATAHOJE ) as DATAHOJE,
  Fat.SDDocumentReason                                       as MOTIVOORDEM,
  MOTIVORDDES.bezei                                          as MOTIVOORDEMDESC,
  case when (Fat.BillingDocumentIsCancelled <> '' 
         or  Fat.CancelledBillingDocument   <> '' 
            )  
    then 'S' 
    else 'N'
  end                                                        as NOTA_CANCELADA
  

}

