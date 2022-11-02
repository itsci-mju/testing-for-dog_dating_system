*** Settings ***
Library  AppiumLibrary
Library  ExcelLibrary
Library   openpyxl
Library	  Collections
Library   ScreenCapLibrary
   
*** Variables ***
${LINK_SIGIN}  //*[@text='Signup']
&{REGIS_INF}   name=Nattaporn Siriboon  email=boobeamzz@gmail.com  tel=0615055570  bd=13052001  address=79 Moo.4 Sansai Chiangmai 50290  username=boobeamzz  password=1234  cfpassword=1234
${NAME_FIELD}  //*[@text='Mr.Test']
${EMAIL_FIELD}  //*[@text='test@mail.com']
${TEL_FIELD}  	//*[@text='053873015']
${BD_FIELD_YEAR}   //*[@text='2007']
${BD_BT_PV}  android:id/prev  #กด 5 รอบ
#${BD_DAY}  //android.view.View[@content-desc="13 April 2007"]
${BD_OK}  //*[@text='OK']

${AD_FIELD}  //*[@text='63 Moo.4 Sansai Chiangmai 50290']
${USERNAME_FIELD}  	 //*[@text='testuser']
${PASSWORD_FIELD}  	 //*[@text='••••'][1]
${CFPASSWORD_FIELD}   //android.widget.EditText[@index=6]
${BT_CANCEL}  	 //*[@text='Cancel']
${BT_SUBMIT}  	 //*[@text='Submit']
${CHOOSE_FILE}   //*[@text='']
${CHOOSE_FILE_BT}  //*[@text='']
${SELECT_PIC}   //*[@text='Download']
${PIC_PROFILE}   //android.view.ViewGroup[@content-desc="Photo taken on Aug 30, 2019 9:53:41 AM"]
${BACK_PIC}  //android.widget.ImageButton[@content-desc="Navigate up"]
${DATE_SELECT}  //*[@text='']
${SELECT_YEAR}  android:id/date_picker_header_year

${testcaseData} 
${Status} 

${Matching_SIGNIN}  //*[@text='Login'] 
${alert_regis}   android:id/message
${submit_alert}  //*[@text='OK']
 

    
*** Test Cases ***
TC02_Register
    # Open DogDating Application
    # Open Register Page
    #Start Video Recording   alias=None  name=TC02_Register  fps=None    size_percentage=1   embed=True  embed_width=100px   monitor=1
    Open Excel Document    D://Project_Final//TestData//TC02-Register.xlsx  doc_id:TestData_02
    ${eclin}    Get Sheet  TestData_02

     FOR    ${i}    IN RANGE   9    ${eclin.max_row+1}
        Open DogDating Application
        Open Register Page
        ${tcid}   Set Variable if    '${eclin.cell(${i},1).value}'=='None'    ${Empty}     ${eclin.cell(${i},1).value} 
        Set Suite Variable   ${testcaseData}  ${tcid}
        ${NM}     Set Variable if    '${eclin.cell(${i},2).value}'=='None'    ${Empty}     ${eclin.cell(${i},2).value}
        ${EM}     Set Variable if    '${eclin.cell(${i},3).value}'=='None'    ${Empty}     ${eclin.cell(${i},3).value}
        ${TEL}    Set Variable if    '${eclin.cell(${i},4).value}'=='None'    ${Empty}     ${eclin.cell(${i},4).value}
        #ข้าม 5 ไป เพราะ 5 คือวันเกิด จะเทสแบบ Manual
        ${AD}     Set Variable if    '${eclin.cell(${i},6).value}'=='None'    ${Empty}     ${eclin.cell(${i},6).value}
        ${US}     Set Variable if    '${eclin.cell(${i},7).value}'=='None'    ${Empty}     ${eclin.cell(${i},7).value}
        ${PW}     Set Variable if    '${eclin.cell(${i},8).value}'=='None'    ${Empty}     ${eclin.cell(${i},8).value}
        ${CPW}    Set Variable if    '${eclin.cell(${i},9).value}'=='None'    ${Empty}     ${eclin.cell(${i},9).value}
        #ข้าม 10 ไป เพราะ10 จะเทสแบบ Manual
        
        Choose Pic Profile
        Input Name Email Tel Field   ${NM}      ${EM}     ${TEL}
        BirthDay Field
        Input Account Field    ${AD}    ${US}    ${PW}    ${CPW}
        
        ${Status_2}  ${Message_2}  Run Keyword If    ${i}<=${eclin.max_row}    Check Error page     ${eclin.cell(${i},11).value}
        ${Status}            Set Variable if    '${Status_2}' == 'True'      PASS            FAIL
        Run Keyword If     '${Status}' == 'FAIL'    Capture Page Screenshot    ${EXECDIR}/TestResult/TC02_Register/Screenshot/${testcaseData}.png
        ${get_message}       Set Variable if    ${i}<=${eclin.max_row}   ${message_2}

        ${Error}             Set Variable if    '${Status}' == 'FAIL'      Error      No Error  
        ${Suggestion}        Set Variable if    '${Error}' == 'Error'      ควรแจ้งเตือนให้ผู้ใช้งานว่า "${eclin.cell(${i},11).value}"  

        Write Excel Cell        ${i}    12      value=${get_message}       sheet_name=TestData_02
        Write Excel Cell        ${i}    13       value=${Status}           sheet_name=TestData_02
        Write Excel Cell        ${i}    14       value=${Error}            sheet_name=TestData_02
        Write Excel Cell        ${i}    15       value=${Suggestion}       sheet_name=TestData_02   


    END
    
    Save Excel Document       D://Project_Final//TestResult//TC02_Register//WriteExcel//TC02-Register_Result.xlsx
    Close All Excel Documents
    Close Application
    #Stop Video Recording      alias=None


