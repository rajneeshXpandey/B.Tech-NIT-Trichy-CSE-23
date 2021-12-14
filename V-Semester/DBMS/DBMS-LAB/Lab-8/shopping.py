import mysql.connector
from datetime import date, datetime
mydb = mysql.connector.connect(host="localhost", user='root', password='12345')

mycursor = mydb.cursor()
mycursor.execute("DROP DATABASE shopDB")
mycursor.execute("CREATE DATABASE shopDB")
mycursor.execute("USE shopDB")
mycursor.execute("Create table product(id int PRIMARY KEY, name varchar(20),category varchar(20), quantity int, price float, discount float, manf date,exp date)")


def insert_record():
        prod_id = int(input("Enter id: "))
        name = input("Enter name: ")
        category = input("Enter category: ")
        quantity = int(input("Enter quantity: "))
        price = float(input("Enter price in RS: "))
        discount = float(input("Enter discount in %: "))
        inputDate = input("Enter the date in format dd/mm/yyyy : ")
        day1, month1, year1 = (inputDate.split('/'))
        manf = date(int(year1), int(month1), int(day1))
        inputDate = input("Enter the date in format dd/mm/yyyy : ")
        day, month, year = inputDate.split('/')
        exp = date(int(year), int(month), int(day))
        sql = "INSERT INTO product(id, name, category, quantity, price, discount,manf, exp) values (%s, %s, %s, %s, %s, %s, %s, %s)"
        val = (prod_id, name, category, quantity, price, discount, manf, exp)
        mycursor.execute(sql, val)
        mydb.commit()
        print("record inserted")


def find_record():
        name = input("Enter name: ")
        sql = f'SELECT * FROM product WHERE name = "{name}"'
        mycursor.execute(sql)
        myresult = mycursor.fetchall()
        if (len(myresult) == 0):
            print("no records")
        else:
            for x in myresult:
                print(x)


def search_category():
        category = input("Enter category: ")
        sql = f'SELECT * FROM product WHERE category = "{category}"'
        # que = (category)
        print(sql)
        mycursor.execute(sql)
        myresult = mycursor.fetchall()
        if (len(myresult) == 0):
            print("no records")
        else:
            for x in myresult:
                print(x)

def update_record():
        prod_id = int(input("Enter id: "))
        price = float(input("Enter price: "))
        sql = f'UPDATE product SET price = "{price}" WHERE id = "{prod_id}"'
        # val = (price, prod_id)
        mycursor.execute(sql)
        mydb.commit()
        print("record updated")


def provide_discount():
        category = input("Enter category: ")
        sql = f'SELECT name, discount FROM product WHERE category = "{category}"'
        # que = (category)
        mycursor.execute(sql)
        myresult = mycursor.fetchall()
        if (len(myresult) == 0):
            print("no records")
        else:
            for x in myresult:
                print(x[0]+' : %d'%x[1])


def delete_record():
        mycursor.execute('SELECT * FROM product')
        myresult = mycursor.fetchall()
        if (len(myresult) == 0):
            print("no records")
        else:
            for x in myresult:
                if (x[7] < datetime.now().date()):
                    print("record with id %d deleted" % x[0])
        sql = f"DELETE FROM product WHERE id = {x[0]}"
        mycursor.execute(sql)
        mydb.commit()


def notify():
        prod_id = int(input("Enter id: "))
        sql = f'SELECT price, discount FROM product WHERE id = {prod_id}'
        que = (prod_id)
        mycursor.execute(sql, que)
        myresult = mycursor.fetchall()
        if (len(myresult) == 0):
            print("no records")
        else:
             s = 0
             for x in myresult:
                s += x[0]
                s -= (x[0]*x[1]*0.01)
             if (s > 1000):
               print("Free shipping")
             else:
               print("no free shipping")

cont = "T"
opt = 0
while (cont == "t" or cont == "T"):
    opt = int(input("1. insert\n2.find\n3.search_in_category\n4.update\n5.provide_discount\n6.delete\n7.notification\nEnter your choice: "))
    if (opt == 1):
        insert_record()
    elif(opt == 2):
        find_record()
    elif(opt == 3):
        search_category()
    elif(opt == 4):
        update_record()
    elif(opt == 5):
        provide_discount()
    elif(opt == 6):
        delete_record()
    elif(opt == 7):
        notify()
    else:
        print("invalid option")
    cont = input("do you want to continue(T/F): ")


