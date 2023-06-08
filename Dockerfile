FROM pytorch/pytorch:1.2-cuda10.0-cudnn7-runtime

RUN mv /etc/apt/sources.list.d/cuda.list /etc/apt/sources.list.d/cuda.list.bak && \
    mv /etc/apt/sources.list.d/nvidia-ml.list /etc/apt/sources.list.d/nvidia-ml.list.bak && \
    apt-get update && apt-get install -y gnupg-curl && apt-key del 7fa2af80 && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub && \
    mv /etc/apt/sources.list.d/cuda.list.bak /etc/apt/sources.list.d/cuda.list && \
    mv /etc/apt/sources.list.d/nvidia-ml.list.bak /etc/apt/sources.list.d/nvidia-ml.list

RUN apt-get update && apt-get install -y libgl1-mesa-glx libpci-dev curl nano psmisc zip git && apt-get --fix-broken install -y

RUN conda install -y faiss-gpu scikit-learn pandas flake8 yapf isort yacs gdown future libgcc -c conda-forge

RUN pip install --upgrade pip && python -m pip install --upgrade setuptools && \
    pip install opencv-python tb-nightly matplotlib logger_tt tabulate tqdm wheel mccabe scipy

COPY ./fonts/* /opt/conda/lib/python3.6/site-packages/matplotlib/mpl-data/fonts/ttf/
