# <-------- 0. Run tcl script------------>
             # ns name.tcl
             
# every instruction in TCL is a command

# <-------- 1. Use variable in tcl------------>

# assign value to a
set a 0

# ===> $var : use to access value of var 

# operators : evaluate using []
set newa [expr $a+10] 

# to print variable :
puts $a
puts $newa

# !!!!!! alignment are important -->

# <-------- 2. if-else in tcl------------>

# can use [expr ..cond..] instead of {} 
if {$a < 10} {
 puts "a is less than 10"
} else {
 puts "a is greater than 10"
}

# <-------------------- 3. While Loop in TCl Programming --------->

while {$a < 50} {
puts $a
set a [expr $a + 2]
}

# <------------------ 4. For Loop in TCL Programming --------------------->

# "incr var" command is for var++

for {set i 1} {$i <= 10} {incr i} {
puts $i  
}

# <------------ 5. Array in TCL ------->

set arr(0) 10
set arr(1) 20
set arr(2) 30

puts $arr(2)

# associate arrays (custom idx)

set salary("AB") 10000
set salary("CD") 20000
set salary("EF") 30000

puts $salary("CD")


# <--------------- 6.  create procedure (new command / function) in TCL ---------->

proc max {a b} {
if {$a < $b} {
 puts $b
} else {
 puts $a
}
}

max 45 20

          # Return Single/Multiple Values from Procedure
          
proc sum {a b c} {
set result [expr $a + $b + $c]
return $result
}       

set added  [sum 10 20 30]
puts $added

proc fun {} {
return [list 1 2 3 4]
}       

set nums  [fun]
puts $nums


# <----------------7. Global and Local Variable in TCL------------------->

# every vars in proc is Local ....to use global var in proc use "global" keyword

set x 10

proc inc {} {
# use x(global var) here
global x
set x 12
}
puts $x
inc
puts $x


# <----------------8. Create Class and Object in OTcl------------------->

Class Student

# method of class
Student instproc show {} {
 $self instvar name roll city
 puts "Name: $name"
 puts "Roll: $roll"
 puts "City: Scity"
}
# object of class

 Student ob1
 ob1 set name "raj"
 ob1 set roll 1234
 ob1 set city "delhi"

# access 
 puts [ob1 set name]
 puts [ob1 set roll]
 puts [ob1 set city]

 ob1 show

   # ----Write Constructor in OTcl----

Student instproc init () {
 $self instvar name roll city
 set name "default"
 set roll 0
 set city "delhi
}

 Student ob2
 ob2 show
 
    # ----- Write Destructor in OTcl ----
Student instproc destroy () {
puts "Destructor called"
}

Student ob3
ob3 destroy



























