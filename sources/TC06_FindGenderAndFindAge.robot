*** Settings ***
Library  AppiumLibrary
Library  ExcelLibrary
Library   openpyxl
Library	  Collections
Library   ScreenCapLibrary

*** Variables ***
${LOGIN_BT}  //*[@text='Login'] 
${FILTER_BT}  //*[@text='filter']
${GENDER_M}  /hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.view.View/android.widget.RadioButton[1]
${GENDER_ALL}  /hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.view.View/android.widget.RadioButton[2]
${GENDER_FM}  /hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[2]/android.view.View/android.widget.RadioButton[3]
${M_Text}  //*[@text='Male']
${ALL_Text}  //*[@text='All']
${FM_Text}  //*[@text='Female']
*** Keywords ***
Open DogDating Application
    Open Application        http://localhost:4723/wd/hub    
                        ...  platformName=Android   
                        ...  platformVersion=9.0   
                        ...  deviceName=emulator-5554 
                        ...  appPackage=com.project0
                        ...  appActivity=com.project0.MainActivity
                        ...  app=D:/Project_Final/Dog-Dating.apk

OpenHomePage 
    Wait Until Page Contains Element  ${LOGIN_BT}
    Click Element  ${LOGIN_BT}

Check Filter
    Wait Until Page Contains Element  ${FILTER_BT}
    Click Element  ${FILTER_BT}  
   # IF  ''  ##เขียน if เทียบ excel ตำแหน่งที่  2 กับ ${M_Text} ${ALL_Text} ${FM_Text} แล้วคลิก ${GENDER_M} ${GENDER_FM} ${GENDER_ALL}
*** Test Cases ***