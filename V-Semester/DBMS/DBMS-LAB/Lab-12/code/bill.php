<?php
session_start();
if (!$_SESSION['auth']) {
    header("HTTP/1.1 401 Unauthorized");
    exit;
}
require_once __DIR__ . '/vendor/autoload.php';
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->load();
$client = new MongoDB\Client(
    'mongodb://' . $_ENV['MDB_URL'] . '/BILL'
);

$product_coll = $client->BILL->product;
$products = $product_coll->find();


$price_one = $price_two = $price_three = 0;

$product_coll = $client->BILL->product;
$p = $products->toArray();
$name_one = $p[0]['name'];
$name_two = $p[1]['name'];
$name_three = $p[2]['name'];
$price_one = $p[0]['price'];
$price_two = $p[1]['price'];
$price_three = $p[2]['price'];

$id = $name = $prod_one = $prod_two = $prod_three = $price = $res = "";
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $id = $_POST["id"];
    $name = $_POST["name"];
    $prod_one = $_POST["prod_one"];
    $prod_two = $_POST["prod_two"];
    $prod_three = $_POST["prod_three"];

    $price = $prod_one * $price_one + $prod_two * $price_two + $prod_three * $price_three;

    $transaction_coll = $client->BILL->transaction;

    $insertres = $transaction_coll->insertOne([
        'product_id' => [$prod_one, $prod_two, $prod_three],
        'customer_name' => $name,
        'sale_price' => $price
    ]);
}

?>
<html>

<head>
    <title>Transactions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>

</head>

<body>

    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">Bill Portal</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="add_product.php">Add Products</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="bill.php">Transaction</a>
                    </li>
                </ul>
            </div>

            <div class="d-flex">
                <a href='logout.php' class="btn btn-outline-success" type="submit">Logout</a>
            </div>
        </div>
    </nav>
    <div class="container">
        <h4>Get Bill!!!! </h4>
        <form method="post" action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']); ?>">

            <div class="mb-3 row">
                <label for="exampleFormControlInput1" class="col-sm-2 col-form-label">Cusotomer Id</label>
                <div class="col-sm-10">
                    <input type="text" name="id" value="<?php echo $id; ?>" class="form-control" id="exampleFormControlInput1" placeholder="Enter Id">
                </div>
            </div>

            <!-- customer id: <input type="text" name="id" value="<?php echo $id; ?>">
            <span class="error">*</span>
            <br><br> -->

            <div class=" mb-3 row">
                <label for="exampleFormControlInput1" class="col-sm-2 col-form-label">Name</label>
                <div class="col-sm-10">
                    <input type="text" name="name" value="<?php echo $name; ?>" class="form-control" id="exampleFormControlInput1" placeholder="Enter Cus Name">
                </div>
            </div>

            <!-- customer name: <input type="text" name="name" value="<?php echo $name; ?>">
            <span class="error">*</span>
            <br><br> -->
            <div><strong>Products:</strong></div>
            <div class=" mb-3 row">
                <label for="exampleFormControlInput1" class="col-sm-2 col-form-label"><?php echo $name_one; ?> ₹<?php echo $price_one; ?></label>
                <div class="col-sm-10">
                    <input type="number" value=0 name="prod_one" class="form-control" id="prod_one" placeholder="Enter Quantity">
                </div>
            </div>
            <div class=" mb-3 row">
                <label for="exampleFormControlInput1" class="col-sm-2 col-form-label"><?php echo $name_two; ?> ₹<?php echo $price_two; ?></label>
                <div class="col-sm-10">
                    <input type="number" value=0 name="prod_two" class="form-control" id="prod_two" placeholder="Enter Quantity">
                </div>
            </div>
            <div class=" mb-3 row">
                <label for="exampleFormControlInput1" class="col-sm-2 col-form-label"><?php echo $name_three; ?> ₹<?php echo $price_three; ?></label>
                <div class="col-sm-10">
                    <input type="number" value=0 name="prod_three" class="form-control" id="prod_three" placeholder="Enter Quantity">
                </div>
            </div>

            <h2>Total Bill: ₹<span id="price"></span></h2>

            <?php echo
            "<script>
                let prod_one = document.getElementById('prod_one');
                let prod_two = document.getElementById('prod_two');
                let prod_three = document.getElementById('prod_three');

                function updatePrice() {
                    let prod_one_val = prod_one.value;
                    let prod_two_val = prod_two.value;
                    let prod_three_val = prod_three.value;
                    let price = prod_one_val * $price_one + prod_two_val * $price_two + prod_three_val * $price_three;
                    document.getElementById('price').innerHTML = price;
                }

                updatePrice();

                prod_one.addEventListener('change', updatePrice);
                prod_two.addEventListener('change', updatePrice);
                prod_three.addEventListener('change', updatePrice);

            </script>"
            ?>

            <input class="btn btn-primary" type="submit" name="submit" value="Submit">
        </form>
    </div>
</body>

</html>