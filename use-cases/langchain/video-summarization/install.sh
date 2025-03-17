#!/bin/bash

dpkg -s sudo &> /dev/null
if [ $? != 0 ]
then
	DEBIAN_FRONTEND=noninteractive apt update
	DEBIAN_FRONTEND=noninteractive apt install sudo -y
fi

# Install Conda
source activate-conda.sh

# one-time installs
if [ "$1" == "--skip" ]; then
	echo "Skipping dependencies"
	activate_conda
else    
        echo "Installing dependencies"
	sudo DEBIAN_FRONTEND=noninteractive apt update
	sudo DEBIAN_FRONTEND=noninteractive apt install git ffmpeg wget -y

	CUR_DIR=`pwd`
  cd /tmp
	miniforge_script=Miniforge3-$(uname)-$(uname -m).sh
	[ -e $miniforge_script ] && rm $miniforge_script
	wget "https://github.com/conda-forge/miniforge/releases/latest/download/$miniforge_script"
	bash $miniforge_script -b -u
	# used to activate conda install
	activate_conda
	conda init
	cd $CUR_DIR

	# neo/opencl drivers 24.45.31740.9
	mkdir neo
	cd neo
	wget https://github.com/intel/intel-graphics-compiler/releases/download/v2.5.6/intel-igc-core-2_2.5.6+18417_amd64.deb
	wget https://github.com/intel/intel-graphics-compiler/releases/download/v2.5.6/intel-igc-opencl-2_2.5.6+18417_amd64.deb
	wget https://github.com/intel/compute-runtime/releases/download/24.52.32224.5/intel-level-zero-gpu-dbgsym_1.6.32224.5_amd64.ddeb
	wget https://github.com/intel/compute-runtime/releases/download/24.52.32224.5/intel-level-zero-gpu_1.6.32224.5_amd64.deb
	wget https://github.com/intel/compute-runtime/releases/download/24.52.32224.5/intel-opencl-icd-dbgsym_24.52.32224.5_amd64.ddeb
	wget https://github.com/intel/compute-runtime/releases/download/24.52.32224.5/intel-opencl-icd_24.52.32224.5_amd64.deb
	wget https://github.com/intel/compute-runtime/releases/download/24.52.32224.5/libigdgmm12_22.5.5_amd64.deb
	sudo dpkg -i *.deb

        # Offline installation of oneapi base toolkit necessary for pytorch
        echo "Installing OneAPI"
        wget https://registrationcenter-download.intel.com/akdlm/IRC_NAS/dfc4a434-838c-4450-a6fe-2fa903b75aa7/intel-oneapi-base-toolkit-2025.0.1.46_offline.sh
        sudo sh ./intel-oneapi-base-toolkit-2025.0.1.46_offline.sh -a --silent --cli --eula accept
        sudo apt update
        sudo apt -y install cmake pkg-config build-essential
	cd ..
	
fi

# Create python environment
conda create -n smolvidsumm python=3.10 -y
conda activate smolvidsumm
echo 'y' | conda install pip

pip install -r requirements.txt
pip install git+https://github.com/huggingface/transformers@v4.49.0-SmolVLM-2
git clone https://github.com/gsilva2016/langchain.git
pushd langchain; git checkout openvino_tts_tool; popd
pip install -e langchain/libs/community
