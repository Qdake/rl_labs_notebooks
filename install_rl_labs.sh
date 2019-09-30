#!/bin/sh

# Alex Coninx
# ISIR CNRS/UPMC
# 12/12/2018


PROXY_HOSTNAME=proxy
PROXY_PORT=3128

BASE_DIR=$PWD

IPYNB_PATCH_FILE="ipynb-utils.patch"

GIT_REPO_USER=osigaud
GIT_REPO_NAME=rl_labs_notebooks


# For pip3
export https_proxy=http://${PROXY_HOSTNAME}:${PROXY_PORT}

# Configure HTTP proxy for git
git config --global http.proxy http://${PROXY_HOSTNAME}:${PROXY_PORT}

# Clone directory
git clone https://github.com/${GIT_REPO_USER}/${GIT_REPO_NAME}

# Jupyter is already installed :) just missing ipynb
pip3 install -q --user ipynb

# Patch ipynb
IPYNB_PATH=`python3 -c "import ipynb; print(ipynb.__path__[0]);"`

cd ${IPYNB_PATH}
patch -p0 < ${BASE_DIR}/${IPYNB_PATCH_FILE}
cd ${BASE_DIR}

#Start notebook
cd ${GIT_REPO_NAME}
jupyter-notebook lab_instructions.ipynb