*** Keywords ***
Open DogDating Application
    Open Application        http://localhost:4723/wd/hub    
                        ...  platformName=Android   
                        ...  platformVersion=9.0   
                        ...  deviceName=emulator-5554 
                        ...  appPackage=com.project0
                        ...  appActivity=com.project0.MainActivity
                        ...  app=D:/Project_Final/Dog-Dating.apk
#ไปหน้าสมัครสมาชิก
Open Register Page
   Wait Until Page Contains Element   ${LINK_SIGIN}  10s
            
            Click Element  ${LINK_SIGIN}


#เลือกรูปโปรไฟล์
Choose Pic Profile
   
    Wait Until Page Contains Element  ${CHOOSE_FILE} 
    Click Element  ${CHOOSE_FILE} 
    Click Element  ${CHOOSE_FILE_BT}
    Wait Until Page Contains Element  ${SELECT_PIC}
    Click Element  ${SELECT_PIC}
    Wait Until Page Contains Element  ${PIC_PROFILE}
    Click Element  ${PIC_PROFILE}
    Wait Until Page Contains Element  ${BACK_PIC}
    Click Element  ${BACK_PIC}

#กรอก ชื่อ อีเมล เบอร์ 
Input Name Email Tel Field
    [Arguments]  ${NM}      ${EM}     ${TEL}
    Wait Until Page Contains Element  ${NAME_FIELD} 
    Input Text   ${NAME_FIELD}    ${NM} 
    Input Text   ${EMAIL_FIELD}   ${EM}
    Input Text   ${TEL_FIELD}     ${TEL}

#กรอกวันเกิด
BirthDay Field
    #วันเกิด
     Wait Until Page Contains Element  ${DATE_SELECT}
     Click Element  ${DATE_SELECT}
     Wait Until Page Contains Element  ${SELECT_YEAR}
     Click Element  ${SELECT_YEAR} 
     #ลูปเลื่อนหน้าจอของวันเกิด   
    FOR    ${i}    IN RANGE    4      
         Swipe By Percent	50  40	50  70   4000
    END
    Wait Until Page Contains Element  ${BD_FIELD_YEAR} 
    Click Element  ${BD_FIELD_YEAR} 
    #ลูปเดือนเกิด
    FOR    ${i}    IN RANGE    7
        Wait Until Page Contains Element  ${BD_BT_PV}
        Click Element    ${BD_BT_PV}
    END
    Wait Until Page Contains Element  //android.view.View[@content-desc="13 April 2007"]
    Click Element   //android.view.View[@content-desc="13 April 2007"]
    Click Element   ${BD_OK}
    Sleep  5s
    
   #จบวันเกิด
