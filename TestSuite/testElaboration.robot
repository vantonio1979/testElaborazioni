*** Settings ***
Library     SeleniumLibrary
Library     DatabaseLibrary
Library     OperatingSystem
Library     DateTime
Library     Collections
Library     JSONLibrary
#Library     DebugLibrary
#Library     List
Resource    ../resources/common/common.resource
Resource    ../resources/common/import.resource
Resource    ../resources/common/variables.resource
Resource    ../resources/common/tgkElaborazioniCruscotto.resource
Resource    ../resources/common/tgkElaborazioniJOB.resource
Resource    ../resources/common/tgkElaborazioniFlow.resource
Resource    ../resources/common/tgkCruscotto.resource
Resource    ../resources/rf-common-library/library/TGKCommonLibrary/TGK_Utility.resource

#Tutto il progetto che ho fatto lo devo catapultare sotto il progetto della cartella
#rf-consolidation e devo integrare nel progetto le keywords usate dalla loro libreria
#con le mie, se non ci sta quella che mi interessa la inserisco

Test Setup      TGKSetupTest
Test Teardown   TGKChiudiSessioneBrowserOk
#Suite Setup     TGKSetupTest
*** Variables ***
${SPACE}    #
${userapp}
${esitotest}    0


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

#Per controllare la fine di esecuzione di un elaborazione, una volta cliccato il tasto
#run cliccare sul pulsante 0/0, si apre il popup,
#fare una wait per aspettare che il codice di elaborazioni compare nella schermata,
#fare una wait per aspettare che il codice di elaborazione scompare dalla schermata
#cosi controllo esito

#https://robocorp.com/docs/libraries/rpa-framework/rpa-email-imapsmtp
#https://rpaframework.org/libraries/email_imapsmtp/


#Per fare il controllo per vedere se un elaborazione è terminata o meno
#Vado sulla tabella rep_teic e controllo se è presente o meno un record in tabella
#con il mio nome utente, finchè è presente il record con il mio nick name significa
#che elaborazione è ancora in eseguzione,
#dopo di che posso proceder con il flusso normale sul cpm
#Vedere bene come incastrare le tre tabelle

#Tramite la seguente query verifico che l'elaborazione è in esecuzione
#select *
#from rep_teic rt

#tramite la seguente query recupero il campo oid per leggere esito di elaborazione su rep_audit_logs
#select *
#from rep_audit_operazione rao
#where rao.utente ='A.VORRARO'
#order by op_time desc

#Tramite seguente query controllo esito di elaborazione con il campo recuperato
#dalla query precedente
#select *
#from rep_audit_logs ral where rep_audit_operazione_oid  = '2C94D1D39048C4FC01904AD191831955'

#TGK_TEST
#    Log To Console    utente loggato
#    Log To Console    ${userapp}

#Dove sta l'indicatore delle elaborazioni sul cruscotto, devo cercare di leggere
#il primo numero, il quale indica elaborazione lanciata da me


#Test da provare

#robot -d results -t TGK_ELAB_ammortamentoNodiAziende testElaboration.robot
#robot -d results -t TGK_ELAB_minorityDataProcessing testElaboration.robot

TGK_ELAB_ammortamentoAziende
    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/ammortamentoAziendeElaboration.json
    TGK_Test_Elab   ${percorsoFile}
    Log To Console    valore di esito test in test
    Log To Console    ${esitotest}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_ammortamentoNodiAziende
   [Tags]    robot:continue-on-failure
   # Debug
    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    Log To Console    valore di userapp in test
    Log To Console    ${userapp}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/ammortamentoNodiElaboration.json
    TGK_Test_Elab   ${percorsoFile}
    Log To Console    valore di esito test in test
    Log To Console    ${esitotest}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END


