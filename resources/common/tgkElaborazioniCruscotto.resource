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
Resource    tgkElaborazioniJOB.resource

*** Variables ***
${SPACE}    #

*** Keywords ***

TGKRunElaboration
    [Arguments]    ${profiloUtente}     ${codProcesso}  ${codAnno}  ${codPeriodo}   ${cruscotto}    ${codentity}    ${urlelab}  ${scheda}   ${valoreScheda}     ${consolidatoreNode}
    Log To Console    Valore di nodo
    Log To Console    ${consolidatoreNode}
    Go To    ${urlelab}
    Wait Until Page Contains Element    //*[text()="Consolidator"]  timeout=30s
    TGKSelezionaCruscotto    ${cruscotto}
    #Wait Until Page Contains Element    //*[text()=${codentity}]  timeout=10s
    #Wait Until Page Contains Element    //*[text()="${codentity}"]  timeout=20s
    #Sleep    10s
    IF    "${consolidatoreNode}" == "*"
        Sleep    10s
        Log To Console    sto qua 1
        TGKSelezionaTuttiNodi
        Log To Console    sto qua 2
    ELSE
        Log To Console    sto qua 3
    END
    Log To Console    valore di valoreScheda
    Log To Console    ${valoreScheda}
    Click Element    //*[text()="${valoreScheda}"]/../..
    Wait Until Page Contains Element    //*[text()="Run"]
    Sleep    2s
    Click Element    //*[text()="Run"]/../..
    TGKWaitResult
    #Run Keyword If   "${consolidatoreNode}"=="*"
    #...    Wait Until Page Contains Element    //*[text()="010 - All Entities"]    timeout=60s
    #...    Wait For Condition	return document.readyState == "complete"
    #...    Wait Until Element Is Enabled    //*[text()="010 - All Entities"]
    #...    Wait Until Page Contains Element    //*[text()="010 - All Entities"]
    #...    TGKSelezionaTuttiNodi
    #...  ELSE
    #...    Wait Until Page Contains Element    //*[text()="${consolidatoreNode}"]
    #...    Click Element    //*[text()="${consolidatoreNode}"]/..
    # Log To Console     ok1
    #Click Element    //*[text()="${codentity}"]
    #Sleep    5s
    #Click Element    //*[text()="${codentity}"]
    #Sleep    2s
    #IF    ${scheda} == 1
    #    Wait Until Element Is Visible    //*[text()="${valoreScheda}"]    timeout=60
    #    Sleep    2s
    #    Click Element    //*[text()="${valoreScheda}"]/../..
    #    Wait Until Element Is Visible    //*[text()="Custom"]     timeout=10
    #    Sleep    2s
    #    Click Element    //*[text()="Custom"]/../..
    #    Sleep    5s
    #    TGKSelezionaFlagConsDataProces  1   0   1
    #ELSE
    #     Log To Console    else scheda
    #END
    #TGKWaitResult
    #TGKLeggiDaDB    ${qCessImmb}
