*** Settings ***
Library     SeleniumLibrary
Library     Collections
Library    DataDriver       file=url.csv     encoding=utf_8      dialect=unix
Resource    ../resources/common/commonRobot.resource
#Library     RPA.Email.ImapSmtp   smtp_server=smtp.gmail.com  smtp_port=465
Library     RPA.Email.ImapSmtp   smtp_server=smtp.libero.it  smtp_port=25
Task Setup  Authorize Smtp  account=${emailfrom}  password=${PASSWORD}
Library     mail.py
Library    String
Test Template    TGK_TestUrlup

*** Variables ***

#Test Setup      TGKSetupTest

${emailfrom}        vantonio79@libero.it
${PASSWORD}       provAaaa1@
${csv}

*** Test Cases ***

#robot -d results -t ammortamentoAziende testElaboration.robot
#robot -d results -t annullamentoRunner testElaboration.robot
#robot -v -d results -t annullamentoRunner testElaboration.robot
TGK_Test_Urlokcsv1   ${url}
    #TGK_prova
    #TGK_TestUrlup   ${url}


TGK_Test_UrlLetturaCsv
    Log To Console    ok
    Log To Console    ${urlcsv}
    ${csv}=    Get File    ${urlcsv}
    @{read}=    Create List    ${csv}
    @{righe}=   Split To Lines  @{read}
    FOR    ${riga_csv}    IN    @{righe}
        Log To Console    \n${riga_csv}
        TGK_TestUrlup   ${riga_csv}
    END




TGK_Test_UrlPython
    Log To Console    invoco python
    ${esito}=   prova
    Log To Console    ${esito}

    #print_args
    #send_email_py   ${subject}  ${EMAIL_BODY}   ${emailfrom}     ${emailto}     ${PASSWORD}

TGK_test_URLUP
    Log To Console    controllo disponibilita
    ${response}=    Run Keyword And Ignore Error    GET  https://www.googdsdssle.com
    Log To Console    ${response}[0]
    IF    "${response}[0]" == "FAIL"
        Log To Console    Url ko
        ${emailfrom}=   Set Variable    vantonio79@libero.it
        ${emaildest}=   Set Variable    vantonio79@gmail.com
        ${subject}=   Set Variable    Message from RPA Robot
        ${testo}=   Set Variable    <h1>Ciao giove</h1>
        TGK_Send_email  ${emailfrom}    ${emaildest}    ${subject}      ${testo}
        Fatal Error
    END

TGK_Test_SendEmail
#https://robocorp.com/docs/python/rpa-framework/rpa-email-imapsmtp
    Log To Console    invio email
    ${emailfrom}=   Set Variable    vantonio79@gmail.com
    ${emaildest}=   Set Variable    vantonio79@gmail.com
    ${subject}=   Set Variable    Message from RPA Robot
    ${testo}=   Set Variable    <h1>Ciao mondo</h1>RPA Robot message body
    TGK_Send_email  vantonio79@gmail.com    vantonio79@gmail.com
    #Send Message  sender=${GMAIL_ACCOUNT}
    #...           recipients=${RECIPIENT_ADDRESS}
    ##...           subject=Message from RPA Robot
    #...           html=${TRUE}
    #...           body=<h1>Ciao mondo</h1>RPA Robot message body



TGK_Test_URL
    LoginTest   ${url}   ${user}  ${pass}

TGK_Test_logout
    LogoutTest  ${url}   ${user}  ${pass}

*** Keywords ***

TGK_prova
    Log To Console    ok


TGK_TestUrlup
    [Arguments]    ${url}
    #${subject}=   Set Variable              mail di provaaa
    Log To Console    valore di url
    Log To Console    ${url}
    ${response}=    Run Keyword And Ignore Error    GET  ${url}
    Log To Console    ${response}[0]
    IF    "${response}[0]" == "FAIL"
        Log To Console    Url ko
        ${emailfrom}=   Set Variable    vantonio79@libero.it
        ${emaildest}=   Set Variable    vantonio79@gmail.com
        ${subject}=   Set Variable    Message from RPA Robot
        ${testo}=   Set Variable    <h1>${url}</h1>
        TGK_Send_email      ${emailfrom}    ${emaildest}    ${subject}      ${testo}
        Fatal Error     ko
    ELSE
        Log To Console    Url ok
        Pass Execution    ok
    END


LoginTest
    [Arguments]    ${url}   ${username}=A.VORRARO     ${pass}=pass
    ${userapp}=     TGKControllaParametroUrl    1
    ${userpass}=     TGKControllaParametroUrl    2
    ${url}=     TGKControllaParametroUrl    3
    Log To Console    valore di url trovato
    Log To Console    ${url}
    ${condition}=    Run Keyword And Ignore Error   Login    ${url}    ${userapp}    ${userpass}
    Sleep    1s
    ${esito}=   Set Variable    ${condition}[0]
    ${esito}=   Set Variable    FAIL
    Log To Console    valore di esito
    Log To Console    ${esito}
    IF    "${esito}" == "FAIL"
        Log To Console    Invio mmail di notifica
    END

LogoutTest
    [Arguments]    ${url}   ${username}=A.VORRARO     ${pass}=pass
    #LoginTest   ${url}   ${username}=A.VORRARO     ${pass}=pass
    Log To Console    Eseguo log out
    Sleep    5s
    Click Element   //span[text()="Logout"]/../..
    Sleep    5s


   #Log To Console    Url ko
        #${emailfrom}=   Set Variable    vantonio79@libero.it
        #${emaildest}=   Set Variable    vantonio79@gmail.com
        #${subject}=   Set Variable    Message from RPA Robot
        #${testo}=   Set Variable    <h1>${url}</h1>
        #TGK_Send_email      ${emailfrom}    ${emaildest}    ${subject}      ${testo}
        #Log To Console    ho inviato la mail



