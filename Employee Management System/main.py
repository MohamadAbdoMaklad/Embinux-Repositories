from authentication import *
from employee_data  import *
from operations     import *
import os

def menu():
    print("Select an option:")
    print("1. Display Employee Information")
    print("2. Calculate Bonus")
    print("3. Calculate Discount")
    print("4. Remind Legal Holidays")
    print("5. Exit")
    return int(input("Option: "))

def SubMenu():
    return int(input("1. Continue\t 2. Back\t::"))

if __name__ == "__main__":
    EntryFlag = True
    while(EntryFlag):
        os.system('cls')
        print("Welcome to the Embloyee Management System")
        print("Pleas login to continue.")
        SessionUser_ID = authenticateUser()
        if  SessionUser_ID == "ERROR_In_PASSWORD":
            os.system('cls')
            print("Incorrect Password")
            print("Login Failed!")
            break
        elif  SessionUser_ID == "ERROR_In_ID":
            os.system('cls')
            print("Incorrect User ID")
            print("Login Failed!")
            break
        else:
            os.system('cls')
            print("Login Successful!")
        SubMenuFlag = False
        while SessionUser_ID in employee_DB.keys():
            if SubMenuFlag == False:
                Option = menu()
            if Option == 1:
                os.system('cls')
                ID = input("Enter Employee ID : ")
                DisplayEmployeeInfo(ID)
                SubMenuVal = SubMenu()
                if SubMenuVal == 1:
                    SubMenuFlag = True
                elif SubMenuVal == 2:
                    SubMenuFlag = False
                os.system('cls')
            elif Option == 2:
                os.system('cls')
                ID = input("Enter Employee ID : ")
                print("Bonus : $",Calc_Bonus(ID))
                SubMenuVal = SubMenu()
                if SubMenuVal == 1:
                    SubMenuFlag = True
                elif SubMenuVal == 2:
                    SubMenuFlag = False
                os.system('cls')
            elif Option == 3:
                os.system('cls')
                ID = input("Enter Employee ID : ")
                print("Discount : $",Calc_Discount(ID))
                SubMenuVal = SubMenu()
                if SubMenuVal == 1:
                    SubMenuFlag = True
                elif SubMenuVal == 2:
                    SubMenuFlag = False
                os.system('cls')
            elif Option == 4:
                os.system('cls')
                ID = input("Enter Employee ID : ")
                print("Remind Legal Holidays : ",Calc_RemHolidays(ID))
                SubMenuVal = SubMenu()
                if SubMenuVal == 1:
                    SubMenuFlag = True
                elif SubMenuVal == 2:
                    SubMenuFlag = False
                os.system('cls')
            elif Option == 5:
                EntryFlag = False
                os.system('cls')
                print("Thank yoy for using Employee Management System")
                break
            
            