TGK_ELAB_annullamentoRunner
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/annullamentoRunner.json
    TGK_Test_Elab       ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_cessImmobInfragruppoElaboration
    [Tags]    robot:continue-on-failure
    #fallisce controllare
    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/cessImmobInfragruppoElaboration.json
    TGK_Test_Elab   ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_contrFinancialInvestmentsReclassification
    [Tags]    robot:continue-on-failure
    #fallisce il job T21
    #//*[text()="Hide log details"]/..
    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/CONTR_FINANCIAL_INVESTMENTS_RECLASSIFICATION.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_conversioniElabDataProcessing
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/conversioniElabDataProcessing.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_deconsolidamentoContributorUserToolsElaboration
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/deconsolidamentoContributorUserToolsElaboration.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_deconsolidamentoConsolidatoreUserToolsElaboration
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/DeconsolidamentoConsolidatoreUserToolsElaboration.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_deconsolidamentoPropDataProcessing
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/DeconsolidamentoPropDataProcessing.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_deconsolidamentoConvDataProcessing
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/DeconsolidamentoPropDataProcessing.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_elabPreliminariOriginarioElaboration
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/elabPreliminari.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_elabPreliminariConsElaboration
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/elabPreliminariConsElaboration.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_elisionic
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/elisionic.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_elisioniPIN
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/elisionipin.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_equitizzazioneDataProcessing
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/equitizzazioneDataProcessing.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_equityPickUpConsElaboration
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/equityPickUpConsElaboration.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_equityPickUpElaboration
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/equityPickUpElaboration.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_forzaturaTipoImportoNElaboration
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/forzaturaTipoImportoNElaboration.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_forzatureConsolidamento
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/forzatureConsolidamento.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

#Devo controllare perchè non si ferma con i test
TGK_ELAB_fusioniOrigMergeContributorUserToolsElaboration
    [Tags]    robot:continue-on-failure
    #si blocca controllare il test
    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/fusioniOrigMergeContributorUserToolsElaboration.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_fusioniOrigFusioniContributorElaboration
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/fusioniOrigFusioniContributorElaboration.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_fusioniOrigMergeConsolidatoreUserToolsElaboration
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/fusioniOrigMergeConsolidatoreUserToolsElaboration.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_fusioniOrigFusioniConsolidatoreElaboration
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/fusioniOrigFusioniConsolidatoreElaboration.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_IFSR5
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/IFSR5.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_ImposteDiffElaborationRC
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/imposteDiffElaborationRC.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_ImposteDiffElaborationRP
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/imposteDiffElaborationRP.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_lookThroughConsElaboration
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/lookThroughConsElaboration.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_lookThroughOrigElaboration
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/lookThroughOrigElaboration.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_minorityDataProcessing
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/minorityDataProcessing.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_newCopiaPeriodoPrecLauncher
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/newCopiaPeriodoPrecLauncher.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_newDeconsolidamentoLauncher
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/newDeconsolidamentoLauncher.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_newFusioniLauncher
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/newFusioniLauncher.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_proporzionalizzazioneDataProcessing
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/proporzionalizzazioneDataProcessing.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_proporzionalizzazionelegacy
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/proporzionalizzazionelegacy.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_richPartAziende
    # fallisce il job t21
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/richPartAziende.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_riclassificaContiOrigElaboration
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/riclassificaContiRiclassificaContiOrigElaboration.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_riclassificaGpnOrigElaboration
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/riclassificaContiGpnOrigElaboration.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_riclassificaContiConsElaboration
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/riclassificaContiConsElaboration.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_riclassificaContiGpnConsElaboration
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/riclassificaContiGpnConsElaboration.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END
    

TGK_ELAB_richPartNodi
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    #Elaborazione fallisce
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/richPartNodi.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END


TGK_ELAB_ripristiniRunner
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/ripristiniRunner.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_REDOrigEntityEasyElaboration
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/REDOrigEntityEasyElaboration.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_REDOrigGroupEasyElaboration
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/REDOrigGroupEasyElaboration.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END


TGK_ELAB_REDConsEasyElaboration
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/REDConsEasyElaboration.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

TGK_ELAB_scaricoCambiDataProcessing
    [Tags]    robot:continue-on-failure

    Log To Console    eseguo test
    Log To Console    ${TEST_NAME}
    ${percorsoFile}=    Set Variable     ${CURDIR}/data/scaricoCambiDataProcessing.json
    TGK_Test_Elab      ${percorsoFile}
    IF    ${esitotest} == 0
        Fail    ko
    ELSE
         Pass Execution    ok
    END

*** Keywords ***