#กรอกบัญชีผู้ใช้
Input Account Field
    [Arguments]  ${AD}    ${US}    ${PW}    ${CPW}
    Wait Until Page Contains Element  ${AD_FIELD}
    Swipe By Percent	50	90	50	10	4000
  
#Account
    Input Text   ${AD_FIELD}            ${AD} 
    Wait Until Page Contains Element    ${USERNAME_FIELD} 
    Input Text   ${USERNAME_FIELD}      ${US}
    Wait Until Page Contains Element    ${PASSWORD_FIELD} 
    Input Text   ${PASSWORD_FIELD}      ${PW}
    Wait Until Page Contains Element    ${CFPASSWORD_FIELD} 
    Input Text   ${CFPASSWORD_FIELD}    ${CPW}

Test cfpass
    [Arguments]  ${CPW}
    Wait Until Page Contains Element  ${AD_FIELD}
    Swipe By Percent	50	90	50	10	4000
    Wait Until Page Contains Element    ${CFPASSWORD_FIELD} 
    Input Text   ${CFPASSWORD_FIELD}    ${CPW}


Check Error page 
   [Arguments]    ${Actual_Result}
   Log To Console  ${testcaseData} 

    IF   '${testcaseData}' == '22' or '${testcaseData}' == '23' or '${testcaseData}' == '25' or '${testcaseData}' == '26' or '${testcaseData}' == '27' or '${testcaseData}' == '28' or '${testcaseData}' == '37' or '${testcaseData}' == '38' or '${testcaseData}' == '39' or '${testcaseData}' == '40'  
           ${message}  Check Login Page  ${Matching_SIGNIN}   
           

    ELSE IF  '${testcaseData}' == '43' or '${testcaseData}' == '44' or '${testcaseData}' == '51' or '${testcaseData}' == '54' or '${testcaseData}' == '56' or '${testcaseData}' == '57' or '${testcaseData}' == '58' or '${testcaseData}' == '59'or '${testcaseData}' == '66' or '${testcaseData}' == '67'
         ${message}  Check Login Page  ${Matching_SIGNIN}   
    
    ELSE IF  '${testcaseData}' == '68' or '${testcaseData}' == '69' or '${testcaseData}' == '75' or '${testcaseData}' == '76' or '${testcaseData}' == '78' or '${testcaseData}' == '79' or '${testcaseData}' == '84' or '${testcaseData}' == '85'or '${testcaseData}' == '86' or '${testcaseData}' == '87'
         ${message}  Check Login Page  ${Matching_SIGNIN}  

    ELSE IF  '${testcaseData}' == '88' or '${testcaseData}' == '89' or '${testcaseData}' == '93' 
         ${message}  Check Login Page  ${Matching_SIGNIN}   
        
    ELSE  
        Wait Until Element Is Visible  ${alert_regis}
        ${checkVisible}  Run Keyword And Return Status  Page Should Contain Element  ${alert_regis}   
        Log To Console  ${checkVisible}
        IF  '${checkVisible}' == 'True'
            Wait Until Element Is Visible  ${alert_regis} 
            ${get_message}  Get Text  ${alert_regis}
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

Check Login Page
    [Arguments]  ${locator}
    ${Status}   Run Keyword And Return Status   Wait Until Element Is Visible    ${locator}     30s
    ${Result}  Set Variable if    '${Status}'=='True'      สมัครสมาชิกสำเร็จ            สมัครสมาชิกไม่สำเร็จ 
    [Return]     ${Result}

    

   

     


# Regis Confirm
#     Click Element  ${BT_SUBMIT} 


