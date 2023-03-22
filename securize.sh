#!/bin/bash

readonly ERROR_CONFIG_FILE_NOT_EXIST=1

function printHeader(){
	echo ; echo ; echo
	echo "****************************************************************"
	echo "                        $1"
	echo "****************************************************************"
}

function showMessage(){
	case $1 in
		$ERROR_CONFIG_FILE_NOT_EXIST)
			echo "Se esperaba encontrar el fichero de configuración $2"
			echo "Si ese no es el fichero correcto, por favor, indíquelo a continuación."
		;;
		*)
			echo "ERROR! Mensaje no identificado!"
		;;
	esac
}


ficheroConf="/etc/mysql/mysql.conf.d/mysqld.cnf"
ficheroPrueba="sandbox/mysqld.cnf"
ficheroPrueba="sandbox/mysqld.cnffff"

# BORRAR TRAS FINALIZAR LAS PRUEBAS **********************
# cp $ficheroConf $ficheroPrueba
ficheroConf=$ficheroPrueba
# ********************************************************


printHeader "MYSQL Securization"


if [[ ! -f $ficheroConf ]]
then
	showMessage $ERROR_CONFIG_FILE_NOT_EXIST $ficheroConf
	until [ -f $ficheroConf ]
	do
		read -p "Ruta completa: " ficheroConf
	done
fi

sed 's/^bind-address.*=.*0.0.0.0.*$/bind-address=127.0.0.1/' -i $ficheroConf
if [[ $? -eq 0 ]]
then
	echo "Se ha establecido el bind-address a 127.0.0.1 en el fichero $ficheroConf"
	echo "De esta forma se impide la conexión remota al gestor de bases de datos."
else
	echo "No se ha podido cambiar el valor del parámetro bind-address a 127.0.0.1 en el fichero $ficheroConf"
	echo "Revise los permisos del fichero o ejecute este script con sudo."
fi

exit 0
