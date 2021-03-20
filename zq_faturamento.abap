@AbapCatalog.sqlViewName: 'ZQFATURAHOJE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@Analytics.query: true
@OData.publish: true
@EndUserText.label: 'Faturamento somente o dia de hoje'
define view ZQ_FATURAMENTO_HOJE
  as select from ZC_FATURAMENTO_HOJE {
    //ZC_FATURAMENTO_LEG
    
    @EndUserText.label: 'NUMERO_FATURA'
    NUMERO_FATURA,
    @EndUserText.label: 'NOTA_FISCAL'
    NOTA_FISCAL,
    @EndUserText.label: 'TRANS_NOTA_FISCAL'
    TRANS_NOTA_FISCAL,
    @EndUserText.label: 'TIPO_DOCUMENTO'
    TIPO_DOCUMENTO,
    @EndUserText.label: 'TIPO_DOCUMENTO_DESC'
    TIPO_DOCUMENTO_DESC,
    @EndUserText.label: 'DATA_EMISSAO'
    DATA_EMISSAO,
    @EndUserText.label: 'QUANTIDADE'
    @DefaultAggregation: #SUM
    QUANTIDADE,
    @EndUserText.label: 'RECEITA_MERCADORIAS'
    @DefaultAggregation: #SUM
    RECEITA_MERCADORIAS,
    @EndUserText.label: 'FATURAMENTO_UNITARIO'
    @DefaultAggregation: #SUM
    FATURAMENTO_UNITARIO,
    @EndUserText.label: 'CLIENTE'
    CLIENTE,
    @EndUserText.label: 'CLIENTE_NOME'
    CLIENTE_NOME,
    @EndUserText.label: 'REGIONAL'
    REGIONAL,
    @EndUserText.label: 'REGIONAL_NOME'
    REGIONAL_NOME,
    @EndUserText.label: 'CENTRO'
    CENTRO,
    @EndUserText.label: 'CENTRO_DESC'
    CENTRO_DESC,
    @EndUserText.label: 'REPRESENTANTE'
    REPRESENTANTE,
    @EndUserText.label: 'REPRESENTANTE_NOME'
    REPRESENTANTE_NOME,
    @EndUserText.label: 'MATERIAL'
    MATERIAL,
    @EndUserText.label: 'MATERIAL_DESCRICAO'
    MATERIAL_DESCRICAO,
    @EndUserText.label: 'CONDICAO_PGTO'
    CONDICAO_PGTO,
    @EndUserText.label: 'CONDICAO_PGTO_DESC'
    CONDICAO_PGTO_DESC,
    @EndUserText.label: 'UF'
    UF,
    @EndUserText.label: 'CIDADE'
    CIDADE,
    @EndUserText.label: 'BAIRRO'
    BAIRRO,
    @EndUserText.label: 'GRUPO_CLIENTES'
    GRUPO_CLIENTES,
    @EndUserText.label: 'GRUPO_CLIENTESDESC'
    GRUPO_CLIENTESDESC,
    @EndUserText.label: 'CANAL'
    CANAL,
    @EndUserText.label: 'CANALDESC'
    CANALDESC,
    @EndUserText.label: 'DiasReferencia'
    cast(DATAHOJE as abap.quan( 10, 0 )) as DiasReferencia
}
