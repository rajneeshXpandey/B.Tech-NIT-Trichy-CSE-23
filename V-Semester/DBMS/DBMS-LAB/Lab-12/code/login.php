<?php
session_start();
?>


<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj" crossorigin="anonymous"></script>
</head>

<body>
    <div class="container">
        <div class="wrapper">
            <form action="login.php" method="post" name="Login_Form" class="form-signin">
                <div class="mb-3">
                    <label for="exampleInputEmail1" class="form-label">Name</label>
                    <input type="email" class="form-control" id="exampleInputEmail1" name="email" placeholder="email" required>
                </div>
                <div class="mb-3">
                    <label for="exampleInputPassword1" class="form-label">Password</label>
                    <input type="password" class="form-control" name="Password" placeholder="Password" id="exampleInputPassword1" required>
                </div>
                <button type="submit" name="Submit" class="btn btn-primary">Login</button>
            </form>
            <?php
            if (isset($_POST['Submit'])) {

                $email = $_POST['email'];
                $password = $_POST['Password'];

                require_once __DIR__ . '/vendor/autoload.php';
                $dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
                $dotenv->load();
                $client = new MongoDB\Client(
                    'mongodb://'.$_ENV['MDB_URL'].'/BILL'
                );

                $cashier_coll = $client->BILL->cashier;
                
                $findOneCashierRes = $cashier_coll->findOne(array('email' => $email, 'ssn' => $password));

                if ($findOneCashierRes) {

                    $_SESSION['user'] = $email;
                    $_SESSION['auth'] = true;
                    header('Location: home.php');
                    echo '<div class="alert alert-success" role="alert">
                            <strong>Success!</strong> You are logged in.</strong>
                        </div>';
                } else {
                    echo '<div class="alert alert-danger" role="alert">
                            <strong>Error!</strong> Wrong email or password.</strong>
                        </div>';
                }
            }
            ?>
        </div>
    </div>
</body>
