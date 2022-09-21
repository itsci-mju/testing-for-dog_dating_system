*** Settings ***
Library  AppiumLibrary
   
*** Variables ***
${LINK_SIGIN}  //*[@text='Signup']
&{REGIS_INF}   name=Nattaporn Siriboon  email=boobeamzz@gmail.com  tel=0615055570  bd=13052001  address=79 Moo.4 Sansai Chiangmai 50290  username=boobeamzz  password=1234  cfpassword=1234
${NAME_FIELD}  //*[@text='Mr.Test']
${EMAIL_FIELD}  //*[@text='test@mail.com']
${TEL_FIELD}  	//*[@text='053873015']
${BD_FIELD_YEAR}   //*[@text='2007']
${BD_BT_PV}  android:id/prev  #กด 5 รอบ
${BD_DAY}  //android.view.View[@content-desc="13 April 2007"]
${BD_OK}  //*[@text='OK']

${AD_FIELD}  //*[@text='63 Moo.4 Sansai Chiangmai 50290']
${USERNAME_FIELD}  	 //*[@text='testuser']
${PASSWORD_FIELD}  	 //*[@text='••••'][1]
${CFPASSWORD_FIELD}   //*[@text='••••'][2]
${BT_CANCEL}  	 //*[@text='Cancel']
${BT_SUBMIT}  	 //*[@text='Submit']
${CHOOSE_FILE}   //*[@text='']
${CHOOSE_FILE_BT}  //*[@text='']
${SELECT_PIC}   //*[@text='Download']
${PIC_PROFILE}   //android.view.ViewGroup[@content-desc="Photo taken on Aug 30, 2019 9:53:41 AM"]
${BACK_PIC}  //android.widget.ImageButton[@content-desc="Navigate up"]
${DATE_SELECT}  //*[@text='']
${SELECT_YEAR}  android:id/date_picker_header_year

 
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

#กรอกข้อมูล
Register Input Text
#    #เลือกรูปโปรไฟล์
    Wait Until Page Contains Element  ${CHOOSE_FILE} 
    Click Element  ${CHOOSE_FILE} 
    Click Element  ${CHOOSE_FILE_BT}
    Wait Until Page Contains Element  ${SELECT_PIC}
    Click Element  ${SELECT_PIC}
    Wait Until Page Contains Element  ${PIC_PROFILE}
    Click Element  ${PIC_PROFILE}
    Wait Until Page Contains Element  ${BACK_PIC}
    Click Element  ${BACK_PIC}

   Wait Until Page Contains Element  ${NAME_FIELD} 
    Input Text   ${NAME_FIELD}  ${REGIS_INF}[name]
    Input Text   ${EMAIL_FIELD}   ${REGIS_INF}[email]
    Input Text   ${TEL_FIELD}   ${REGIS_INF}[tel]

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
    FOR    ${i}    IN RANGE    5
        Wait Until Page Contains Element  ${BD_BT_PV}
        Click Element    ${BD_BT_PV}
    END
    Wait Until Page Contains Element  ${BD_DAY}
    Click Element  ${BD_DAY}
    Click Element  ${BD_OK}
    
   #จบวันเกิด
   
    Wait Until Page Contains Element  ${AD_FIELD}
    Swipe By Percent	50	90	50	10	4000
  
#Account
    Input Text   ${AD_FIELD}  ${REGIS_INF}[address]
    Input Text   ${USERNAME_FIELD}  ${REGIS_INF}[username]
    Input Text   ${PASSWORD_FIELD}  ${REGIS_INF}[password]
    Input Text   ${CFPASSWORD_FIELD}  ${REGIS_INF}[cfpassword]
   

    

   

     


# Regis Confirm
#     Click Element  ${BT_SUBMIT} 

    
*** Test Cases ***
TC02_Register
    Open DogDating Application
    Open Register Page
    Register Input Text
    #Regis Confirm

