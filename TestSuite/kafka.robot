*** Settings ***
Library     SeleniumLibrary
Library     DatabaseLibrary
Library     OperatingSystem
Library     DateTime
Library     Collections
Library     JSONLibrary
Library    RequestsLibrary
Library     ConfluentKafkaLibrary
Library     FakerLibrary

#Library     List
#Resource    ../resources/common/commonRobot.resource
#https://docs.python.org/3/tutorial/venv.html#creating-virtual-environments

*** Variables ***
${nomeTopic}
${numeroMessaggi}
${messaggio}
${server}
${porta}

#robot -v nomeTopic:pippo -v porta:19092 -v server:127.0.0.1 -v numeroMessaggi:1000 -v messaggio:'messaggio.json' -d resultsKafka kafka.robot
*** Test Cases ***


TGK_Test_KafkaConfluenLibrary
    ${P_ID}=    Set Variable    ${0}
    ${i}=   Set Variable    ${0}
    ${producer_id}=  Create Producer  message.timeout.ms=${30000}   port=${porta}   server=${server}
    ${trace_id}=    Evaluate    uuid.uuid4()    modules=uuid
    ${trace_id}=    Convert To String    ${trace_id}
    ${correlation_id}=    Evaluate    uuid.uuid4()    modules=uuid
    ${correlation_id}=    Convert To String    ${correlation_id}
    ${headers}=    Create Dictionary    kafka_replyTopic=tgk.dataprocessing.remote.command.replyto.AVORRARO     x-client-trace-id=${trace_id}      tgk-dataprocessing-remote-audit-replyto=tgk.dataprocessing.remote.audit.replyto.AVORRARO    commandTypeKey=EXECUTE      kafka_correlationId=${correlation_id}
    WHILE    ${i}<${numeroMessaggi}
        ${i}=     Evaluate      ${i}+1
        ${uuid}=    Evaluate    uuid.uuid4()    modules=uuid
        ${uuid}=    Convert To String    ${uuid}
        ${json_object}=	    Load Json From File	    ${messaggio}
        ${json_object}      Update Value To Json	${json_object}	    $..elaborationInfo.elaborationId    FF80818191137E7801911385CB3C0634
        ${json_object}      Update Value To Json	${json_object}	    $..requestPayload.value['e.msgId']    FF80818191137E7801911385CB3C0634
        ${json_object}      Update Value To Json	${json_object}	    $..requestPayload.value['e.shortcut']    FF80818191137E7801911385CB3C0634
        ${json_object}      Update Value To Json	${json_object}	    $..elaborationInfo.elaborationSequenceId    ${uuid}
        ${json_str}=	Convert JSON To String	${json_object}
        Produce  group_id=${producer_id}  topic=${nomeTopic}  value=${json_str}  partition=${P_ID}  headers=${headers}
    END
    Sleep    10s
    Flush   ${producer_id}     timeout=0.1


*** Keywords ***





