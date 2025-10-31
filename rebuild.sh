SCRIPT_DIR=$(dirname $(readlink -f "$0"))
echo $SCRIPT_DIR
sudo docker build -t dev-container-base $SCRIPT_DIR
