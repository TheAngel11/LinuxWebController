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

  <h1>Mike Server</h1>
</body>
"
# Parse the query string
dades=`echo $QUERY_STRING` 
tmp=`echo $dades | awk -F= '{print $2}'` 
name=`echo $tmp | awk -F "&" '{print $1}'` 
pasw=`echo $dades | awk -F= '{print $3}'` 
found=`awk -F ":" '{print $1}' /etc/passwd | grep -cx "$name"`

if [ $found -eq 0 ]
then
    echo -e "
      <h3>
        <span>Usuari no trobat</span>
      <h3>
      </br>

      <h1>
          <form action="/login.html" class="cta">
            <input type="submit" value="Return"></input>
          </form>
      </h1>
        "
    logger -t ASO_LOGS "Intent de login fallit (contrasenya incorrecte)."

else 
    shadow_hash=$(grep "^$name:" /etc/shadow | cut -d: -f2)
    salt=`echo $shadow_hash | awk -F "$" '{print $3}'`
    try=$(echo "$pasw" | openssl passwd -6 -salt $salt -stdin)

    if [[ "$try" == "$shadow_hash" ]]; then
        echo "$name" > /srv/www/GlobalVars/username.txt
        echo -e "
          
          <h1>
              <form action="/index.html" class="cta">
                <input type="submit" value="Enter"></input>
              </form>
          </h1>
        "
        logger -t ASO_LOGS "Ha fet login al sistema."
    else
        echo -e "
          <h3>
            <span>Contrasenya incorrecte</span>
          <h3>
          </br>
          
          <h1>
              <form action="/login.html" class="cta">
                <input type="submit" value="Return"></input>
              </form>
          </h1>
        "
        logger -t ASO_LOGS "Intent de login fallit (usuari no trobat)."
        
    fi   

fi

echo -e "
</body>
</html>
"