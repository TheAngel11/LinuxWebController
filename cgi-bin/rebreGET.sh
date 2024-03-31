#!/bin/bash 
echo Content-Type: text/html 
echo echo -e "<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Strict//EN" 
"http://www.w3.org/TR/html4/strict.dtd">
<html> 
<head> 
<h3> Servidor Web d’ADS </h3>
</head> 
<body>
"
echo -e "<h3>Script rebre GET</h3>" #cal consultar la query string on hi ha les dades del formulari dades=‘echo $QUERY_STRING‘ echo -e "les dades enviades: $dades <br/>" echo -e "fixem-nos que cont´e tant el nom del par`ametre com el contingut. <br />Caldr`a manipular la cadena per a obtenir el valor. Emprarem awk o sed:<br />"
v=‘echo $dades | awk -F= ’{print $2}’‘ 
echo -e "El valor ´es: $v" echo -e "
</body>
</html>
"