#!/bin/bash

dpkg -s sudo &> /dev/null
if [ $? != 0 ]
then
	DEBIAN_FRONTEND=noninteractive apt update
	DEBIAN_FRONTEND=noninteractive apt install sudo -y
fi

source activate-conda.sh

# one-time installs
if [ "$1" == "--skip" ]
then
	echo "Skipping chapterization dependencies"
	activate_conda
else
	echo "Installing chapterization dependencies"
	sudo DEBIAN_FRONTEND=noninteractive apt update
	sudo DEBIAN_FRONTEND=noninteractive apt install git ffmpeg vim wget -y

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
	# sudo apt install ocl-icd-libopencl1
	cd ..

fi
echo "Installing chapterization"
# Default Python to Ubuntu 22.04.5
conda create -n langchain_chapterization_env python=3.10.12 -y # for a specific version
conda activate langchain_chapterization_env
echo 'y' | conda install pip

pip install wheel setuptools langchain-openai langchain_community langchain-huggingface
pip install --upgrade-strategy eager "optimum[openvino,nncf]==1.23.3"
git clone https://github.com/gsilva2016/langchain.git
pushd langchain; git checkout openvino_asr_loader; popd
pip install -e langchain/libs/community
