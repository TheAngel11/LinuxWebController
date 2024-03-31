#!/bin/bash
echo content-type: text/html
echo
echo -e "
<!DOCTYPE html><html>
<head>
<h3>Pagina web</h3>
</head>
<body>
"
echo -e "<h3>Script</h3>"
who -u > temporal
while read var
do
	echo -e "$var <br/>"
done < "temporal"
echo -e "
</body>
</html>"
