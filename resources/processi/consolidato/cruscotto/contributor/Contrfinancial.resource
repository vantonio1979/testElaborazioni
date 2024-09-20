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
CONTRFINANCIALFLOW
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
    TGKEseguiFlow   EN_00 - New York   Entity - Fin.Inv.Recl.
    TGKChiudiBrowser
    TGKLeggiDaDB    ${qContrFinance}




CONTRFINANCIAL
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
    TGKSelezionaNodoEntityDataProcessing    Financial investments reclassification
    TGKLeggiDaDB    ${qContrFinance}









