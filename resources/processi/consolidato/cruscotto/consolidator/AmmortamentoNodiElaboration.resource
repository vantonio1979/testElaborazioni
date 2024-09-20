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
AmmortizzamentoNodiElaborationWorkFlow
    [Arguments]    ${profiloUtente}     ${codProcesso}  ${codAnno}  ${codPeriodo}   ${cruscotto}    ${codentity}    ${codDescription}
    Login    ${url}    ${user}    ${pass}
    TGKSelezionaProfiloUtente   "User"
    TGKSelezionaProcesso    ${codProcesso}  ${codAnno}  ${codPeriodo}
    Sleep    10s
    TGKSelezionaCruscotto    ${cruscotto}
    Wait Until Element Is Enabled    //*[text()="Consolidation Journals"]   timeout=1000
    Sleep    3s
    Click Element    //*[text()="Consolidation Journals"]
    Sleep    5s
    Wait Until Element Is Enabled    //*[@type="text"]/../../following-sibling::div/div/div/following-sibling::input
    Click Element    //*[text()="100 - North America"]
    Sleep    5s
    Click Element    //*[@id="tgk-abstract-cockpit-view"]/div/div[2]/div/div[2]/div/div/div/div/div/div/div/div/div/div[3]/div/div/div/div/div/div/div/div/div[1]/div/div/div/div[2]/div/div/div/div[1]/div/div/div[9]/div
    Sleep    5s
    Click Element    //*[@id="tgk-abstract-cockpit-view"]/div/div[2]/div/div[2]/div/div/div/div/div/div/div/div/div/div[3]/div/div/div/div/div/div/div/div/div[1]/div/div/div/div[2]/div/div/div/div[3]/div/div/div[2]/div[1]/table/tbody/tr[1]/td[3]/div/div/div/div/div/div/div
    Wait Until Element Is Enabled   //*[text()='Run']   timeout=1000
    Click Element    //*[text()='Run']/../..
    TGKChiudiBrowser
    TGKLeggiDaDB    ${qAmmortamentoNE}


AmmortizzamentoNodiElaboration
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
    Log To Console    5
    Click Element    //*[text()="100 - North America"]
    Sleep    5s
    Click Element    //*[text()="Consolidation data processing"]/../..
    Wait Until Element Is Enabled    //*[text()='Custom']     timeout=10
    Sleep    5s
    Click Element    //*[text()="Custom"]/../..
    Sleep    5s
    TGKSelezionaFlagConsDataProces  1   0   1
    TGKChiudiBrowser
    TGKLeggiDaDB    ${qAmmortamentoNE}


