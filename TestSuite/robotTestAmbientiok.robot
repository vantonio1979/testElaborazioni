*** Settings ***
Library     SeleniumLibrary
Library     Collections
Library     RequestsLibrary
#Library    DataDriver       file=url.csv     encoding=utf_8      dialect=unix
Library    DataDriver       file=${csv}     encoding=utf_8      dialect=unix
#Resource    ../resources/common/commonRobot.resource
#Library     RPA.Email.ImapSmtp   smtp_server=smtp.gmail.com  smtp_port=465
Library     RPA.Email.ImapSmtp   smtp_server=smtp.libero.it  smtp_port=25
Task Setup  Authorize Smtp  account=${emailfrom}  password=${PASSWORD}
Library    String
Library    RPA.RobotLogListener
Test Template    TGK_TestUrlup
Test Teardown   Close Browser

*** Variables ***

#Test Setup      TGKSetupTest

${emailfrom}        vantonio79@libero.it
#${PASSWORD}         provAaaa1@
${csv}
${username}
${password}
${url}

*** Test Cases ***

#robot  -v csv:url.csv -d results2 robotTestAmbientiok.robot
#robot  -v csv:url.csv -v username:A.VORRARO -v password:pass -d results2 robotTestAmbientiok.robot
#robot  -v csv:url.csv robotTestAmbientiok.robot
#Wait Until Keyword Succeeds    30s    500ms    TGK check loading bar
#rf-admintools-library
#Devo modificare il seguente file  della common-library
#C:\Users\e-antonio.vorraro\PycharmProjects\git\rf-common-library\library\TGKCommonLibrary\TGK_Auth_4.15.2.resource
#Precisamente devo andare alla keyword Create Browser Options riga 61 del file
#ed aggiungere la seguente riga
#Call Method    ${options}    add_argument    --disable-search-engine-choice-screen

TGK_URL ${url}

*** Keywords ***
TGK_TestUrlup
    [Arguments]    ${url}   ${username}     ${password}
    Log To Console      ${url}
    #Navigate to the page on wrapper vaadin
    ${options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    Call Method    ${options}    add_argument    --disable-search-engine-choice-screen
    Call Method  ${options}  add_argument  --headless
    Open Browser    ${url}      Chrome      options=${options}
    Maximize Browser Window
    ${response}=    Run Keyword And Ignore Error    Wait Until Element Is Visible       id:inputUsername    timeout=100
    IF    "${response}[0]" == "FAIL"
        Fatal Error     ko
    END
    Wait Until Page Contains Element    id:inputUsername   timeout=20s
    Sleep    5s
    ${status}=    Run Keyword And Return Status     Login    ${user}    ${pass}
    IF    "${status}" != "True"
        Fatal Error     ko
    END
    ${status}=    Run Keyword And Return Status     LogoutTest
    IF    "${status}" != "True"
        Fatal Error     ko
    END

LogoutTest
    ${count}=  Get Element Count   //span[text()="Logout"]
    IF    ${count} == 1
        Log To Console    Trovato
        Click Element   //span[text()="Logout"]/../..
    ELSE
        Log To Console    non trovato
        Click Element    id:tgk-header-avatar-tgkAvatarNoImage
        Wait Until Page Contains Element    //span[text()="Logout"]     timeout=100s
        Sleep    2s
        Click Element    //span[text()="Logout"]/..
        Sleep    5s
    END

    [Return]    ${True}


TGK_Send_email
    [Arguments]     ${emailAccount}     ${emailDest}    ${subject}      ${testo}
    Send Message  sender=${emailAccount}
    ...           recipients=${emailDest}
    ...           subject=${subject}
    ...           html=${TRUE}
    ...           body=${testo}

Login
    #[Arguments]    ${username}=A.VORRARO     ${pass}=pass
    [Arguments]    ${user}     ${pass}
    Input Text                          id:inputUsername    ${user}
    Input Password                      id:inputPassword    ${pass}
    Click Element                       id:signInButton
    Sleep                               5s
    ${countProcedeButton}               Get Element Count    id:proceedButton
    IF    ${countProcedeButton} == 1
        Click Element    id:proceedButton
    END
   ${status}=    Run Keyword And Return Status  Wait Until Page Contains Element    //*[@id="tgk.main.header"]/div/div/div[1]/div/div[4]/div   timeout=20s
   #Sleep    5s
   #aspetto che compare elemento della matita in basso a sinistra nella home page
   #Wait Until Page Contains Element    //*[@id="tgk.main.workarea"]/div/div/div/div/div/div/div/div[2]/div/span/span     timeout=100s
   #Wait Until Keyword Succeeds    30s    500ms    TGK check loading bar
   Sleep    10s
   ${countWarning}  Get Element Count   //*[text()="Warning"]
   IF    ${countWarning} == 1
        Log To Console    trovato warning
        Click Element    //*[text()="Warning"]/../div/following-sibling::div
   ELSE
        Log To Console    warning non trovato
   END
   Sleep    5s
   [Return]     ${True}

 TGK check loading bar
    ${loading_indicator}=    SeleniumLibrary.Get Element Attribute    //div[contains(@class, 'v-loading-indicator')]    style
    ${display}=     Get Regexp Matches    ${loading_indicator}    display:(.*?);
    ${expected_display_value}=    Create List    display: none;
    Should Be Equal    ${expected_display_value}    ${display}
    Wait Until Element Is Not Visible   xpath=//div[contains(@class,'v-slot-tgk-progress-layout')]





