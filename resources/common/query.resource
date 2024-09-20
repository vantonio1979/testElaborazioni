*** Variables ***
${qAAElaboration1}              select drr.userupd,drr.dateupd
...                             from dati_rett_riga drr, categoria c
...                             where cod_scenario = '2017TEST_2'
...                             and cod_periodo = '01'
...                             and drr.provenienza like '%DEPR%'
...                             and c.cod_categoria = drr.cod_categoria
...                             and c.tipo_categoria = 'RP'
...                             order by num_Rettifica

${qAmmortamentoNE}              select drr.userupd,drr.dateupd
...                             from dati_rett_riga drr, categoria c
...                             where
...                             cod_scenario = '2017TEST_2'
...                             and cod_periodo = '01'
...                             and drr.provenienza like '%DEPR%'
...                             and c.cod_categoria = drr.cod_categoria
...                             and c.tipo_categoria = 'RC'
...                             order by num_Rettifica


${qAnnullamentoRunner}         select drr.userupd,drr.dateupd
...                            from dati_rett_riga drr
...                            where
...                            cod_scenario = '2017DE_TB'
...                            and cod_periodo = '01'
...                            and provenienza in ('PREL_REVERSE1','PREL_REVERSE2','PREL_REVERSE3')
...                            order by dateupd desc


${qCessImmb}                   select drr.userupd,drr.dateupd
...                            from dati_rett_riga drr
...                            where
...                            cod_scenario = '2017TEST_2'
...                            and cod_periodo = '01'
...                            and drr.provenienza = 'PROC_IC_PROFIT'
...                            order by num_Rettifica


${qContrFinance}               select drr.userupd,drr.dateupd
...                            from dati_rett_riga drr, categoria c
...                            where cod_scenario = '2017TEST4'
...                            and cod_periodo = '01'
...                            and drr.provenienza like 'PROC_FININV_RECL%'
...                            and c.cod_categoria = drr.cod_categoria
...                            and c.tipo_Categoria = 'RP'
...                            order by dateupd desc