<?php 
include "demo.php";

if (isset($_POST['prod_id']) && isset($_POST['prod_name']) && isset($_POST['prod_brand']) && isset($_POST['prod_price'])) {
    $document = array( 
    "prod_id" => $_POST['prod_id'], 
    "prod_name" => $_POST['prod_name'], 
    "prod_brand" => $_POST['prod_brand'],
    "prod_price" => $_POST['prod_price']
 );
    $product->insertOne($document);
    echo "<div>inserted the product</div>";
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container m-5 p-5">
    <form action="addProduct.php" method="post">

        <h2>add Product</h2>

        <?php if (isset($_GET['error'])) { ?>

            <p class="error"><?php echo $_GET['error']; ?></p>

        <?php } ?>

        <label>Product Id</label>

        <input type="number" name="prod_id" placeholder="Product Id"><br> 

        <label>Product Name</label>

        <input type="text" name="prod_name" placeholder="Product Name"><br>

        <label>Product Brand</label>

        <input type="text" name="prod_brand" placeholder="Product Brand"><br> 
        
        <label>Product Price</label>

        <input type="number" name="prod_price" placeholder="Product Price"><br> 

        <button type="submit">Add the product</button>

     </form>
     <button><a href="transaction.php">Transaction</a>
     </button>
     </div>
</body>
</html>