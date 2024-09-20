*** Settings ***
Library     SeleniumLibrary
Library     DatabaseLibrary
Library     OperatingSystem
Library     DateTime
Library     Collections
Library     JSONLibrary
#Library     List
Resource    ../resources/common/common.resource
Resource    ../resources/common/import.resource
Resource    ../resources/common/variables.resource
Resource    ../resources/common/tgkElaborazioniCruscotto.resource
Resource    ../resources/common/tgkElaborazioniJOB.resource
Resource    ../resources/common/tgkElaborazioniFlow.resource
Resource    ../resources/common/tgkCruscotto.resource
#Resource    ../resources/rf-common-library/library/TGKCommonLibrary/TGK_Utility.resource

#Test Setup      TGKSetupTest
Suite Setup     TGKSetupTest
*** Variables ***
${SPACE}    #
${userapp}

*** Test Cases ***

#Devo splittare il progetto delle elaborazioni in n test case da richiamare
#non devo avere un unico test di elaborazione, per tutte le elaborazioni,
#ma devo avere un test per ogni elaborazioni, e devo togliere
#gli sleep dalle funzioni
#https://cchtagetik.atlassian.net/wiki/spaces/TA1/pages/3896737828/RF+Workshop+-+Prerequisites#Python-&-Robot-Framework
#${urlelab}      TGKBuildURLElab     ${pathcruscotto}    ${dbnameapp}     ${pathelab}
#Per eseguire uno specifico test dalla testsuid aggiungo lopzione -t
#quando lancio con il nome del test, come esempio di sotto
#robot -d results -t ammortamentoAziende testElaboration.robot
#robot -d results -t annullamentoRunner testElaboration.robot

#tipoScheda 1  Elaboro la scheda EntityDataProcessing
#tipoScheda 2  Elaboro la scheda Custom Data Processing
#tipoScheda 3  Elaboro la scheda Preliminary Data Proccesing
#Comando per eseguire il test passando parametri da lina di comando
#robot -v userparam: -d results -t TGK_ELAB_annullamentoRunner testElaboration.robot

#Temp

    #${percorsoFile}=    Set Variable     ${CURDIR}/data/ammortamentoAziendeElaboration.json
    #TGKRunElabOk   ${user}      ${percorsoFile}
    #TGKRunElabOk    ${percorsoFile}
    #${data}=	Load Json From File	    ${percorsoFile}
    #@{queries}=      Get Value From Json    ${data}    $..queries
    #TGK_Leggi_dati_DB    ${queries}

TGK_ELAB_ammortamentoAziende

    ${percorsoFile}=    Set Variable     ${CURDIR}/data/ammortamentoAziendeElaboration.json
    TGK_Test_Elab   ${userapp}      ${percorsoFile}


TGK_ELAB_ammortamentoNodiAziende
    [Tags]    robot:continue-on-failure

    ${percorsoFile}=    Set Variable     ${CURDIR}/data/ammortamentoNodiElaboration.json
    TGK_Test_Elab   ${userapp}      ${percorsoFile}


TGK_ELAB_annullamentoRunner
    [Tags]    robot:continue-on-failure

    ${percorsoFile}=    Set Variable     ${CURDIR}/data/annullamentoRunner.json
    TGK_Test_Elab   ${userapp}     ${percorsoFile}

TGK_ELAB_cessImmobInfragruppoElaboration
    [Tags]    robot:continue-on-failure
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/cessImmobInfragruppoElaboration.json
    TGK_Test_Elab   ${userapp}     ${percorsoFile}

*** Keywords ***


#//div[@class="v-menubar v-widget v-has-width" and @role="menubar" and contains(span,'Consolidation data processing')]
