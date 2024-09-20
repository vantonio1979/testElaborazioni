*** Settings ***
Library     SeleniumLibrary
Library     DatabaseLibrary
Library     OperatingSystem
Library     Collections
Resource    ../../../../common/common.resource
Resource    ../../../../common/variables.resource
Resource    ../../../../common/query.resource

*** Variables ***

${url}      https://cpm-man-trunk-3.platformteam.saastagetik.com/tagetikcpm
${user}     A.VORRARO
${pass}     pass


*** Keywords ***
AnnullamentoRunnerFLOW
    [Arguments]    ${profiloUtente}     ${codProcesso}  ${codAnno}  ${codPeriodo}   ${cruscotto}    ${codentity}    ${codDescription}
    Login    ${url}    ${user}    ${pass}
    TGKSelezionaProfiloUtente   "User"
    TGKSelezionaProcesso    ${codProcesso}  ${codAnno}  ${codPeriodo}
    Wait Until Element Is Enabled    //*[text()="Trial Balance"]   timeout=1000
    Sleep    3s
    TGKSelezionaCruscotto    Contributor
    Click Element    //*[text()="Trial Balance"]
    Sleep    5s
    TGKEseguiFlow   ${codentity}   ${codDescription}
    TGKChiudiBrowser
    TGKLeggiDaDB    ${qAnnullamentoRunner}


AnnullamentoRunner
    [Arguments]    ${profiloUtente}     ${codProcesso}  ${codAnno}  ${codPeriodo}   ${cruscotto}
    Log To Console    1
    Login    ${url}    ${user}    ${pass}
    Log To Console    2
    TGKSelezionaProfiloUtente   "User"
    Log To Console    3
    TGKSelezionaProcesso    ${codProcesso}  ${codAnno}  ${codPeriodo}
    Log To Console    4
    Sleep    5s
    TGKSelezionaCruscotto    ${cruscotto}
    Wait Until Element Is Enabled    //*[text()="010 - All Entities"]  timeout=1000s
    TGKSelezionaTuttiNodi
    Wait Until Element Is Enabled    //*[text()="Preliminary data processing"]  timeout=1000s
    Click Element    //*[text()="Preliminary data processing"]/../..
    Wait Until Element Is Enabled    //*[text()='Run']     timeout=1000s
    Sleep    5s
    Click Element    //*[text()="Run"]/../..
    TGKChiudiBrowser



