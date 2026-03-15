#!/bin/bash

# --- BAGIAN 1: INSTALL PANEL ---
echo "--- INSTALLING PANEL ---"
git clone https://github.com/skyport-team/panel .
npm install
npm link
cp example_config.json config.json
# Paksa port 3000
sed -i 's/5001/3000/g' config.json
npm run seed
# Auto create user admin
echo -e "admin\nadmin@gmail.com\nadmin12345\nadmin12345\nyes" | npm run createUser

# --- BAGIAN 2: INSTALL WINGS (VIA SCRIPT YOUTUBE) ---
echo "--- INSTALLING WINGS ---"
# Masukkan License: 126575, Pilih Menu: 2 (Wings)
printf "126575\n2\n" | bash <(curl -s https://raw.githubusercontent.com/Subhanplays/hostingsetups/main/install-2.sh)

# --- BAGIAN 3: RUNNING BOTH ---
echo "--- STARTING PANEL AND WINGS ---"

# Jalankan Panel di background
node . &

# Tunggu folder wings (skyportd) dibuat oleh script installer
sleep 10

if [ -d "skyportd" ]; then
    cd skyportd
    # Jalankan Wings (Gunakan node karena pm2 sering bermasalah di container)
    node .
else
    echo "Folder wings tidak ditemukan, mungkin installer gagal karena Docker."
    # Jaga container tetap hidup untuk cek log
    tail -f /dev/null
fi
