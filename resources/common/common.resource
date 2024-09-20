*** Settings ***
Library     SeleniumLibrary
Library     DatabaseLibrary
Library     OperatingSystem
Library     JSONLibrary
Library     Collections
#Library    RPA.Desktop
#Library    RPA.Browser
Resource    ../processi/consolidato/cruscotto/contributor/AmmortizzamentoAzieneElaboration.resource
Resource    tgkCruscotto.resource
Resource    tgkElaborazioniFlow.resource
Resource    tgkElaborazioniJOB.resource

*** Variables ***

${url}      https://cpm-man-trunk-3.platformteam.saastagetik.com/tagetikcpm
${user}     A.VORRARO
${pass}     pass


*** Keywords ***

TGKWaitResultOK
    Connect To Database    psycopg2    ${DBNamerep}    ${DBUserrep}    ${DBPassrep}    ${DBHostrep}    ${DBPortrep}
    set global variable  ${esitotest}  0
    #Faccio il controllo sulla rep_teic per verificare che non ci sono elaborazioni in esecuzione
    #dal utente del test
    #recupero il numero di elaborazione in corso per utente loggato
    #Log To Console    Elaborazioni in corso
    Log To Console    Inizio TGKWaitResultOK
    ${elab}    Get Text    //*[@id="tgk.main.header"]/div/div/div[3]/div/div[6]/div/div/div[3]/div
    ${elabflag}=    Set Variable    ${elab}[0]
    Set Global Variable    ${esitotest}
    Log To Console    Attendo che inizia l'elaborazione
    ${orainizio}=       Get Current Date  result_format=%H:%M:%S
    ${elabstart}=   Set Variable    0
    Log To Console    In attesa di start elaborazione
    WHILE    "${elabflag}" == "0"
        ${elab}    Get Text    //*[@id="tgk.main.header"]/div/div/div[3]/div/div[6]/div/div/div[3]/div
        ${elabflag}=    Set Variable    ${elab}[0]
        ${oraCiclo}=      Get Current Date  result_format=%H:%M:%S
        ${time}=    Subtract Time From Time    ${oraCiclo}    ${orainizio}
         ${trovato}  Get Element Count    //*[text()="Close"]
        IF  ${trovato} > 0
                Click Element    //*[text()="Close"]/../../..
                Sleep    2s
        END
        IF    "${time}" == "60.0"
             Log To Console    finito tempo attesa
             ${elabflag}=    Set Variable    1
             ${elabstart}=    Set Variable    1
             set global variable  ${esitotest}  0
             ${trovato}  Get Element Count    //*[text()="Close"]
            IF  ${trovato} > 0
                Log To Console    Close trovato
            ELSE
                Log To Console    Close non trovato
                 ${trovato}  Get Element Count    //*[text()="Export"]
            END
                Log To Console    Close non trovato
                Click Element    //*[@class="v-icon tagetik-icon-font"]/../../../../..
         END
    END
    Log To Console    Fine attesa elaborazione
    IF    ${elabstart} == 0
        Log To Console    Elaborazione iniziata
        ${elab}    Get Text    //*[@id="tgk.main.header"]/div/div/div[3]/div/div[6]/div/div/div[3]/div
        ${elabflag}=    Set Variable    ${elab}[0]
        Log To Console    ${elab}[0]
        Log To Console    Attendo che finisce elaborazione
        Log To Console    Elaborazione conclusa
        ${querycount}=     Set Variable    select cod_utente,creation_date from rep_teic rt where "cod_utente"='${userapp}' order by creation_date
        ${counter} =    Row Count    ${querycount}
        ${queryRepTeic}=    Set Variable    select cod_utente,creation_date from rep_teic rt where "cod_utente"='${userapp}' order by creation_date  desc
        @{result}=  Query    ${queryRepTeic}[0]
        ${dataoggi}=     Get Current Date
        Log To Console    data inizio
        Log To Console    ${dataoggi}
        Log To Console    ${dataoggi}
        ${orainizio}=       Get Current Date  result_format=%H:%M:%S
        Log To Console    Valore di ora inizio
        Log To Console    ${orainizio}
       ${orainizio}=       Get Current Date  result_format=%H:%M:%S
        WHILE    ${counter} > 0
            ${counter} =    Row Count    ${querycount}
            ${oraCiclo}=      Get Current Date  result_format=%H:%M:%S
            ${time}=    Subtract Time From Time    ${oraCiclo}    ${orainizio}
            IF    "${time}" == "10.0"
                 ${counter}=    Set Variable    1
            END
        END

        ${queryAuditOp}=    Set Variable    select oid from rep_audit_operazione where "utente" ='${userapp}' order by op_time desc
        Log To Console    ${queryAuditOp}
        @{result}=  Query    ${queryAuditOp}
        Log To Console    Oid trovato
        Log To Console    ${result[0]}[0]
        ${queryEsito}=      Set Variable    select esito,rep_audit_operazione_oid from rep_audit_logs where "rep_audit_operazione_oid"='${result[0]}[0]'
        Log To Console    ${queryEsito}
        @{result}=  Query    ${queryEsito}
        Log To Console    Esito trovato
        Log To Console    ${result[0]}[0]
        ${esito}=   Set Variable    ${result[0]}[0]
        @{valori}=   Create List      ${0}     ${1}   ${2}
        IF    ${esito} in @{valori}
            set global variable  ${esitotest}  1
            Log To Console    Elaborazione conclusa con successo
            Sleep    5s
            Go To    https://cpm-man-trunk-3.platformteam.saastagetik.com/tagetikcpm/
        ELSE
            set global variable  ${esitotest}  0
            Log To Console    Elaborazione fallita
            Sleep    5s
            Go To    https://cpm-man-trunk-3.platformteam.saastagetik.com/tagetikcpm/
        END
    END

    #[Return]  -1

