*** Settings ***
Library     SeleniumLibrary
Library     DatabaseLibrary
Library     OperatingSystem
Library     Collections
Library     String
Resource    ../../../../common/common.resource
Resource    ../../../../common/variables.resource

*** Variables ***

${url}      https://cpm-man-trunk-3.platformteam.saastagetik.com/tagetikcpm
${user}     A.VORRARO
${pass}     pass


*** Keywords ***

DeconsolidamentoContributorUserToolsElaboration
    [Arguments]    ${profiloUtente}     ${codProcesso}  ${codAnno}  ${codPeriodo}   ${cruscotto}
    Login    ${url}    ${user}    ${pass}
    TGKSelezionaProfiloUtente   "User"
    ${currenturl}=   Get Location
    Log To Console    Valore di current url
    Log To Console    ${currenturl}
    @{words} =  Split To Lines    ${currenturl}       #
    Log To Console    Stampo valore1
    Log To Console    @{words}[0]
    Log To Console    Stampo valore2
    Log To Console    @{words}


    #TGKSelezionaProcesso    ${codProcesso}  ${codAnno}  ${codPeriodo}
    #TGKSelezionaCruscotto    ${cruscotto}
    #Click Element    //*[text()="Detail summary"]
    #Sleep    2s
    #TGKSelezionaTuttiNodi
    #Wait Until Element Is Enabled    //*[text()='Entity data processing']/../..     timeout=10
    #Sleep    2s
    #Click Element   //*[text()='Entity data processing']/../..
    #Sleep    5s
    #TGKSelezionaNodoEntityDataProcessing    Financial investments reclassification
    #TGKLeggiDaDB    ${qContrFinance}









