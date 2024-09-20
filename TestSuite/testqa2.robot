*** Settings ***
Library     SeleniumLibrary

Library    DataDriver       file=${csv}     encoding=utf_8      dialect=unix
Resource   TGKCommonLibrary/includes_4.15.2.resource

Test Template    TGK_TestUrlup
#Test Teardown   Close Browser

*** Variables ***

#Test Setup      TGKSetupTest

${csv}
#${browser}          headlesschrome
${browser}           chrome
${DOWNLOAD_PATH}
${SELENIUM_TIMEOUT}    5s
${IS_ANGULAR}           ${True}
${logout_vaadin}        xpath=//span[text()="Logout"]
${proceed_button}       id:proceedButton
${login_form}
${logout_angular}       //*[@id="tgk-header-avatar-tgkAvatarNoImage"]

*** Test Cases ***

#robot  -v csv:urlcsvok.csv -d results2 testqa2.robot

#TGK_URL ${url}
TGK_URL

*** Keywords ***
TGK_TestUrlup
    [Arguments]    ${url}   ${user}     ${pass}
        TGK_Check_enviroment_url    ${url}
        Authenticate to TGK     ${user}     ${pass}
        Sleep    10s
        Logout Angular


TGK_Check_enviroment_url
    [Arguments]     ${url}
    ${browser_options}=    Create Browser Options
    Open Browser  ${url}    ${browser}    options=${browser_options}
    Wait Until Page Contains Element      id:inputUsername     timeout=10s
    AUthe
        

Authenticate to TGK
    [Documentation]    Wait that login form appears , populate fields with given user and password and then login.
    ...
    ...                [REQUIREMENTS]: A Browser instance must be active, please call "Open Browser" before use this.
    [Arguments]    ${username}=${USERNAME}    ${password}=${PASSWORD}    ${selenium_timeout}=${SELENIUM_TIMEOUT}
    Set Selenium Timeout    ${selenium_timeout}
    Wait Until Element Is Enabled    id:inputUsername   timeout=10s
    Input Text        id:inputUsername    ${username}
    Input Password    id:inputPassword    ${password}
    Click Element    id:signInButton
    ${user_already_logged_in}=    Run Keyword And Return Status    Wait Until Element Is Visible   ${proceed_button}  10s
    Run Keyword If    ${user_already_logged_in}    Click Element    ${proceed_button}
    Wait Until Element Is Visible    ${logout_angular}     timeout=10s

 Logout
    [Documentation]    Click on logout button and execute a logout action
    [Arguments]    ${isAngular}=${IS_ANGULAR}   ${login_form}=${LOGIN_FORM}
    Logout Angular
    Log    Please wait...
    Wait Until Element Is Visible   id:inputUsername  20s
    #Wait Until Page Contains Element   ${login_form}
    Close Browser


Logout Vaadin
    [Documentation]    Execute logout from Tagetik clicking on logout button on top bar.
    Wait Until Element Is Visible    ${logout_vaadin}      timeout=10s
    Click Element     ${logout_vaadin}

Logout Angular
    [Documentation]    Execute logout from Tagetik clicking on user avatar on top bar and then on logout button.
    Wait Until Element Is Visible    ${user_avatar}     timeout=5s
    Click Element     ${user_avatar}
    Wait Until Element Is Visible    ${logout_angular}     timeout=5s
    Wait  0.5s
    Click Element     //span[text()="Logout"]/..
    #Click Element     ${logout_angular}


Create Browser Options
    [Documentation]   Create additional arguments to pass during ${browser} session initialization
    [Arguments]    ${browser}=${BROWSER}    ${download_path}=${DOWNLOAD_PATH}
    Log     Creating ${BROWSER} browser arguments
    ${browser_arguments}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    IF    "${browser}".lower() == "headlesschrome"
        Call Method    ${browser_arguments}    add_argument    --headless
    ELSE
        Call Method    ${browser_arguments}    add_argument    --start-maximized
    END

    ${download_path_is_present}=  Run Keyword And Return Status    Variable Should Exist    ${download_path}
    IF    ${download_path_is_present} == True
          ${prefs} =    Create Dictionary    download.default_directory=${download_path}
          Call Method    ${browser_arguments}    add_experimental_option    prefs    ${prefs}
    END

    Call Method    ${browser_arguments}    add_argument    --disable-dev-shm-usage
    Call Method    ${browser_arguments}    add_argument    --disable-extensions
    Call Method    ${browser_arguments}    add_argument    --disable-gpu
    Call Method    ${browser_arguments}    add_argument    --disable-infobars
    Call Method    ${browser_arguments}    add_argument    --enable-automation
    Call Method    ${browser_arguments}    add_argument    --ignore-certificate-errors
    Call Method    ${browser_arguments}    add_argument    --no-sandbox
    Call Method    ${browser_arguments}    add_argument    --disable-search-engine-choice-screen
    Log     ${browser_arguments}    DEBUG
    [Return]    ${browser_arguments}

 Check Variable Not Null
    [Documentation]     Asserts that passed ${variable} is not null, if true log value else fails with a message
    [Arguments]    ${variable}
    Should Be True    ('${variable}' != '' or '${variable}' == 'None')   Variable should have a value!
    Log    Variable value is: ${variable}





