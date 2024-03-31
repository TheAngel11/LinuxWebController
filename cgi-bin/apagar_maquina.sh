#!/bin/bash
echo content-type: text/html
echo
echo -e "
<!DOCTYPE html>
<html>
<head>
<title>Mike Server</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="../CSS/main.css">
<link rel="stylesheet" href="../CSS/retro.css">
</head>

<body>
  <div class="grid"></div>
  <div class="lines"></div>
  <h1>
    <span>Shutting</span>
    <span>Down</span>
  </h1>
  <h2>Mike Server</h2>
  </br>
  <h1>
    <div class="wrapper">
      <a class="cta" href="../login.html">
        <span>Go back Login</span>
      </a>
    </div>
  </h1>
</body>
"
# Adding to the syslog the shutdown of the machine.
logger -t ASO_LOGS "S'ha apagat la maquina."

# We shut down the machine
sudo shutdown -h now
exit 0