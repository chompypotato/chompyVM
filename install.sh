git clone https://github.com/chompypotato/chompyVM
cd chompyVM
pip install textual
sleep 2
python3 installer.py
docker build -t chompyvm . --no-cache
cd ..

sudo apt update
sudo apt install -y jq

mkdir Save
cp -r chompyVM/root/config/* Save

json_file="chompyVM/options.json"
if jq ".enablekvm" "$json_file" | grep -q true; then
    docker run -d --name=chompyVM -e PUID=1000 -e PGID=1000 --device=/dev/kvm --security-opt seccomp=unconfined -e TZ=Etc/UTC -e SUBFOLDER=/ -e TITLE=chompyVM -p 3000:3000 --shm-size="2gb" -v $(pwd)/Save:/config --restart unless-stopped chompyvm
else
    docker run -d --name=chompyVM -e PUID=1000 -e PGID=1000 --security-opt seccomp=unconfined -e TZ=Etc/UTC -e SUBFOLDER=/ -e TITLE=chompyVM -p 3000:3000 --shm-size="2gb" -v $(pwd)/Save:/config --restart unless-stopped chompyvm
fi
clear
echo "chompyVM WAS INSTALLED SUCCESSFULLY! Check Port Tab"
