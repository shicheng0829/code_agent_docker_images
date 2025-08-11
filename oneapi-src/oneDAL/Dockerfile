#===============================================================================
# Copyright 2023 Intel Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#===============================================================================

# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04@sha256:b59d21599a2b151e23eea5f6602f4af4d7d31c4e236d22bf0b62b86d2e386b8f

# Set the working directory
ARG workdirectory="/sources/oneDAL"
WORKDIR ${workdirectory}

# Install system dependencies
RUN apt-get update && \
      apt-get -y install sudo wget gnupg git make python3-setuptools doxygen software-properties-common \
      gcc g++ tree && \
      apt-get clean && \
      rm -rf /var/lib/apt/lists/*

# Install miniconda for ARM64
ENV CONDA_DIR=/opt/conda
RUN wget --quiet \
    "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh" && \
    bash Miniforge3* -b -p /opt/conda && \
    rm Miniforge3*

# Add conda to PATH
ENV PATH=$CONDA_DIR/bin:$PATH

# Install Bazel through conda-forge for ARM64 compatibility
RUN conda install -c conda-forge bazel=8.3.1 && \
    conda clean -afy

# Copy the oneDAL source code into the container
COPY . ${workdirectory}

# Create a conda environment for development
RUN echo "name: ci-env" > environment.yml && \
    echo "channels:" >> environment.yml && \
    echo "  - conda-forge" >> environment.yml && \
    echo "dependencies:" >> environment.yml && \
    echo "  - python=3.12" >> environment.yml && \
    conda env create -f environment.yml && \
    rm environment.yml

# Activate conda environment by default
RUN echo "conda activate ci-env" >> ~/.bashrc
ENV CONDA_DEFAULT_ENV=ci-env

# Print Bazel version to verify installation
RUN conda run -n ci-env bazel --version

# Default command - show Bazel help
CMD ["conda", "run", "-n", "ci-env", "bazel", "help"]