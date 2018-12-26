:
image=${image-rfcn-gpu-devel:0.1}
name=${name-rfcn}
jupyter_port=${jupyter_port-58989}

docker run --privileged --runtime nvidia --name ${name} --rm -it \
    -e UID=$(id -u) \
    -e GID=$(id -g) \
    -p ${jupyter_port}:8888 \
    -v /etc/localtime:/etc/localtime:ro \
    -v /data:/data \
    -v $HOME:$HOME \
    -v $(pwd):$(pwd) \
    -w $(pwd) \
    "$image" \

#    /start.sh