TGKWaitResult
    Sleep    1s
    #Click Element    //*[text()="Run"]/../..
    ${condition}=    Run Keyword And Ignore Error   Wait Until Page Contains Element   //*[text()="Continue"]    timeout=5s
    Sleep    1s

    IF    "${condition}[0]" != "FAIL"
        Click Element    //*[text()="Continue"]/../..
    END
    #Log To Console    Finito!!
    #Wait Until Element Is Visible    //*[text()="1/1"]
    #Wait Until Page Contains Element    //*[text()="0/0"]
    #Wait Until Element Is Visible    //*[text()="0/0"]      timeout=1000s
    Sleep    2s
    Wait Until Page Contains Element    //*[text()="Close"]     timeout=10000s
    ${trovato}  Get Element Count    //*[text()="Close"]
    IF  ${trovato} > 0
        Click Element    //*[text()="Close"]/../../..
    ELSE
        Click Element    //div[@class="v-label v-widget v-label-undef-w tgk-header-button-label v-label-tgk-header-button-label" and contains(text(),'/')]
        Sleep    5s
    END
    Sleep    2
    Click Element    //*[@class="v-icon tagetik-icon-font"]/../../../../..


TGK_Test_Elab
    [Arguments]    ${percorsoFile}
    #Log To Console    ${percorsoFile}
    #${result}=    Run Keyword And Ignore Error   TGKRunElabOk    ${user}     ${percorsoFile}
    TGKRunElabOk    ${user}     ${percorsoFile}
    ${esito}=     Set Variable      ${result}[0]
    IF    "${esito}" != "PASS"
        Log To Console    fallito
        Fermo il test ed esco
        Fatal Error
    END
    #    Click Element    //*[text()="Continue"]/../..
    ${id}   ${codElab}  ${codProcesso}  ${codAnno}  ${codPeriodo}   ${codAmbiente}  ${profiloUtente}    ${cruscotto}    ${codjob}   ${codentity}    ${codDescription}   ${urlcockpit}      ${pathelab}  ${pathcruscotto}    ${scheda}   ${tipoScheda}     ${codiceTab}    ${consolidatoreNode}     ${schedaCruscotto}   ${valoreTipoScheda}     ${cruscottoflow}    ${codiceTabContributor}     ${flagEntity}       ${flagGroup}    ${flagConsolidation}    ${flagPeriodoScendario}     ${queries}      TGKGetMultiplePropertyFromJson  ${percorsoFile}
    Sleep    2s
    #TGK_Leggi_dati_DB1      ${user}     ${queries}
    #Eseguuo l'elaborazione da job
    #${esitoTest}=   TGKEseguiJob    ${codjob}
    #Log To Console    Valore di esitoTest in test
    #Log To Console    ${esitoTest}
    #${result}=    Run Keyword And Ignore Error      TGKEseguiJob    ${codjob}
    #${esito}=     Set Variable      ${result}[0]
    #IF    "${esito}" != "PASS"
    #    Log To Console    fallito
    #END
    #TGK_Leggi_dati_DB1      ${user}     ${queries}
    #Eseguo l'elaborazione da flow
    #${result}=    Run Keyword And Ignore Error      TGKEseguiFlow       ${codProcesso}  ${codAnno}  ${codPeriodo}   ${codiceTab}    ${cruscotto}    ${codentity}    ${urlelab}      ${codDescription}   ${cruscottoflow}    ${codiceTabContributor}
    #IF    "${esito}" != "PASS"
    #    Log To Console    fallito
    #END
    #TGK_Leggi_dati_DB1      ${user}     ${queries}


