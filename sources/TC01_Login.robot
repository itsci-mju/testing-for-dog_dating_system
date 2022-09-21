*** Settings ***
Library  AppiumLibrary
Library  ExcelLibrary
Library    openpyxl
Library	      Collections
Library     ScreenCapLibrary

*** Variables ***
${US_VB}      	//*[@text='user1']
${PW_VB}      	//*[@text='••••']
${BT_SIGNIN}  //*[@text='Login'] 
#${excel}     D:\Project_Final\TestData\TC01-Login.xlsx
${alert_login}   android:id/message
${Matching_VB}  //*[@text='Matching']
${submit_alert}  android:id/button1
${testcaseData} 
${Status} 

# ${Profile_page}  //*[@text='Profile']
# ${Me_page}  //*[@text='ME']
# ${SignOut_BT}  //*[@text='Sign Out']

*** Test Cases ***
TC01_Login
    Start Video Recording   alias=None  name=TC01_Login  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1
    Open Excel Document    D://Project_Final//TestData//TC01-Login_1.xlsx  doc_id:TestData_01
    ${eclin}    Get Sheet  TestData_01
    FOR    ${i}    IN RANGE   2    ${eclin.max_row+1}
        Open DogDating Application
        ${tcid}     Set Variable if    '${eclin.cell(${i},1).value}'=='None'    ${Empty}     ${eclin.cell(${i},1).value} 
        Set Suite Variable   ${testcaseData}  ${tcid}
        ${US}     Set Variable if    '${eclin.cell(${i},2).value}'=='None'    ${Empty}     ${eclin.cell(${i},2).value}
        ${PW}     Set Variable if    '${eclin.cell(${i},3).value}'=='None'    ${Empty}     ${eclin.cell(${i},3).value}
    

        KeyInformation     ${US}    ${PW}
        ${Status_1}  ${Message_1}  Run Keyword If    ${i}<=${eclin.max_row}    Check Error page     ${eclin.cell(${i},4).value}
        ${Status}            Set Variable if    '${Status_1}' == 'True'      PASS            FAIL
        Run Keyword If     '${Status}' == 'FAIL'    Capture Page Screenshot    ${EXECDIR}/TestResult/TC01_Login/Screenshot/${testcaseData}.png
        ${get_message}       Set Variable if    ${i}<=${eclin.max_row}   ${message_1}

        

       
        ${Error}             Set Variable if    '${Status}' == 'FAIL'      Error      No Error  
        ${Suggestion}        Set Variable if    '${Error}' == 'Error'      ควรแจ้งเตือนให้ผู้ใช้งานว่า "${eclin.cell(${i},4).value}"     -


        Write Excel Cell        ${i}    5       value=${get_message}       sheet_name=TestData_01
        Write Excel Cell        ${i}    6       value=${Status}           sheet_name=TestData_01
        Write Excel Cell        ${i}    7       value=${Error}        sheet_name=TestData_01
        Write Excel Cell        ${i}    8       value=${Suggestion}        sheet_name=TestData_01

    END  
    Save Excel Document       D://Project_Final//TestResult//TC01_Login//WriteExcel//TC01-Login_Result.xlsx
    Close All Excel Documents
    Close Application
    Stop Video Recording      alias=None

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
                      

KeyInformation 
    [Arguments]   ${username}  ${password}
    Wait Until Page Contains Element  ${US_VB}   10s
    Input Text  ${US_VB}  ${username}
    Input Text  ${PW_VB}  ${password}
    Click Element  ${BT_SIGNIN}

# LogOut
#   Wait Until Page Contains Element  ${Profile_page} 3s
#             Click Element  ${Profile_page} 
#             Click Element  ${Me_page}
#             Click Element  ${SignOut_BT}

#Test Load Data Excel
    # ${wb}    Load Workbook  ${CURDIR}/${excel}
    # ${ws}    Set Variable   ${wb.get_active_sheet()}
    # ${cell}    Set Variable  ${ws.cell(2,1).value}
    # ${body}    Fetch From Right   ${cell}  {}
    # Log To Console  \n\n${body}\n

    
Check Error page 
   [Arguments]    ${Actual_Result}
   Log To Console  ${testcaseData} 

    IF   '${testcaseData}' == '1' or '${testcaseData}' == '5' or '${testcaseData}' == '6' or '${testcaseData}' == '7' or '${testcaseData}' == '8'
           ${message}  Check Home Page  ${Matching_VB} 
           

    ELSE IF  '${testcaseData}' == '14' or '${testcaseData}' == '15' or '${testcaseData}' == '17' or '${testcaseData}' == '18'
         ${message}  Check Home Page  ${Matching_VB} 
        
    ELSE  
        Wait Until Element Is Visible  ${alert_login}
        ${checkVisible}  Run Keyword And Return Status  Page Should Contain Element  ${alert_login}   
        Log To Console  ${checkVisible}
        IF  '${checkVisible}' == 'True'
            Wait Until Element Is Visible  ${alert_login} 
            ${get_message}  Get Text  ${alert_login}
            ${message}  Convert To String  ${get_message}
            Click Element  ${submit_alert}
        END
    END

  IF  '${Actual_Result.strip()}' == '''${message.strip()}'''
            Set Suite Variable  ${Status}  True
        ELSE
            Set Suite Variable  ${Status}  False
        END

        Log To Console      ${Status}
        Log To Console      ${message}

      [Return]   ${Status}  ${message}



Check Home Page
    [Arguments]  ${locator}
    ${Status}   Run Keyword And Return Status   Wait Until Element Is Visible    ${locator}     30s
    ${Result}  Set Variable if    '${Status}'=='True'      เข้าสู่ระบบสำเร็จ            เข้าสู่ระบบไม่สำเร็จ 
    [Return]     ${Result}




    #Test Load Data Excel  
# Test Load Data Excel
#     ${wb}    Load Workbook  ${CURDIR}/${excel}
#     ${ws}    Set Variable   ${wb.get_active_sheet()}
#     ${cell}    Set Variable  ${ws.cell(2,1).value}
#     ${body}    Fetch From Right   ${cell}  {}
#     Log To Console  \n\n${body}\n
      



