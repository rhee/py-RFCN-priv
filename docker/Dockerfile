FROM nvidia/cuda:8.0-cudnn7-devel-ubuntu14.04
EXPOSE 8888
ENV DEBIAN_FRONTEND=noninteractive

RUN locale-gen ko_KR.UTF-8 && \
 apt-get -y update

RUN apt-get -y install sudo curl build-essential gdb cuda-minimal-build-8-0 \
  libxml2-dev libxslt1-dev \
  python2.7 python2.7-dev python2.7-dbg cython \
  protobuf-compiler libprotobuf-dev libprotobuf-c0-dev \
  liblmdb-dev libleveldb-dev libboost-dev \
  cmake \
  libgoogle-glog-dev libgflags-dev \
  libopencv-dev libhdf5-dev \
  libboost-all-dev libsnappy-dev libatlas-base-dev libatlas-dev \
  vim-nox htop lsof

###RUN apt-get install -y git && \
### (curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash) && \
### apt-get install git-lfs

RUN cd /tmp && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py && \
 pip install --upgrade numpy==1.13 && \
 pip install scikit-learn scikit-image \
  tornado==4.5 jupyter pycocotools tqdm \
  hdbscan==0.6.5 ipywidgets==7.2 widgetsnbextension==3.2.1 \
  jupyter_contrib_nbextensions jupyter_nbextensions_configurator \
  protobuf==2.5 easydict lxml h5py  && \
 pip install opencv-python pandas xmljson numba mlxtend && \
 jupyter nbextension enable --py --sys-prefix widgetsnbextension && \
 jupyter nbextensions_configurator enable --system 

###RUN pip install ipyvolume==0.4.2 && \
### jupyter nbextension enable --py --sys-prefix ipyvolume



# install source to build caffe-rfcn
COPY . /workspace/rfcn

# build caffe-rfcn
RUN cd /workspace/rfcn/caffe-priv && ( \
 cp Makefile.config.example Makefile.config && \
 patch -p2 < ../docker/10-makefile-config.patch && \
 export PATH=/workspace/rfcn/caffe-priv/tools:/workspace/rfcn/caffe-priv/python:/usr/local/nvidia/bin:/usr/local/cuda/bin:$PATH && \
 export PYTHONPATH=/workspace/rfcn/caffe-priv/python:$PYTHONPATH && \
 export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/nvidia/lib:/usr/local/nvidia/lib64:$LD_LIBRARY_PATH && \
 make -j4 && \
 make pycaffe )



ENV UID=1000 GID=1000

RUN cat /workspace/rfcn/docker/_vimrc >> /etc/skel/.vimrc && \
 cp /workspace/rfcn/docker/_start.sh /start.sh && \
 cp /workspace/rfcn/docker/_start-jupyter.sh /start-jupyter.sh && \
 chmod +x /start.sh /start-jupyter.sh && \
 echo 'LANG=ko_KR.UTF-8; export LANG' >> /etc/profile.d/lang-ko.sh && \
 echo 'PATH=/opt/caffe/bin:/usr/local/nvidia/bin:/usr/local/cuda/bin:$PATH; export PATH' >> /etc/profile.d/caffe-priv.sh && \
 cd /workspace/rfcn/caffe-priv && \
 make dist DISTRIBUTE_DIR=/opt/caffe && \
 echo "/opt/caffe/lib" > /etc/ld.so.conf.d/caffe-priv.conf && \
 ldconfig && \
 ln -s /opt/caffe/python/caffe /usr/local/lib/python2.7/dist-packages/caffe


# cleanup apt-things
RUN apt-get clean -y && rm -fr /root/.cache /root/.pip /var/lib/apt/lists/*



ENTRYPOINT [ "/start.sh" ]
CMD [ "bash", "--login" ]

