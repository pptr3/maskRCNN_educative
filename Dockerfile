FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    software-properties-common \
    python3.8 \
    python3-pip \
    git \
    wget \
    unzip

# Copy the code into the container at /app
COPY . /app/

# Install the dependencies
RUN pip install --no-cache-dir -r /app/requirements.txt

# Download and unzip the dataset
WORKDIR /app/

RUN wget https://www.cis.upenn.edu/~jshi/ped_html/PennFudanPed.zip && \
    unzip PennFudanPed.zip && \
    rm PennFudanPed.zip
    
# Download additional files
RUN wget https://raw.githubusercontent.com/pytorch/vision/main/references/detection/engine.py && \
    wget https://raw.githubusercontent.com/pytorch/vision/main/references/detection/utils.py && \
    wget https://raw.githubusercontent.com/pytorch/vision/main/references/detection/coco_utils.py && \
    wget https://raw.githubusercontent.com/pytorch/vision/main/references/detection/coco_eval.py && \
    wget https://raw.githubusercontent.com/pytorch/vision/main/references/detection/transforms.py

RUN python3 /app/educative.py