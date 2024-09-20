*** Settings ***
Library     SeleniumLibrary
Library     DatabaseLibrary
Library     OperatingSystem
Library     JSONLibrary
Library     Collections
Library     RPA.Desktop
#Library    RPA.Browser

*** Variables ***

${url}      https://cpm-man-trunk-3.platformteam.saastagetik.com/tagetikcpm
${user}     A.VORRARO
${pass}     pass


*** Keywords ***


TGKSetupTest
    ${urllogin}=    Set Variable    ${urlbase}${currentversion}
    #${urllogin}=    Set Variable    https://cpm-man-5328-3.platformteam.saastagetik.com/tagetikcpm
    ${urlelab}=  Set Variable    /cockpit/contributor/${dbnameapp}
    #Eseguo il login sul cpm
    ${userapp}=     TGKControllaParametro    1
    ${userpass}=     TGKControllaParametro    2
    Login    ${urllogin}    ${userapp}    ${userpass}

TGKControllaParametroUrl
    [Arguments]     ${parametro}
    #Log To Console    sto qua
    #${valore}
    IF    ${parametro} == 1
        IF    "${userparam}" != "${EMPTY}"
            ${valore}=     Set Variable     ${userparam}
        ELSE
            ${valore}=     Set Variable   ${user}
        END
    END
    IF    ${parametro} == 2
         IF    "${passparam}" != "${EMPTY}"
            ${valore}=     Set Variable     ${passparam}
         ELSE
            ${valore}=     Set Variable   ${pass}
         END
    END
    IF    ${parametro} == 3
         Log To Console    valore di url
         Log To Console    ${url}
         IF    "${url}" == "${EMPTY}"
            ${valore}=     Set Variable     ${urltrunk}
         ELSE
            ${valore}=     Set Variable   ${url}
         END
    END
    [Return]    ${valore}


Login
    [Arguments]    ${username}=A.VORRARO     ${pass}=pass
    #Open Browser                        ${url}          chrome
    #Maximize Browser Window
    #Wait Until Element Is Visible       id:inputUsername
    Sleep    5s
    Input Text                          id:inputUsername    ${username}
    Input Password                      id:inputPassword    ${pass}
    Click Element                       id:signInButton
    Sleep                               5s
    ${countProcedeButton}               Get Element Count    id:proceedButton
    Log To Console    ${countProcedeButton}

    IF    ${countProcedeButton} == 1
        Click Element    id:proceedButton
    END
   #${countWarning}          Get Element Count       //div[@class="popupContent"]
   ${countWarning}  Get Element Count   //div[@class="popupContent"]
   ${condition}=    Run Keyword And Ignore Error   Wait Until Element Is Enabled    //div[@id="cpm.home.buttons.cockpit"]  timeout=10s
    Sleep    5s


TGK_Leggi_dati_DB1
    [Arguments]     ${user}     ${queries}
    ${length} =  Get Length  @{queries}
    Connect To Database    psycopg2    ${DBName}    ${DBUser}    ${DBPass}    ${DBHost}    ${DBPort}
    ${i}=   Set Variable    0
    #eseguo il ciclo sulle query da verificare, ricavete dal file json
    ${dataoggi}     Get Current Date
    ${dataoggi}=    Set Variable    ${dataoggi}[0:10]
    Log To Console    Valore di data oggi
    Log To Console    ${dataoggi}
    WHILE    ${i} < ${length}
        ${query}=       Set Variable    ${queries[0]}[${i}]
        Log To Console    ${query}
        ${i}=     Evaluate      ${i}+1
        @{result}=  Query    ${query}   \   True
        ${counter}=     Set Variable    0
        ${numRec}=  Get Length     ${result}
        ${counter}=     Set Variable    0
        WHILE    ${counter} < ${numRec}
            Log To Console    ${result}[0][userupd]
            Log To Console    ${result}[1][dateupd]
            ${data}     Convert To String    ${result}[1][dateupd]
            ${data}=    Set Variable        ${data}[0:10]
            Log To Console    ${data}
                 Should Be Equal As Strings      ${data}    ${dataoggi}
                 Should Be Equal As Strings      ${user}    ${result}[1][userupd]
                 ${counter}=     Evaluate      ${counter}+1
        END
    END

TGK_Send_email
    [Arguments]     ${emailAccount}     ${emailDest}    ${subject}      ${testo}
    Send Message  sender=${emailAccount}
    ...           recipients=${emailDest}
    ...           subject=${subject}
    ...           html=${TRUE}
    ...           body=${testo}




