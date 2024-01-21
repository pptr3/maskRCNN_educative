FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    software-properties-common \
    python3.8 \
    python3-pip \
    git \
    wget \
    unzip

# Copy the code into the container at 
COPY . /app

# Install the dependencies
RUN pip install --no-cache-dir -r /app/requirements.txt

# Download and unzip the dataset
WORKDIR /app

RUN wget https://www.cis.upenn.edu/~jshi/ped_html/PennFudanPed.zip && \
    unzip PennFudanPed.zip && \
    rm PennFudanPed.zip
    
# Download additional files
RUN wget https://raw.githubusercontent.com/pytorch/vision/main/references/detection/engine.py && \
    wget https://raw.githubusercontent.com/pytorch/vision/main/references/detection/utils.py && \
    wget https://raw.githubusercontent.com/pytorch/vision/main/references/detection/coco_utils.py && \
    wget https://raw.githubusercontent.com/pytorch/vision/main/references/detection/coco_eval.py && \
    wget https://raw.githubusercontent.com/pytorch/vision/main/references/detection/transforms.py

# Install Cython
RUN pip install Cython matplotlib pycocotools

# Download pycocotool source
#RUN git clone https://github.com/philferriere/cocoapi /app/cocoapi

# Build and install pycocotool
#WORKDIR /app/cocoapi/PythonAPI
#RUN python3 setup.py install

WORKDIR /app

RUN python3 /app/educative.py