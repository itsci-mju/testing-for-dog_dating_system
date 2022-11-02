*** Settings ***
Library  AppiumLibrary
Library  ExcelLibrary
Library   openpyxl
Library	  Collections
Library   ScreenCapLibrary

*** Variables ***
${BT_SIGNIN}  //*[@text='Login'] 
${Profile_VB}  //*[@text='Profile']
${GOTO_DOG_PF}  //*[@text='']
${BT_DELETE}  //*[@text='']
${CC_DELETE}  //*[@text='CANCEL']
${CF_DELETE}  //*[@text='DELETE']
${alert_dog}     android:id/message
${alert_title}     android:id/alertTitle
${testcaseData} 
${Status}

${US_VB}      	//*[@text='user1']
${PW_VB}      	//*[@text='••••']
${text_wait}     //*[@text='Color Fur']

*** Test Cases ***
TC010_DeleteDog
    Open DogDating Application
    Input Textt
    Open Profile Page
    #Start Video Recording   alias=None  name=TC10_DeleteDog  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1
    Open Excel Document    D://Project_Final//TestData//TC10-DeleteDog(Choice).xlsx  doc_id:TestData_10
    
    ${eclin}    Get Sheet  TestData_10
    FOR    ${i}    IN RANGE   2    ${eclin.max_row+1}
        ${tcid}     Set Variable if    '${eclin.cell(${i},1).value}'=='None'    ${Empty}     ${eclin.cell(${i},1).value} 
        Set Suite Variable   ${testcaseData}  ${tcid}
    DT
        ${Status_1}  ${Message_1}  Run Keyword If    ${i}<=${eclin.max_row}     Check Error page        ${eclin.cell(${i},4).value}
        ${Status}            Set Variable if    '${Status_1}' == 'True'      PASS            FAIL
        Run Keyword If     '${Status}' == 'FAIL'    Capture Page Screenshot    ${EXECDIR}/TestResult/TC010_DeleteDog/Screenshot/${testcaseData}.png
        ${get_message}       Set Variable if    ${i}<=${eclin.max_row}   ${message_1}

    
        ${Error}             Set Variable if    '${Status}' == 'FAIL'      Error      No Error  
        ${Suggestion}        Set Variable if    '${Error}' == 'Error'      ควรแจ้งเตือนให้ผู้ใช้งานว่า "${eclin.cell(${i},4).value}"     -


        Write Excel Cell        ${i}    5       value=${get_message}       sheet_name=TestData_01
        Write Excel Cell        ${i}    6       value=${Status}           sheet_name=TestData_01
        Write Excel Cell        ${i}    7       value=${Error}        sheet_name=TestData_01
        Write Excel Cell        ${i}    8       value=${Suggestion}        sheet_name=TestData_01

     
    Save Excel Document       D://Project_Final//TestResult//TC010_DeleteDog//WriteExcel//TC010-DeleteDog_Result.xlsx
    Close All Excel Documents
    Close Application
    #Stop Video Recording      alias=None   

    END
*** Keywords ***
Open DogDating Application
    Open Application        http://localhost:4723/wd/hub    
                        ...  platformName=Android   
                        ...  platformVersion=9.0   
                        ...  deviceName=emulator-5554 
                        ...  appPackage=com.project0 
                        ...  app=D:/Project_Final/Dog-Dating.apk   
                        ...  appWaitForLaunch=false
                        # ...  newCommandTimeout=60
                        # ...  appWaitDuration=3000
                        # ...  deviceReadyTimeout=5
                        Sleep  5s
  
Input Textt
    Wait Until Page Contains Element  ${US_VB}
    Input Text  ${US_VB}  boo1
    
    Input Text  ${PW_VB}   1234
    Wait Until Page Contains Element   ${BT_SIGNIN} 
    Click Element    ${BT_SIGNIN} 
    Sleep  5s
Open Profile Page
    
    Wait Until Page Contains Element  ${Profile_VB}
    Click Element  ${Profile_VB}
    Wait Until Page Contains Element  ${GOTO_DOG_PF} 
    Click Element  ${GOTO_DOG_PF} 
    Wait Until Page Contains Element   ${text_wait}
    Swipe By Percent	50	90	50	10	6000
    # Swipe By Percent	40  90	60  10   4000
    Wait Until Page Contains Element  ${BT_DELETE} 
    Click Element  ${BT_DELETE} 

Cancle
    # #กรณํีที่ปฎิเสธ
     Sleep  20s
     Wait Until Page Contains Element  ${CC_DELETE} 
     Click Element  ${CC_DELETE}  

DT
    # #กรณีตกลงที่จะลบ
    Wait Until Page Contains Element  ${CF_DELETE}   
    Click Element  ${CF_DELETE}  

Check Error page 
    [Arguments]     ${Actual_Result}
         Log To Console  ${testcaseData}
        IF  "${testcaseData}" == "1"
            Wait Until Page Contains Element    ${alert_dog} 
             ${checkVisible}  Run Keyword And Return Status  Page Should Contain Element   ${alert_dog}    
            Log To Console  ${checkVisible} 
            IF  '${checkVisible}' == 'True'
            Wait Until Element Is Visible   ${alert_dog}
            ${get_message}  Get Text   ${alert_dog}
            ${message}  Convert To String  ${get_message}
            Click Element  ${CF_DELETE}
           END 
            # ${get_message}  Get Text  ${alert_dog} 
            # ${message}  Convert To String  ${get_message}
         END

        IF  '${Actual_Result.strip()}' == '${message.strip()}'
            Set Suite Variable  ${Status}  True
        ELSE
            Set Suite Variable  ${Status}  False
        END

        Log To Console      ${message}
        Log To Console      ${Status}
      [Return]   ${Status}  ${message}

     
       


