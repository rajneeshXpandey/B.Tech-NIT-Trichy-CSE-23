<?php 
include "demo.php";

if (isset($_POST['trans_id']) && isset($_POST['prod_id']) && isset($_POST['item_id']) && isset($_POST['cust_name']) && isset($_POST['sales_price'])) {
    $document = array( 
    "trans_id" => $_POST['trans_id'], 
    "prod_id" => $_POST['prod_id'], 
    "item_id" => $_POST['item_id'],
    "cust_name" => $_POST['cust_name'],
    "sales_price" => $_POST['sales_price']
 );
    $transaction->insertOne($document);
    echo "<div>inserted the transaction</div>";
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
    <link rel="stylesheet" type="text/css" href="style.css">
</head>
<body>
    <div class="container m-5 p-5">
    <form action="transaction.php" method="post">

        <h2>Billing</h2>

        <?php if (isset($_GET['error'])) { ?>

            <p class="error"><?php echo $_GET['error']; ?></p>

        <?php } ?>

        <label>Transaction Id</label>

        <input type="number" name="trans_id" placeholder="Transaction Id"><br> 

        <label>Product Id</label>

        <input type="number" name="prod_id" placeholder="Product Id"><br>

        <label>Item ID</label>

        <input type="number" name="item_id" placeholder="Item ID"><br> 
        
        <label>Customer Name</label>

        <input type="text" name="cust_name" placeholder="Customer Name"><br> 

        <label>Sales Price</label>

        <input type="number" name="sales_price" placeholder="Sales Price"><br> 

        <button type="submit">Add the Transaction</button>

     </form>
     <button><a href="addProduct.php">Add a product</a>
     </button>
    </div>
</body>
</html>