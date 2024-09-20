*** Settings ***
Library     SeleniumLibrary
Library     DatabaseLibrary
Library     OperatingSystem
Library     Collections
Resource    ../../common/common.resource
Resource    ../../common/variables.resource

*** Variables ***

${url}      https://cpm-man-trunk-3.platformteam.saastagetik.com/tagetikcpm
${user}     A.VORRARO
${pass}     pass


*** Keywords ***
CONTRFINANCIALJOB
   [Arguments]    ${profiloUtente}     ${codProcesso}
    ${risultato}=   Set Variable    0
    Login    ${url}    ${user}    ${pass}
    Sleep    5s
    TGKEseguiJob    ${codProcesso}
    ${risultato}=   Set Variable    1
    TGKLeggiDaDB    ${qContrFinance}
    [Return]    ${risultato}
