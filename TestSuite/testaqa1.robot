*** Settings ***
Documentation       Run test for Diagnostic show form

Variables           ../config/config.py
Resource            TGKCommonLibrary/includes_4.15.2.resource
Resource            TGKCommonLibrary/TGK_VaadinComponentLibrary/includes.resource
Resource            TGKCommonLibrary/TGK_Navigation_4.15.2.resource


Library     SeleniumLibrary
Library     Collections
Library     RequestsLibrary
Library    String

# Scommentare riga sopra e commentare riga sotto (l'ambiente systemdemo ha l'idp)
# Suite Teardown    Logout Angular

#robot  -v csv:url.csv -v user:A.VORRARO -v pass:pass -d results2 testqa.robot

*** Variables ***
${IS_ANGULAR}    ${False}
${usrname}
${password}
${csv}
${page}=    https://cpm-man-trunk-31.platformteam.saastagetik.com/tagetikcpm

*** Keywords ***





*** Test Cases ***
TGK_URL
    ${options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    Call Method    ${options}    add_argument    --disable-search-engine-choice-screen
    Call Method  ${options}  add_argument  --headless
    Open Browser    ${page}      Chrome      options=${options}
    Maximize Browser Window
    Navigate to the page on wrapper vaadin  ${page}
