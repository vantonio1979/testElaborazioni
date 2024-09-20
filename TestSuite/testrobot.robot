*** Settings ***
Library     SeleniumLibrary


*** Variables ***

${url}  https://cpm-man-trunk-3.platformteam.saastagetik.com/tagetikcpm/authenticate
${browser}  chrome

*** Test Cases ***

TGK_TEST_PROVA
    TGK_KEY

*** Keywords ***
TGK_KEY
    ${browser_options}=    Create Browser Options
    Open Browser  ${url}    ${browser}    options=${browser_options}
    Sleep 10s
    



Create Browser Options
    [Documentation]   Create additional arguments to pass during ${browser} session initialization
    [Arguments]    ${browser}=${BROWSER}
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




