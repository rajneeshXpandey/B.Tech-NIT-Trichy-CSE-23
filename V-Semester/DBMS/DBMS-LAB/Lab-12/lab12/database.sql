-- Create database EMP and Make Collection With name "EMPL" and Follow Queries 

--Created Database

 use billing
 switched to DB emp
 
--Create Collection
 db.createCollection("Transaction")

--Insert Records Into EMPL Collection
 db.Transaction.insert([
 {Id:1,ProductId:"p001",ItemID:"i001",CustomerName:"Rajneesh",SalePrice:100},
 {Id:2,ProductId:"p002",ItemID:"i002",CustomerName:"Pandey",SalePrice:200}
 ])

--Display Data in Proper Format 
db.Transaction.find()

--Create Collection
 db.createCollection("Product")

--Insert Records Into EMPL Collection
 db.Product.insert([
 {ProductId:"p001",Name:"Shoes",Brand:"Nike",Price:100},
 {ProductId:"p002",Name:"Shirt",Brand:"Puma",Price:200}
 ])

--Display Data in Proper Format 
db.Product.find()

--Create Collection
 db.createCollection("Cashier")

--Insert Records Into EMPL Collection
 db.Cashier.insert([
 {cash_Id:1,Name:"C1",CellNumber:"C001",SSN:"ssn1",Email:"C1@gmail.com",JoiningDate:"01/01/2019"},
 {cash_Id:2,Name:"C2",CellNumber:"C002",SSN:"ssn2",Email:"C2@gmail.com",JoiningDate:"02/02/2020"}])
 
 db.createCollection("CashierLogin")

--Insert Records Into EMPL Collection
 db.CashierLogin.insert([
 {Name:"cashier",Password:"12345"},}])

--Display Data in Proper Format 
db.Cashier.find()

--Create Collection
 db.createCollection("Customer")

--Insert Records Into EMPL Collection
 db.Customer.insert([
 {cust_ID:1,ProductId:"p001",Barcode:"b1"},
 {cust_Id:2,ProductId:"p002",ItemID:"b2"}
 ])

--Display Data in Proper Format 
db.Customer.find()
--Update Salary Of Employee where Name is "ST" by +8000
db.empl.update({name:"ST"},{$inc:{salary:8000}})

--Update Salary Of All Employee by giving an increment of +4000 each
db.empl.update({},{$inc:{salary:4000}},{multi:true})

--update role of "MSD" as "C and WK"
db.empl.update({name:"MSD"},{$set:{role:"c and WK"}})

--Add a New Field remark to document with name "RS" set Remark as WC
db.empl.update({name:"RS"},{$set:{remark:"WC"}})

--Add a New Field As Number 11,name AK,Salary 10000,role coch without using insert statement. But for Doing So You should have a Record Added woth number 11.
db.empl.update({no:11},{$set:{no:11,name:"AK",salary:10000,role:"coch"}},{upsert:true})

--remove added New Field
db.empl.update({name:"RD"},{$unset:{remark:"WC"}})

--Update the Field "RD" by multiplying with salary by 2
db.empl.update({name:"RD"},{$mul:{salary:2}})

--To Find Document From the empl collection where name begins with S
db.empl.find({name:/^S/})

--To Find Document From the empl collection where name begins with R
db.empl.find({name:/^R/})

--To Find Document From the empl collection where name ends with K
db.empl.find({name:/K$/})

--To Find Document From the empl collection where name ends with D
db.empl.find({name:/S$/})

--To Find Document From the empl collection where name has S in any position
db.empl.find({name:/S/})

--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
--Regular Expression
--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
--(Note: Use Case sensitive allow For that write in Option: "i")

-- To Find Document From the empl collection where name begins with S
db.empl.find({name:{$regex:"^S"}})

-- To Find Document From the empl collection where name begins with S
db.empl.find({name:{$regex:"S",$options:"i"}})

--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
-- Use of $in and $nin (in and notin)
--ㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡㅡ
--(Note: There will not use {} braces in that $in and $nin)

-- Display Documents where in empl collection Field have OB,MOB 
db.empl.find({role:{$in:["OB","MOB"]}})

-- Display Documents where in empl collection Field not have OB,MOB
db.empl.find({role:{$nin:["OB","MOB"]}})