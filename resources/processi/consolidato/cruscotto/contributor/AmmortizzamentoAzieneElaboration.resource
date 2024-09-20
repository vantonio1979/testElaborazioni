*** Settings ***
Library     SeleniumLibrary
Library     DatabaseLibrary
Library     OperatingSystem
Library     Collections
Resource    ../../../../common/common.resource
Resource    ../../../../common/variables.resource

*** Variables ***

${url}      https://cpm-man-trunk-3.platformteam.saastagetik.com/tagetikcpm
${user}     A.VORRARO
${pass}     pass


*** Keywords ***
AmmortizzamentoAziendeRunnerWorkflow
    [Arguments]    ${profiloUtente}     ${codProcesso}  ${codAnno}  ${codPeriodo}   ${cruscotto}    ${codentity}    ${codDescription}
    Log To Console    Eseguo login
    Login    ${url}    ${user}    ${pass}
    Log To Console    Login eseguito
    #TGKSelezionaProfiloUtente   ${profiloUtente}
    TGKSelezionaProfiloUtente   "User"
    TGKSelezionaProcesso    ${codProcesso}  ${codAnno}  ${codPeriodo}
    Sleep    10s
    TGKSelezionaCruscotto    ${cruscotto}
    Click Element    //*[text()="Trial Balance"]
    Sleep    2s
    Wait Until Element Is Enabled    //*[@type="text"]/../../following-sibling::div/div/div/following-sibling::input
    Sleep    2s
    Input Text    //*[@type="text"]/../../following-sibling::div/div/div/following-sibling::input    ${codentity}
    Sleep    2s
    Click Element    //*[@type="text"]/../../following-sibling::div/div/div/following-sibling::input/../div
    Sleep    5s
    #Premo il pulsante sulla griglia per visualizzare la tabella
    Click Element    //*[@id="tgk-abstract-cockpit-view"]/div/div[2]/div/div[2]/div/div/div/div/div/div/div/div/div/div[3]/div/div/div/div/div/div/div/div/div[1]/div/div/div/div[2]/div/div/div/div[1]/div/div/div[9]/div
    Sleep    5s
    #Clicco sul pulsante della griglia
    Click Element    //*[@id="tgk-abstract-cockpit-view"]/div/div[2]/div/div[2]/div/div/div/div/div/div/div/div/div/div[3]/div/div/div/div/div/div/div/div/div[1]/div/div/div/div[2]/div/div/div/div[3]/div/div/div[2]/div[1]/table/tbody/tr[6]/td[3]/div/div/div/div/div/div/div
    Wait Until Element Is Enabled   //*[text()='Run']   timeout=1000
    Click Element    //*[text()='Run']/../..
    TGKChiudiBrowser
    TGKLeggiDaDB    ${qAAElaboration1}


AmmortizzamentoAziendeRunner
    [Arguments]    ${profiloUtente}     ${codProcesso}  ${codAnno}  ${codPeriodo}   ${cruscotto}
    Login    ${url}    ${user}    ${pass}
    #TGKSelezionaProfiloUtente   ${profiloUtente}
    TGKSelezionaProfiloUtente   "User"
    TGKSelezionaProcesso    ${codProcesso}  ${codAnno}  ${codPeriodo}
    TGKSelezionaCruscotto    ${cruscotto}
    Click Element    //*[text()="Detail summary"]
    Sleep    2s
    TGKSelezionaTuttiNodi
    Wait Until Element Is Enabled    //*[text()='Entity data processing']/../..     timeout=10
    Sleep    2s
    Click Element   //*[text()='Entity data processing']/../..
    Sleep    5s
    Click Element    //*[text()='Run']/../../..
    Wait Until Element Is Enabled    //*[text()='Continue']/../..     timeout=100
    Sleep    3s
    Click Element   //*[text()='Continue']/../..
    TGKChiudiBrowser
    TGKLeggiDaDB    ${qAAElaboration1}


    