FROM nvidia/cuda:12.9.2-cudnn-devel-ubuntu24.04

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /workspace

RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    bzip2 \
    ca-certificates \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Anaconda
RUN wget https://repo.anaconda.com/archive/Anaconda3-2025.06-0-Linux-x86_64.sh -O /tmp/anaconda.sh && \
    bash /tmp/anaconda.sh -b -p /opt/anaconda && \
    rm /tmp/anaconda.sh

ENV PATH="/opt/anaconda/bin:$PATH"

RUN conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main && \
    conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r
# Install JupyterLab
RUN conda install -y jupyterlab && \
    conda clean -afy

# Data science / ML packages
RUN pip install --no-cache-dir \
    torch \
    torchvision \
    torchaudio \
    tensorflow \
    pandas \
    numpy \
    matplotlib \
    seaborn \
    scikit-learn \
    scipy \
    plotly \
    transformers \
    datasets \
    sentence-transformers \
    langchain \
    openai \
    sqlalchemy \
    psycopg2-binary \
    pymysql \
    pymongo \
    micrograd

EXPOSE 8888

CMD ["jupyter", "lab", \
     "--ip=0.0.0.0", \
     "--port=8888", \
     "--no-browser", \
     "--allow-root", \
     "--NotebookApp.token=", \
     "--NotebookApp.password=", \
     "--notebook-dir=/workspace"]