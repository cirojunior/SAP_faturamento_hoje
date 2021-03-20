@AbapCatalog.sqlViewName: 'ZCFATHJ'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@Analytics.dataCategory: #CUBE
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Query para ligar com legado'
define view ZC_FATURAMENTO_HOJE
 as select from ZC_FATURAMENTO_LEG as Fat
    inner join ZC_FATURAMENTO_LEG_DIFDATA       as DatAtual    on DatAtual.NUMERO_FATURA       = Fat.NUMERO_FATURA 
      
{
  Fat.NUMERO_FATURA,
  Fat.NOTA_FISCAL,
  Fat.TRANS_NOTA_FISCAL,
  Fat.TIPO_DOCUMENTO,
  Fat.TIPO_DOCUMENTO_DESC,
  Fat.DATA_EMISSAO,
  Fat.QUANTIDADE,
  Fat.RECEITA_MERCADORIAS,
  Fat.FATURAMENTO_UNITARIO,
  Fat.CLIENTE,
  Fat.CLIENTE_NOME,
  Fat.REGIONAL,
  Fat.REGIONAL_NOME,
  Fat.CENTRO,
  Fat.CENTRO_DESC,
  Fat.REPRESENTANTE,
  Fat.REPRESENTANTE_NOME,
  Fat.MATERIAL,
  Fat.MATERIAL_DESCRICAO,
  Fat.CONDICAO_PGTO,
  Fat.CONDICAO_PGTO_DESC,
  Fat.UF,
  Fat.CIDADE,
  Fat.BAIRRO,
  Fat.GRUPO_CLIENTES,
  Fat.GRUPO_CLIENTESDESC,
  Fat.CANAL,
  Fat.CANALDESC,
  Fat.DATAHOJE,
  Fat.MOTIVOORDEM,
  Fat.MOTIVOORDEMDESC,
  Fat.NOTA_CANCELADA 
}
where DATA_ULT_ALT                >= dats_add_days(DatAtual.DATAHOJE, -5, 'FAIL') 
       or (DatAtual.DATA_EMISSAO  >= dats_add_days(DatAtual.DATAHOJE, -5, 'FAIL') 
           and  DATA_ULT_ALT       = '00000000') 
                                                                      

union all

select from ZC_FATURAMENTO_LEG as Canc
    inner join ZC_FATURAMENTO_LEG_DIFDATA       as DatAtual    on DatAtual.NUMERO_FATURA       = Canc.NUMERO_FATURA 
                                                          
{
  Canc.NUMERO_FATURA,
  Canc.NOTA_FISCAL,
  Canc.TRANS_NOTA_FISCAL,
  Canc.TIPO_DOCUMENTO,
  Canc.TIPO_DOCUMENTO_DESC,
  Canc.DATA_EMISSAO,
  (Canc.QUANTIDADE * -1)          as QUANTIDADE,
  (Canc.RECEITA_MERCADORIAS * -1) as RECEITA_MERCADORIAS,
  Canc.FATURAMENTO_UNITARIO,
  Canc.CLIENTE,
  Canc.CLIENTE_NOME,
  Canc.REGIONAL,
  Canc.REGIONAL_NOME,
  Canc.CENTRO,
  Canc.CENTRO_DESC,
  Canc.REPRESENTANTE,
  Canc.REPRESENTANTE_NOME,
  Canc.MATERIAL,
  Canc.MATERIAL_DESCRICAO,
  Canc.CONDICAO_PGTO,
  Canc.CONDICAO_PGTO_DESC,
  Canc.UF,
  Canc.CIDADE,
  Canc.BAIRRO,
  Canc.GRUPO_CLIENTES,
  Canc.GRUPO_CLIENTESDESC,
  Canc.CANAL,
  Canc.CANALDESC,
  Canc.DATAHOJE,
  Canc.MOTIVOORDEM,
  Canc.MOTIVOORDEMDESC,
  Canc.NOTA_CANCELADA 

}
where Canc.NOTA_CANCELADA = 'S'
  and (DATA_ULT_ALT                >= dats_add_days(DatAtual.DATAHOJE, -5, 'FAIL') 
       or (DatAtual.DATA_EMISSAO   >= dats_add_days(DatAtual.DATAHOJE, -5, 'FAIL') 
           and  DATA_ULT_ALT        = '00000000') )
