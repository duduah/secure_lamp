#!/bin/bash

ficheroConf="/etc/mysql/mysql.conf.d/mysqld.cnf"
ficheroPrueba="sandbox/mysql.cnf"

# BORRAR TRAS FINALIZAR LAS PRUEBAS **********************
# cp $ficheroConf $ficheroPrueba
ficheroConf=$ficheroPrueba
# ********************************************************

sed 's/^bind-address.*=.*0.0.0.0/bind-address = 127.0.0.1/' sandbox/mysqld.cnf
if [[ $? -eq 0 ]]
then
	echo "Se ha establecido el bind-address a 127.0.0.1 en el fichero $ficheroConf"
else
	echo "No se ha podido cambiar el valor del parámetro bind-address a 127.0.0.1 en el fichero $ficheroConf"
	echo "Revise los permisos del fichero o ejecute este script con sudo."
fi

exit 0
