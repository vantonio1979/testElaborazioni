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
Resource    tgkElaborazioniCruscotto.resource
Resource    tgkElaborazioniJOB.resource
Resource    tgkElaborazioniFlow.resource
#Resource    ../resources/rf-common-library/library/TGKCommonLibrary/TGK_Utility.resource

#Test Setup      TGKSetupTest

*** Variables ***
${SPACE}    #


*** Keywords ***

TGKRunElabOk
    [Arguments]    ${user}      ${percorsoFile}
    #Data processing is complete
     ${trovato}  Get Element Count    //*[text()="Data processing is complete"]
    IF  ${trovato} > 0
        Click Element    //*[text()="Close"]/..
    END
    TGKSelezionaProfiloUtente    "User"
    ${id}   ${codElab}  ${codProcesso}  ${codAnno}  ${codPeriodo}   ${codAmbiente}  ${profiloUtente}    ${cruscotto}    ${codjob}   ${codentity}    ${codDescription}   ${urlcockpit}      ${pathelab}  ${pathcruscotto}    ${scheda}   ${tipoScheda}     ${codiceTab}    ${consolidatoreNode}     ${schedaCruscotto}   ${valoreTipoScheda}     ${cruscottoflow}    ${codiceTabContributor}     ${flagEntity}       ${flagGroup}    ${flagConsolidation}    ${flagPeriodoScendario}     ${queries}      TGKGetMultiplePropertyFromJson  ${percorsoFile}
    ${countWarning}  Get Element Count   //*[text()="Warning"]
    TGK_Close_Popup_Warning_HomePage

    IF  "${codProcesso}" == "RED - null"
        ${currentURL}=   Get Location
        @{my_list}=    Create List    ${currentURL.split('#')}
        ${urlprefisso}=    Set Variable    @{my_list}[0]
        ${url}=     Set Variable    ${urlprefisso}[0]#!/cockpit/contributor/PG_MAN_TRUNK_DEV_YYC_2/RED/2016RED/12
        Go To   ${url}
    ELSE
        TGKSelezionaProcesso    ${codProcesso}    ${codAnno}    ${codPeriodo}
    END

    Sleep    5s
    TGKSelezionaCruscotto    //*[text()="${cruscotto}"]
    #Elaboro il cruscotto di tipo Contributor
    IF    "${cruscotto}" == "Contributor"
            TGK_WaitAndClickElement    //*[text()="${schedaCruscotto}"]
            Sleep    5s
            IF    "${consolidatoreNode}" == "*"
                TGKSelezionaTuttiNodi
            ELSE
                Log To Console    Seleziono un singolo nodo
            END

            #La scheda da selezionare è Entity Data Processing
            IF    "${tipoScheda}" == "1"
                #Log To Console    sto qua1
                Click Element    id:cpm.cockpit.step.activities.buttons.entityElaborations
                TGK_EntityDataProcessing    ${valoreTipoScheda}
                #Log To Console    sto qua2
                #Sleep    5s
            END

            IF    "${tipoScheda}" == "3"
                #Log To Console    sto qua1
                Click Element    id:cpm.cockpit.contributor.preliminaryDataProcessing
                Wait Until Page Contains Element    //*[text()="Run"]/..   timeout=20s
                Sleep    2s
                Click Element    //*[text()="Run"]/../..
                ${esitoTest}=       TGKWaitResultOK
            END
    #
    #Elaboro il cruscotto di tipo Consolidatore
    ELSE
        Log To Console    Eseguo cruscotto consolidatore
        Wait Until Page Contains Element    //*[text()="Summary"]   timeout=20s
        Sleep    1s
        #Log To Console    Valore di consolidatore nodo
        #Log To Console    ${consolidatoreNode}
        IF    "${consolidatoreNode}" == "*"
                TGKSelezionaTuttiNodi
        ELSE
                Wait Until Page Contains Element    //*[text()="${consolidatoreNode}"]
                Sleep    1s
                Click Element    //*[text()="${consolidatoreNode}"]
        END

        #tipoScheda 1  Elaboro la scheda EntityDataProcessing
        #tipoScheda 2  Elaboro la scheda Custom Data Processing
        #tipoScheda 3  Elaboro la scheda Preliminary Data Proccesing

        IF    "${tipoScheda}" == "2"
                #Log To Console    sto qua1
                Sleep    1s
                #Click Element    //*[@id="tgk-process-azioni-panel-id"]/descendant::div[${scheda}]
                Click Element    //*[@id="tgk-process-azioni-panel-id"]/div/div/div/div/following-sibling::div/div/div/following-sibling::div[${scheda}]
                Sleep    1s
                #Log To Console    valore di  flagPeriodoScendario
                #Log To Console    ${flagPeriodoScendario}
                TGK_CustomDataProcessing    ${scheda}   ${flagEntity}       ${flagGroup}    ${flagConsolidation}    ${flagPeriodoScendario}
        END
        IF    "${tipoScheda}" == "3"
                Click Element   //*[@id="cpm.cockpit.consolidator.preliminaryDataProcessing"]/span/span[2]/../..
                Wait Until Page Contains Element    //*[text()="Run"]/..    timeout=10s
                Sleep    1s
                IF    "${valoreTipoScheda}" != "*"
                    Click Element    (//input[@type="checkbox"])[1]/../label
                    Click Element    (//input[@type="checkbox"])[2]/../label
                    Click Element    (//input[@type="checkbox"])[7]/../label
                    Scroll Element Into View      (//input[@type="checkbox"])[7]/../../following-sibling::div/div/div/following-sibling::div/div/div/div/div
                    #Clicco sui 3 punti
                    Sleep    1s
                    Click Element    (//input[@type="checkbox"])[7]/../../following-sibling::div/div/div/following-sibling::div/div/div/div/div
                    #Wait Until Element Contains    //*[@id="cpm.datamodel.scenario"]/div/div[1]/input    timeout=10s
                    Sleep    10s
                    Input Text    //*[@id="cpm.datamodel.scenario"]/div/div[1]/input    ${flagPeriodoScendario}
                    Click Element    //*[text()="${flagPeriodoScendario}"]/../td/span/input
                    #Click Element    //*[@id="cpm.datamodel.scenario"]/div/div[1]/input
                    Sleep    3s
                    Click Element    //*[text()="OK"]/../..
                END
                Click Element    //*[text()="Run"]/../..
                ${esitoTest}=       TGKWaitResultOK
        END
        #TGKWaitResult


    END

    Sleep    5s

    #TGKWaitResult

