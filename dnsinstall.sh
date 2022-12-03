#! /bin/bash

installBind() {

	FILE = /etc/named.conf

	if [ -e "$FILE" ]; then

		echo -e "\nbind already installed\n"

    	else

		yum install bind bind-utils -y

	fi

}

downloadFWD() {

	echo -e "\ndownloading fwd.x.x.x\n"

	cd /var/named/

	curl -LJO https://raw.githubusercontent.com/JDFSHU/bind-dns/main/fwd.class.cantor.local.db > fwd.class.cantor.local.db

	cd /bin/


}

downloadREV() {

	echo -e "\nDownloading rev.x.x.x\n"

	cd /var/named

	curl -LJO https://raw.githubusercontent.com/JDFSHU/bind-dns/main/rev.7.168.192.db > rev.7.168.192.db

	cd /bin/

}

replaceNamedConf() {

	cd /etc/

	echo -e "\nReplacing named.conf\n"

	rm named.conf

	curl https://raw.githubusercontent.com/JDFSHU/bind-dns/main/named.conf > named.conf

	cd /bin/


}

fullInstall() {

	echo -e "\nInstalling full package:\n"


		if command -v bind; then

			echo -e "\nBind already installed\n"

		else

			yum install bind bind-utils -y
	
		fi


	downloadFWD

	downloadREV

	replaceNamedConf


}



while :
do
	echo -e "\nWelcome to the DNS install utility. Please select an option (case sensitive):"

	echo -e "\nA: Install bind dns"
	echo "B: Download fwd.x.x.x"
	echo "C: Download rev.x.x.x"
	echo "D: Download named.conf and replace original"
	echo "E: Full Install"
	echo -e "F: Exit utility\n"

	read option1

	if [ $option1 = A ]; then
		installBind

	elif [ $option1 = B ]; then
		downloadFWD

	elif [ $option1 = C ]; then
		downloadREV

	elif [ $option1 = D ]; then
		replaceNamedConf

	elif [ $option1 = E ]; then
		fullInstall
	
	elif [ $option1 = F ]; then
		break

	else
		echo -e "\nPlease select a real option >:(((\n"
		continue

	fi
done
