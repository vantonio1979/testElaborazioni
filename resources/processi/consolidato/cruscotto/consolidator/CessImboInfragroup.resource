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
#Login    ${url}    ${user}    ${pass}
##Log To Console    2
#TGKSelezionaProfiloUtente   "User"
#Log To Console    3
#TGKSelezionaProcesso    ${codProcesso}  ${codAnno}  ${codPeriodo}
#Log To Console    4
#Sleep    5s
#TGKSelezionaCruscotto    ${cruscotto}
CessMobInfraGroup
    [Arguments]    ${profiloUtente}     ${codProcesso}  ${codAnno}  ${codPeriodo}   ${cruscotto}    ${codentity}    ${urlelab}  ${scheda}
    Log To Console    1
    Go To    ${urlelab}
    Wait Until Element Is Visible    //*[text()="${codentity}"]     timeout=60
    Log To Console    Valore di codentity
    Log To Console    ${codentity}
    Click Element    //*[text()="${codentity}"]
    Sleep    5s
    Click Element    //*[text()="${codentity}"]
    Log To Console    Valore di scheda
    Log To Console    ${scheda}
    Click Element    //*[text()="Consolidation data processing"]/../..
    Wait Until Element Is Enabled    //*[text()='Custom']     timeout=10
    Sleep    5s
    Click Element    //*[text()="Custom"]/../..
    Sleep    5s
    TGKSelezionaFlagConsDataProces  1   0   1
    TGKChiudiBrowser
    TGKLeggiDaDB    ${qCessImmb}




CessMobInfraGroupFLOW
    [Arguments]    ${profiloUtente}     ${codProcesso}  ${codAnno}  ${codPeriodo}   ${cruscotto}    ${codentity}    ${codDescription}
    #Login    ${url}    ${user}    ${pass}
    TGKSelezionaProfiloUtente   "User"
    TGKSelezionaProcesso    ${codProcesso}  ${codAnno}  ${codPeriodo}
    Wait Until Element Is Enabled    //*[text()="Trial Balance"]   timeout=1000
    Sleep    3s
    TGKSelezionaCruscotto    Consolidator
    Click Element    //*[text()="Consolidation Journals"]
    Sleep    5s
    TGKEseguiFlow   ${codentity}   ${codDescription}
    TGKChiudiBrowser
    TGKLeggiDaDB    ${qCessImmb}




