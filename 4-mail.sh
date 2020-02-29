
#!/bin/bash

if [ $1 -eq 1 ]; then
	sudo apt install mailutils -y
	sudo apt install mutt -y
	sudo apt-get install libsasl2-modules postfix -y
fi

echo "++ Have you set up a password for Postfix? You will need it now."
#wait for user's password to be ready
echo "++ Add the following line to /etc/postfix/sasl/sasl_passwd"
echo "[smtp.gmail.com]:587 raspberrysatellites@gmail.com:password"
while true; do
	read -p "++ Press enter to continue. >  " yn
	case $yn in
		*) break;;
	esac
done

lxterminal -e sudo nano /etc/postfix/sasl/sasl_passwd


while true; do
	read -p "++ Press any key to continue. >" yn
	case $yn in
		*) break;;
	esac
done

sudo postmap /etc/postfix/sasl/sasl_passwd

echo "++ Set hostname to smtp.gmail.com"
echo "++ Set postmaster to raspberrysatellites@gmail.com"
echo "++ Remove anything that says gmail in domains this machine should recognize"
echo "++ Leave everything else on defaults."
while true; do
	read -p "++ Press enter to continue. >  " yn
	case $yn in
		*) break;;
	esac
done

lxterminal -e sudo dpkg-reconfigure postfix

echo "++ Set relayhost to [smtp.gmail.com]:587"
while true; do
	read -p "++ Press enter to continue. >  " yn
	case $yn in
		*) break;;
	esac
done

lxterminal -e sudo nano /etc/postfix/main.cf

a=true
while true; do
	read -p "++ Do you need to update the end of main.cf? [yn] >  " yn
	case $yn in
		[Yy]* ) a=true; break;;
		[Nn]* ) a=false; break;;
		* ) echo "++ Do you need to update the end of main.cf? [yn] >  "
	esac
done

if ${a}; then
	sudo chmod a+w /etc/postfix/main.cf
	sudo echo "" >> /etc/postfix/main.cf
	sudo echo "# Enable SASL authentication" >> /etc/postfix/main.cf
	sudo echo "smtp_sasl_auth_enable = yes" >> /etc/postfix/main.cf
	sudo echo "# Disallow methods that allow anonymous authentication" >> /etc/postfix/main.cf
	sudo echo "smtp_sasl_security_options = noanonymous" >> /etc/postfix/main.cf
	sudo echo "# Location of sasl_passwd" >> /etc/postfix/main.cf
	sudo echo "smtp_sasl_password_maps = hash:/etc/postfix/sasl/sasl_passwd" >> /etc/postfix/main.cf
	sudo echo "# Enable STARTTLS encryption" >> /etc/postfix/main.cf
	sudo echo "smtp_tls_security_level = encrypt" >> /etc/postfix/main.cf
	sudo echo "# Location of CA certificates" >> /etc/postfix/main.cf
	sudo echo "smtp_tls_CAfile = /etc/ssl/certs/ca-certificates.crt" >> /etc/postfix/main.cf
	sudo chown root:root /etc/postfix/main.cf /etc/postfix/main.cf.db
fi

sudo systemctl restart postfix
echo "Hello world" | mutt -s "Message at $(date)" raspberrysatellites@gmail.com -y
