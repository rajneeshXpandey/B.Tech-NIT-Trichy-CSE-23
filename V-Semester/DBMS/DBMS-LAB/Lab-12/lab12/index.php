<!DOCTYPE html>

<html>

<head>

    <title>LOGIN</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" type="text/css" href="style.css">

</head>

<body>
    
    <div class="container m-5 p-5">
     <form action="login.php" method="post">
         
         <h2>LOGIN</h2>
         <?php if (isset($_GET['error'])) { ?>
            
            <p class="error"><?php echo $_GET['error']; ?></p>
            
            <?php } ?>
            

        <label>User Name</label>

        <input type="text" name="uname" placeholder="User Name"><br>

        <label>Password</label>

        <input type="password" name="password" placeholder="Password"><br> 

        <button type="submit">Login</button>

     </form>
     </div>
</body>

</html>