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

TGKEseguiJob
    [Arguments]     ${job}
    TGKSelezionaProfiloUtente   "Admin"
    #Wait Until Element Is Enabled    //*[text()="Data Processing"]/../following-sibling::div/div/span   timeout=1000
    Wait Until Page Contains Element    //*[text()="Data Processing"]   timeout=10s
    Sleep    1s
    Click Element    //*[text()="Data Processing"]/../following-sibling::div/div/span
    Wait Until Element Is Enabled    //*[text()="Jobs"]/../following-sibling::div/div/span  timeout=1000
    Click Element       //*[text()="Jobs"]/../following-sibling::div/div/span
    Wait Until Element Is Enabled    //*[@id="tgk-action-view-impl-action-bar-id"]/div/div/div/div/div
    Sleep    2s
    Click Element    //*[@id="tgk-action-view-impl-action-bar-id"]/div/div/div/div/div
    Wait Until Element Is Visible   //*[text()="Apply"]     timeout=100
    Sleep    2s
    #Clicco il pulsante + per fare compare il menu
    Click Element    //*[text()="Apply"]/../../../../../../../../div/div/following-sibling::div/following-sibling::div/div/div/div/div/div/div
    Wait Until Element Is Enabled    //*[text()="Code"]
    Sleep    2s
    #Click Element    //*[text()="Code"]
    Click Element    //*[@id="fwk.common.code"]
    #Aspetto che input sia visibile
    Wait Until Element Is Enabled    //*[text()="Apply"]/../../../../../../../../div/div/following-sibling::div/following-sibling::div/div/div/div/div/div/div/div/div//following-sibling::div/following-sibling::div/following-sibling::div/following-sibling::div/input   timeout=1000
    Sleep    2s
    Input Text      //*[@type="text"]/../..//following-sibling::div//following-sibling::div/following-sibling::div/following-sibling::div/input      ${job}
    Click Element   //*[text()="Apply"]/../..
    Sleep    10s
    #Clicco su ultimo pulsante della action bar sopra la tabella
    Click Element    //*[@id="tgk-action-view-impl-action-bar-id"]/div/div/div/div/following-sibling::div/following-sibling::div/following-sibling::div/following-sibling::div/following-sibling::div/following-sibling::div/following-sibling::div/following-sibling::div/following-sibling::div/following-sibling::div
    Wait Until Element Is Enabled    //*[@role="menu"]/span[2]/span    timeout=1000
    Sleep    2s
    Click Element    //*[@role="menu"]/span[2]/span
    Wait Until Element Is Enabled    //*[text()="Launch"]    timeout=1000
    Sleep    2s
    Click Element    //*[text()="Launch"]/../..
    Sleep    5s
    ${esitoTest}=       TGKWaitResultOK
    Log To Console    Valore di esito test in job
    Log To Console    ${esitoTest}
    [Return]    ${esitoTest}
    #TGKWaitResultJob
