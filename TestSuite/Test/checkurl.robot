*** Settings ***
Library    DataDriver       file=${csv}     encoding=utf_8      dialect=unix
Variables       ../../configs/config_guardians_trunk.py
Resource        TGKRepositoryLibrary/include.resource
Resource        TGKRepositoryLibrary/TGK_CheckUrl/TGK_Check_Enviroment_Url.resource

#Test Template    TGK_TestUrlup
Test Template     TGK_TestUrlup
#Test Teardown   Close Browser

*** Variables ***
${csv}
${user}
${pass}
${retry}        100
${interval}     1

#Test Setup      TGKSetupTest

#${csv}
#${browser}          headlesschrome
#${browser}           chrome
#${DOWNLOAD_PATH}
#${SELENIUM_TIMEOUT}    5s
#${IS_ANGULAR}           ${True}
#${logout_vaadin}        xpath=//span[text()="Logout"]
#${proceed_button}       id:proceedButton
#${login_form}
${logout_angular}       //*[@id="tgk-header-avatar-tgkAvatarNoImage"]
${logout_vaadin}       //*[@id="logout-btn"]

*** Test Cases ***

#robot  -v csv:urlcsvok.csv -d results2 testqa2.robot

TGK_CHECK_URL
   TGK_TestUrlup  ${url}   ${user} ${pass}

*** Keywords ***
TGK_TestUrlup
    [Arguments]    ${url}   ${user}     ${pass}
        TGK_Check_enviroment_url    ${url}
        Authenticate to TGK_CHECK_URL     ${user}     ${pass}
        Wait Until Keyword Succeeds    ${retry}    ${interval}    Click Element     ${logout_vaadin}
        Close Browser
		
		








