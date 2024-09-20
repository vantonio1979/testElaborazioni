*** Settings ***
Library     SeleniumLibrary
Library     DatabaseLibrary
Library     OperatingSystem
Library     DateTime
Library     Collections
Library     JSONLibrary
#Library     List
Resource    common.resource
Resource    import.resource
Resource    variables.resource

*** Variables ***
${SPACE}    #

*** Keywords ***

TGKEseguiFlow
    #[Documentation]     Eseguo l'elaborazione da flow passo alla keyword i seguenti parametri
    #... codiceTAB       verifica quale tab usare a sinistra nel cruscotto
    #... cruscotto       controlla quale cruscotto usare se il consolidatore o contributor
    #... codentity       la descrizione del nodo da selezionare
    #... urlelab         l'url dell elaborazione da eseguire
    #... codDescription  descrizione del icona ingraggi da selezionare
    [Arguments]     ${codProcesso}  ${codAnno}  ${codPeriodo}   ${codiceTAB}    ${cruscotto}   ${codentity}       ${urlelab}    ${codDescription}   ${cruscottoflow}    ${codiceTabContributor}
    #Go To    ${urlelab}

    TGKSelezionaProfiloUtente   "User"
    IF  "${codProcesso}" == "RED - null"
        ${currentURL}=   Get Location
        @{my_list}=    Create List    ${currentURL.split('#')}
        ${urlprefisso}=    Set Variable    @{my_list}[0]
        ${url}=     Set Variable    ${urlprefisso}[0]#!/cockpit/contributor/PG_MAN_TRUNK_DEV_YYC_2/RED/2016RED/12
        Go To   ${url}
    ELSE
        TGKSelezionaProcesso    ${codProcesso}    ${codAnno}    ${codPeriodo}
    END
    #TGKSelezionaProcesso    ${codProcesso}    ${codAnno}    ${codPeriodo}
    Wait Until Page Contains Element    //*[text()="${cruscottoflow}"]
    Sleep    1s
    Log To Console    valore di cruscottoflow
    Log To Console    ${cruscottoflow}
    TGKSelezionaCruscotto    "${cruscottoflow}"
    Log To Console    sto qua2
    Log To Console    Valore di codiceTAB
    Log To Console    ${codiceTAB}
    Wait Until Element Is Visible    //*[text()="${codiceTabContributor}"]   timeout=60
    Log To Console    sto qua2
    Sleep    2s
    Log To Console    Valore di codiceTabContributor
    Log To Console    ${codiceTabContributor}
    Log To Console    Valore di codEntity
    Log To Console    ${codentity}
    Click Element    //*[text()="${codiceTabContributor}"]/..
    Wait Until Element Is Visible    //*[text()="${codentity}"]   timeout=1000
    Click Element    //*[text()="${codentity}"]/..
    Sleep    5s
    #clicco sul pulsante della griglia per far compare le icone in forma di tabella

    Click Element    //*[text()="${codentity}"]/..
    Sleep    5s
    #Clicco sul pulsante per far comparire il grafo sotto forma di tabellas
    Wait Until Element Is Visible    //*[@id="cpm.cockpit.step.activities.remainingTime"]/../following-sibling::div//following-sibling::div//following-sibling::div//following-sibling::div/div   timeout=1000
    Sleep    2s
    Click Element   //*[@id="cpm.cockpit.step.activities.remainingTime"]/../following-sibling::div//following-sibling::div//following-sibling::div//following-sibling::div/div
    Log To Console    Valore di codDescription
    Log To Console    ${codDescription}
    Wait Until Element Is Visible    //*[text()="${codDescription}"]
    Sleep    2s
    Click Element    //*[text()="${codDescription}"]/../following-sibling::td/div/div
    Wait Until Element Is Visible    //*[text()="Run"]
    Sleep    1s
    Click Element    //*[text()="Run"]/../..
    #Click Element    //*[text()="Run"]/../..
    #${condition}=    Run Keyword And Ignore Error   Wait Until Page Contains Element   //*[text()="Continue"]/..    timeout=30s
    #Sleep    1s
    #Log To Console    valore di condition
    #Log To Console    ${condition}[0]
    #IF    "${condition}[0]" != "FAIL"
    #    Click Element    //*[text()="Continue"]/../..
    #END
    TGKWaitResult