TGK_CustomDataProcessing
    [Arguments]    ${scheda}    ${flagEntity}       ${flagGroup}    ${flagConsolidation}    ${flagPeriodoScendario}
    #Click Element    //*[text()="Consolidation data processing"]/../..
    #Click Element    (//span[@tabindex="-1"])[5]
    Open Context Menu   (//span[@tabindex="-1"])[5]
    Sleep    2s
    Click Element    (//span[text()="Custom"])/..
    Sleep    2s
    Log To Console    Apro la popup customdata
    TGKSelezionaFlagConsDataProces      ${flagEntity}    ${flagGroup}    ${flagConsolidation}   ${flagPeriodoScendario}


TGK_EntityDataProcessing
    [Arguments]    ${valoreTipoScheda}
    Wait Until Page Contains Element    //*[text()="Run"]/..    timeout=20s
    IF    "${valoreTipoScheda}" == "*"
            #Wait Until Page Contains Element    //*[text()="Run"]/..    timeout=20s
            Sleep    2s
            Click Element    //*[text()="Run"]/../..
            Sleep    2s
    ELSE
             Sleep    1s
             Click Element     (//input[@type='checkbox'])[3]/..
             Sleep    1s
             #Click Element     (//input[@type='checkbox'])[${valoreTipoScheda}]/..
             Click Element      //*[text()="${valoreTipoScheda}"]
             Sleep    2s
             Click Element    //*[text()="Run"]/../..
             Sleep    2s
    END
    #Sleep    1s
    ${condition}=    Run Keyword And Ignore Error   Wait Until Page Contains Element   //*[text()="Continue"]    timeout=5s
    #Sleep    1s
    #Log To Console    valore di condition
    #Log To Console    ${condition}[0]
    IF    "${condition}[0]" != "FAIL"
        Log To Console    tasto trovato
        Click Element    //*[text()="Continue"]/../..
    ELSE
        Log To Console    tasto non trovato
    END
    ${esitoTest}=       TGKWaitResultOK
    #Log To Console    Finito!!


TGKSetupTest
    Sleep    10s
    ${urllogin}=    Set Variable    ${urlbase}${currentversion}
    #${urllogin}=    Set Variable    https://cpm-man-5328-3.platformteam.saastagetik.com/tagetikcpm
    ${urlelab}=  Set Variable    /cockpit/contributor/${dbnameapp}
    #Eseguo il login sul cpm
    ${usertemp}=     TGKControllaParametro    1
    ${userpass}=     TGKControllaParametro    2
    #Log To Console    valore di usertemp
    #Log To Console    ${usertemp}
    Set Global Variable    ${userapp}    ${usertemp}
    @{valori}=   Create List      ${0}     ${1}   ${2}
    Set Global Variable    @{valori}
    #Log To Console    valore di userapp
    #Log To Console    ${userapp}
    Login    ${urllogin}    ${userapp}    ${userpass}

TGKRunElaboration    
    [Arguments]     ${profiloUtente}     ${codProcesso}  ${codAnno}  ${codPeriodo}   ${cruscotto}    ${codentity}    ${urlelab}  ${scheda}    ${valoreScheda}    ${consolidatoreNode}
    Log To Console    ${profiloUtente}
    TGKSelezionaProcesso    ${codProcesso}    ${codAnno}    ${codPeriodo}
    Sleep    5s
    TGK_WaitAndClickElement     //*[text()="Consolidator"]
    #TGKSelezionaCruscotto    ${cruscotto}
    Sleep    5s


    #TGK_WaitAndClickElement    //*[text()="${valoreScheda}"]/..
    Sleep    5s


TGKBuildURLElab
    [Arguments]    ${pathcruscotto}    ${dbnameapp}     ${pathelab}
    ${currentURL}=   Get Location
    @{my_list}=    Create List    ${currentURL.split('#')}
    ${urlprefisso}=    Set Variable    @{my_list}[0]
    ${urlelab}=  Set Variable    /cockpit/contributor/${dbnameapp}
    ${urlelab}=     Set Variable    ${urlprefisso}[0]#!/${pathcruscotto}/${dbnameapp}/${pathelab}
    [Return]    ${urlelab}


TGK_WaitAndClickElement
    [Documentation]    Wait the provided element and click on it
    [Arguments]    ${element}    ${timeout}=4s
    log    [commons] Wait and Click Element
    Wait Until Page Contains Element    ${element}
    Click Element    ${element}


TGKGetMultiplePropertyFromJson
    [Arguments]     ${percorsoFile}
    ${data}=	Load Json From File	    ${percorsoFile}
    #Log To Console    valore di data
    #Log To Console    ${data}
    ${id}=      Get Value From Json    ${data}    $..id
    ${codElab}=      Get Value From Json    ${data}    $..codiceElab
    ${codProcesso}=      Get Value From Json    ${data}    $..codProcesso
    ${codAnno}=      Get Value From Json    ${data}    $..codAnno
    ${codPeriodo}=      Get Value From Json    ${data}    $..codPeriodo
    ${codAmbiente}=      Get Value From Json    ${data}    $..codAmbiente
    ${profiloUtente}=      Get Value From Json    ${data}    $..profiloUtente
    ${cruscotto}=      Get Value From Json    ${data}    $..cruscotto
    ${schedaCruscotto}=      Get Value From Json    ${data}    $..schedaCruscotto
    ${codjob}=      Get Value From Json    ${data}    $..codjob
    ${codentity}=      Get Value From Json    ${data}    $..codEntity
    ${consolidatoreNode}=      Get Value From Json    ${data}    $..consolidatoreNode
    ${codDescription}=      Get Value From Json    ${data}    $..codDescription
    ${urlcockpit}=      Get Value From Json    ${data}    $..urlcockpit
    ${pathelab}=    Get Value From Json    ${data}    $..pathelab
    ${pathcruscotto}=   Get Value From Json    ${data}    $..pathcruscotto
    ${scheda}=   Get Value From Json    ${data}    $..scheda
    ${tipoScheda}=   Get Value From Json    ${data}    $..tipoScheda
    ${codiceTab}=      Get Value From Json    ${data}    $..codiceTab
    ${valoreTipoScheda}=      Get Value From Json    ${data}    $..valoreTipoScheda
    ${cruscottoflow}=      Get Value From Json    ${data}    $..cruscottoflow
    ${codiceTabContributor}=      Get Value From Json    ${data}    $..codiceTabContributor
    ${flagEntity}=      Get Value From Json    ${data}    $..flagEntity
    ${flagGroup}=      Get Value From Json    ${data}    $..flagGroup
    ${flagConsolidation}=      Get Value From Json    ${data}    $..flagConsolidation
    ${flagPeriodoScendario}=      Get Value From Json    ${data}    $..flagPeriodoScendario
    ${queries}=     Get Value From Json    ${data}    $..queries
    ${id}=     Set Variable    ${id}[0]
    ${codProcesso}=     Set Variable    ${codProcesso}[0]
    ${consolidatoreNode}=     Set Variable    ${consolidatoreNode}[0]
    ${codElab}=     Set Variable    ${codElab}[0]
    ${codAnno}=     Set Variable    ${codAnno}[0]
    ${codPeriodo}=     Set Variable    ${codPeriodo}[0]
    ${codAmbiente}=     Set Variable    ${codAmbiente}[0]
    ${profiloUtente}=     Set Variable    ${profiloUtente}[0]
    ${cruscotto}=     Set Variable    ${cruscotto}[0]
    ${codjob}=     Set Variable    ${codjob}[0]
    ${codentity}=     Set Variable    ${codentity}[0]
    ${codDescription}=     Set Variable    ${codDescription}[0]
    ${urlcockpit}=     Set Variable    ${urlcockpit}[0]
    ${pathelab}=     Set Variable    ${pathelab}[0]
    ${pathcruscotto}=     Set Variable    ${pathcruscotto}[0]
    ${scheda}=     Set Variable    ${scheda}[0]
    ${tipoScheda}=     Set Variable    ${tipoScheda}[0]
    ${codiceTab}=     Set Variable    ${codiceTab}[0]
    ${schedaCruscotto}=     Set Variable    ${schedaCruscotto}[0]
    ${valoreTipoScheda}=     Set Variable    ${valoreTipoScheda}[0]
    ${cruscottoflow}=     Set Variable    ${cruscottoflow}[0]
    ${codiceTabContributor}=     Set Variable    ${codiceTabContributor}[0]
    ${flagEntity}=           Set Variable    ${flagEntity}[0]
    ${flagGroup}=           Set Variable    ${flagGroup}[0]
    ${flagConsolidation}=           Set Variable    ${flagConsolidation}[0]
    ${flagPeriodoScendario}=           Set Variable    ${flagPeriodoScendario}[0]
    [Return]    ${id}   ${codElab}  ${codProcesso}  ${codAnno}  ${codPeriodo}   ${codAmbiente}  ${profiloUtente}    ${cruscotto}    ${codjob}   ${codentity}    ${codDescription}   ${urlcockpit}   ${pathelab}     ${pathcruscotto}    ${scheda}   ${tipoScheda}     ${codiceTab}    ${consolidatoreNode}    ${schedaCruscotto}    ${valoreTipoScheda}     ${cruscottoflow}    ${codiceTabContributor}     ${flagEntity}       ${flagGroup}    ${flagConsolidation}    ${flagPeriodoScendario}     ${queries}


TGKControllaParametro
    [Arguments]     ${parametro}
    #Log To Console    sto qua
    #${valore}
    IF    ${parametro} == 1
        #Log To Console    sto qua1
        IF    "${userparam}" != "${EMPTY}"
            #Log To Console    sto qua2
            ${valore}=     Set Variable     ${userparam}
        ELSE
            #Log To Console    sto qua3
            #Log To Console    ${user}
            ${valore}=     Set Variable   ${user}
        END
    END
    IF    ${parametro} == 2
         IF    "${passparam}" != "${EMPTY}"
            ${valore}=     Set Variable     ${passparam}
         ELSE
            ${valore}=     Set Variable   ${pass}
         END
    END
    IF    ${parametro} == 3
         #Log To Console    valore di url
         #Log To Console    ${url}
         IF    "${url}" == "${EMPTY}"
            ${valore}=     Set Variable     ${urltrunk}
         ELSE
            ${valore}=     Set Variable   ${url}
         END
    END
    [Return]    ${valore}


TGKGetPropertyFromDict
    [Arguments]     ${dict}     ${property}
    ${value}=      Get From Dictionary    ${dict}    ${property}
    [Return]    ${value}

TGKSelezionaNodoEntityDataProcessing
    [Arguments]     ${nodo}
    Log To Console    ok1
    Click Element    //*[text()="Data Processings"]
    Log To Console    ok2
    Sleep    3s
    Scroll Element Into View    //*[text()="${nodo}"]/../input
    Sleep    2s
    Click Element    //*[text()="${nodo}"]
    Sleep    10s
    Wait Until Element Is Enabled   //*[text()='Run']   timeout=1000
    Click Element    //*[text()='Run']/../..
    TGKChiudiBrowser

TGKSelezionaFlagConsDataProces
    [Arguments]     ${flag1}    ${flag2}    ${flag3}    ${codPeriodo}
    #Log To Console    Elaboro   popup
    Log To Console    Seleziono i flag
    Click Element    //*[@id="com_tagetik_cpm_consolidation_vo_consolidationdataprocessing_ConsolidationDataProcessingWindowVo_runEntityDataProcessing"]
    Click Element    //*[@id="com_tagetik_cpm_consolidation_vo_consolidationdataprocessing_ConsolidationDataProcessingWindowVo_runGroupDataProcessing"]
    Click Element    //*[@id="com_tagetik_cpm_consolidation_vo_consolidationdataprocessing_ConsolidationDataProcessingWindowVo_runConsolidationAreaDataProcessing"]
    Sleep    1s
    IF    ${flag1} == 1
        Click Element    //*[@id="com_tagetik_cpm_consolidation_vo_consolidationdataprocessing_ConsolidationDataProcessingWindowVo_runEntityDataProcessing"]
    END
    IF    ${flag2} == 1
        Click Element    //*[@id="com_tagetik_cpm_consolidation_vo_consolidationdataprocessing_ConsolidationDataProcessingWindowVo_runGroupDataProcessing"]
        Sleep    1s

    END
    IF    ${flag3} == 1
        Click Element    //*[@id="com_tagetik_cpm_consolidation_vo_consolidationdataprocessing_ConsolidationDataProcessingWindowVo_runConsolidationAreaDataProcessing"]
        Sleep    1s
        #Clicco sui tre puntini
        Click Element   (//input[@type="text"])[4]/../following-sibling::div
        Wait Until Page Contains Element     //*[td/text()="${codPeriodo}"]     timeout=1000s
        Sleep    2s
        Log To Console     valore di codperiodo
        Log To Console     ${codPeriodo}
        Click Element   //*[td/text()="${codPeriodo}"]/td/span/input
        Click Element    //*[text()='OK']/../..
    END
    Sleep    5s
    Click Element    //div[@id="fwk.common.execute"]
    #Wait Until Page Contains Element    //*[text()="Continue"]      timeout=20s
    ${condition}=    Run Keyword And Ignore Error   Wait Until Page Contains Element   //*[text()="Continue"]    timeout=10s
    IF    "${condition}[0]" != "FAIL"
        Log To Console    tasto trovato
        Click Element    //*[text()="Continue"]/../..
    END


    #${trovato}  Get Element Count    //*[text()="Continue"]
    #Log To Console    valore di trovato
    #Log To Console    ${trovato}
    #IF    ${trovato} == 1
    #     Click Element    //*[text()="Continue"]/../..
    #END
    Log To Console    Fine popup
    ${esitoTest}=       TGKWaitResultOK
    #TGK_Execute

    #Click Element    //div[@id="fwk.common.execute"]
    #Sleep    10s

TGKChiudiSessioneBrowserOk
    Go To    https://cpm-man-trunk-3.platformteam.saastagetik.com/tagetikcpm/
    ${condition}=    Run Keyword And Ignore Error   Wait Until Page Contains Element   //*[text()="Logout"]    timeout=100s
    Click Element    //*[text()="Logout"]/../..
    Close Browser

TGKChiudiSessioneBrowser
    Click Element    //*[text()="Logout"]/../..
    ${condition}=    Run Keyword And Ignore Error   Wait Until Page Contains Element   //*[text()="Logout"]/../..    timeout=100s
    Close Browser

    Sleep    2s
    Click Element    //*[text()="Run"]/../..
    ${condition}=    Run Keyword And Ignore Error   Wait Until Page Contains Element   //*[text()="Continue"]    timeout=5s
    Sleep    1s
    Log To Console    valore di condition
    Log To Console    ${condition}[0]
    IF    "${condition}[0]" != "FAIL"
        Click Element    //*[text()="Continue"]/../..
    END

    Wait Until Element Is Visible    //*[text()="1/1"]      timeout=1000s
    Wait Until Page Contains Element    //*[text()="0/0"]      timeout=1000s
    #Wait Until Element Is Visible    //*[text()="0/0"]      timeout=1000s
    Sleep    2s
    ${trovato}  Get Element Count    //*[text()="Close"]
    IF  ${trovato} > 0
        Click Element    //*[text()="Close"]/../../..
    END
    Sleep    2
    Click Element    //*[@class="v-icon tagetik-icon-font"]/../../../../..


TGKWaitResultJob
    #Clicco sul pulsante per vedere il processo in esecuzione
    Sleep    5s
    Click Element       (//*[@class="v-customcomponent v-widget tgk-top-bar-item v-customcomponent-tgk-top-bar-item"])[6]
    Sleep    5s
    #//div[text()="A.VORRARO"]
    Wait Until Element Is Visible    //*[text()="Close"]      timeout=50s
    Sleep    2s
    ${trovato}  Get Element Count    //*[text()="Close"]
    IF  ${trovato} > 0
        Log To Console    Trovato count1
        Click Element    //*[text()="Close"]/../../..
        Log To Console    Trovato count2
    END
    Sleep    2
    Click Element    //*[@class="v-icon tagetik-icon-font"]/../../../../..






TGKSelezionaTuttiNodi
    Wait Until Page Contains Element    //*[text()="0/0"]      timeout=1000s
    Click Element   //div[text()="010 - All Entities"]/../..
    Sleep    1s
    Open Context Menu    //div[text()="010 - All Entities"]/../..
    Wait Until Page Contains Element    //*[text()="Select cascade"]      timeout=1000s
    Sleep    1s
    Click Element    //*[text()="Select cascade"]
    Sleep    5s


TGKSelezionaCruscotto
    [Arguments]    ${cruscotto}
    Wait Until Page Contains Element    //*[text()="Consolidator"]      timeout=1000s
    #Wait Until Element Is Enabled    //*[text()=${cruscotto}]
    Sleep    1s
    Click Element   //*[text()=${cruscotto}]
    Sleep    2s



TGKSelezionaProcesso
    [Arguments]    ${codProcesso}  ${codAnno}  ${codPeriodo}
    #Seleziono la scheda Processes ok funziona
    ${condition}=    Run Keyword And Ignore Error   Wait Until Element Is Enabled    //div[@id="cpm.home.buttons.cockpit"]  timeout=10s
    #Se non sono nella home per un motivo imprevisto e non posso cliccare sulla scheda del processo
    #Clicco prima sul tasto home e poi vado avanti
    IF    "${condition}[0]" == "FAIL"
        Click Element    //*[@id="tgk.main.header"]/div/div/div[1]/div/div[4]/div/div/div/div
    END
    TGK_Close_Popup_Warning_HomePage
    Click Element    //div[@id="cpm.home.buttons.cockpit"]/../following-sibling::div/div/div/div
    Wait Until Page Contains Element    //*[text()="${codProcesso}"]   timeout=20s
    Sleep    3s
    Scroll Element Into View    //*[text()='${codProcesso}']
    Sleep    1s
    Click Element    //*[text()='${codProcesso}']
    Wait Until Page Contains Element    //*[text()="${codAnno}"]   timeout=20s
    Scroll Element Into View    //*[text()='${codAnno}']
    Click Element    //*[text()='${codAnno}']
    Sleep    1s
    Wait Until Page Contains Element    //*[text()="${codPeriodo}"]   timeout=20s
    Sleep    1s
    Scroll Element Into View    //*[text()='${codPeriodo}']
    Click Element    //*[text()='${codPeriodo}']

TGKSelezionaProfiloUtente
    [Arguments]    ${profiloUtente}
    ${trovato}  Get Element Count    //span[text()=${profiloUtente}]
    #IF    ${trovato} == 1
    #    Log To Console    Profilo utente selezionato
    #ELSE
    #     Click Element    //*[@id="tgk.main.header"]/div/div/div/div//following-sibling::div//following-sibling::div//following-sibling::div//following-sibling::div//following-sibling::div/div/div/div/div/div//div//following-sibling::div/div/div/div
    #     Sleep    5s
    #     Click Element    //span[text()=${profiloUtente}]/../..
    #     Sleep    5s
    #END

    IF    ${trovato} == 0
         Click Element    //*[@id="tgk.main.header"]/div/div/div/div//following-sibling::div//following-sibling::div//following-sibling::div//following-sibling::div//following-sibling::div/div/div/div/div/div//div//following-sibling::div/div/div/div
         Sleep    5s
         Click Element    //span[text()=${profiloUtente}]/../..
         Sleep    5s
    END
    
       
Login
    [Arguments]    ${url}   ${username}=A.VORRARO     ${pass}=pass
    Open Browser                        ${url}          chrome
    Maximize Browser Window
    Wait Until Element Is Visible       id:inputUsername
    Sleep    5s
    Input Text                          id:inputUsername    ${username}
    Input Password                      id:inputPassword    ${pass}
    Click Element                       id:signInButton
    Sleep                               5s
    ${countProcedeButton}               Get Element Count    id:proceedButton
    Log To Console    ${countProcedeButton}

    IF    ${countProcedeButton} == 1
        Click Element    id:proceedButton
    END
   #${countWarning}          Get Element Count       //div[@class="popupContent"]
   ${countWarning}  Get Element Count   //div[@class="popupContent"]
    Sleep    5s


TGKClickElement
    [Arguments]    ${identifier}    ${timeout}=100
    [Documentation]     Use 'identifier' to set the attribute you have to click on, it has been set on a wait of 100 sec
    Wait Until Page Contains Element    ${identifier}   ${timeout}
    ${element}=    Get WebElement    ${identifier}
    Execute Javascript    arguments[0].click();    ARGUMENTS    ${element}
    Sleep    0.5

TGK_WaitABit
    [Documentation]    Wait a bit
    Log    wait a bit....
    Sleep    ${WAIT_A_BIT}


TGK_ElementMgr
    [Documentation]    Verify the provided element in the page and check if it is visible and enabled, click on it
    [Arguments]    ${findby}    ${check_visible}=False    ${check_enabled}=False    ${click}=False    ${wait_a_bit}=True
    Log    ${findby}
    Wait Until Page Contains Element    ${findby}
    Run Keyword If    '${check_visible}'=='True'    Wait Until Element Is Visible    ${findby}
    Run Keyword If    '${check_enabled}'=='True'    Wait Until Element Is Enabled    ${findby}
    IF    '${click}'=='True'
        Click Element    ${findby}
        Run Keyword If    '${wait_a_bit}'=='True'    TGK_WaitABit
    END

    
TGKLeggiDaDB
    [Arguments]     ${query}
    ${dataoggi}     Get Current Date
    log     ${dataoggi}[0:9]
    Connect To Database    psycopg2    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
    @{result}=  Query    ${query}
    @{resultCount}=  Query    ${queryCount}
    WHILE    ${counter} < ${resultCount[0]}[0]
        Should Be True   "${result[${counter}]}[0]"=="${username}"
        ${data}     Convert To String    ${result[${counter}]}[1]
        Should Be Equal As Strings      ${data}[0:9]    ${dataoggi}[0:9]
        ${counter}=     Evaluate      ${counter}+1
        Log To Console    Record numero
        Log To Console    ${counter}
    END

TGK_Execute

    Sleep    2s
    #Click Element    //*[text()="Run"]/../..
    Click Element    //div[@id="fwk.common.execute"]
    #Wait Until Page Contains Element    //*[text()="Continue"]      timeout=20s
    ${condition}=    Run Keyword And Ignore Error   Wait Until Page Contains Element   //*[text()="Continue"]/..    timeout=30s
    Sleep    1s
    #Log To Console    valore di condition
    #Log To Console    ${condition}[0]
    IF    "${condition}[0]" != "FAIL"
        Click Element    //*[text()="Continue"]/../..
    END
    #TGKWaitResult

    #${trovato}  Get Element Count    //*[text()="Continue"]
    #Log To Console    valore di trovato
    #Log To Console    ${trovato}
    #IF    ${trovato} == 1
    #    Click Element    //*[text()="Continue"]/../..
    #END


TGK_Leggi_dati_DB1
    [Arguments]     ${user}     ${queries}
    ${length} =  Get Length  @{queries}
    Connect To Database    psycopg2    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
    ${i}=   Set Variable    0
    #eseguo il ciclo sulle query da verificare, ricavete dal file json
    ${dataoggi}     Get Current Date
    ${dataoggi}=    Set Variable    ${dataoggi}[0:10] 
    Log To Console    Valore di data oggi
    Log To Console    ${dataoggi}
    WHILE    ${i} < ${length}
        ${query}=       Set Variable    ${queries[0]}[${i}]
        Log To Console    ${query}
        ${i}=     Evaluate      ${i}+1
        @{result}=  Query    ${query}   \   True
        ${counter}=     Set Variable    0
        ${numRec}=  Get Length     ${result}
        ${counter}=     Set Variable    0
        WHILE    ${counter} < ${numRec}
            Log To Console    ${result}[0][userupd]
            Log To Console    ${result}[1][dateupd]
            ${data}     Convert To String    ${result}[1][dateupd]
            ${data}=    Set Variable        ${data}[0:10]
            Log To Console    ${data}
                 Should Be Equal As Strings      ${data}    ${dataoggi}
                 Should Be Equal As Strings      ${user}    ${result}[1][userupd]
                 ${counter}=     Evaluate      ${counter}+1
        END
    END



TGK_Leggi_dati_DB
    [Arguments]     ${queries}
    ${length} =  Get Length  @{queries}
    Connect To Database    psycopg2    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
    ${i}=   Set Variable    0
    #eseguo il ciclo sulle query da verificare, ricavete dal file json
    WHILE    ${i} < ${length}
        ${query}=       Set Variable    ${queries[0]}[${i}]
        Log To Console    valore di query
        Log To Console    ${query}
        @{result}=  Query    ${query}   \   True
        ${counter}=     Set Variable    0
        ${numRec}=  Get Length     ${result}
        ${counter}=     Set Variable    0
        WHILE    ${counter} < ${numRec}
            Log To Console    ${result}[0][userupd]
            Log To Console    ${result}[1][dateupd]
            ${counter}=     Evaluate      ${counter}+1
        #        Log To Console    sto qua7
        #        Should Be True   "${result[${counter}]}[0]"=="${username}"
        #        ${data}     Convert To String    ${result[${counter}]}[1]
        #        Should Be Equal As Strings      ${data}[0:9]    ${dataoggi}[0:9]
        #        ${counter}=     Evaluate      ${counter}+1
        #        Log To Console    Record numero
        #        Log To Console    ${counter}
        END
        ${i}=     Evaluate      ${i}+1
    END

TGK_Close_Popup_Warning_HomePage
    ${countWarning}  Get Element Count   //*[text()="Warning"]
     IF    ${countWarning} == 1
        Click Element    //*[text()="Warning"]/../div/following-sibling::div
    END






