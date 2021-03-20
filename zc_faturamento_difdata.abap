@AbapCatalog.sqlViewName: 'ZCFATLEGDIFDATA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Diferença entre as datas faturado e hoje'
define view ZC_FATURAMENTO_LEG_DIFDATA
  as select from vbrk as Fat
{
  Fat.vbeln             as NUMERO_FATURA,
  $session.system_date  as DATAHOJE,
  aedat                 as DATA_ULT_ALT,
  fkdat                 as DATA_EMISSAO
}
 
  
  
