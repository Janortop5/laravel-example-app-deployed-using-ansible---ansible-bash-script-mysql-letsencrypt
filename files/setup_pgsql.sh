#!/usr/bin/bash
LINE='host all all 0.0.0.0/0 md5'
FILE='/etc/postgresql/15/main/pg_hba.conf'
sudo apt install wget ca-certificates -y
sudo wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
sudo apt update
sudo apt install postgresql postgresql-contrib -y
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '';"
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/15/main/postgresql.conf
sudo grep -qF -- "$LINE" "$FILE" || echo "$LINE" | sudo tee -a "$FILE"
sudo ufw allow 5432
