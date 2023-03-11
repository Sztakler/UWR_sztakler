<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="utf-8" />
    <title>Zadanie 3</title>
    <meta name="viewport" content="width=device-width" />
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script src="http://cdnjs.cloudflare.com/ajax/libs/mustache.js/0.8.1/mustache.js"></script>
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Raleway&display=swap" rel="stylesheet"> 
    <link rel="stylesheet" href="style.css">

</head>
<body>
    <div class="newest">
        <?php
            echo($_GET["key1"]);
            echo($_POST["key1"]);
            echo($_POST["key2"]);
            echo($_POST["key3"]);
            echo($_POST["key4"]);
            echo("\n");
            echo($_REQUEST["key1"]);
        ?>
    </div>

    <script src="script.js" type="text/javascript"></script>
</body>
