#!/bin/bash

#apt update
#apt full-upgrade
#do-release-upgrade

#apt install zsh git fonts-font-awesome
#apt install neovim
#apt install python3 python3-pip

# Check commands
check_command() {
    hash "$1" 2>/dev/null || { echo >&2 "I require $1 but it's not installed.  Aborting."; exit 1; }
}

for i in git zsh nvim python3 restic bitwarden cmake
do
    check_command $i
done

if [[ ! -f ~/.resticenv ]]
then
    echo "Please create the restic password file"
    exit
fi

# Write .env

scriptDir=$(dirname -- "$(readlink -f -- "$BASH_SOURCE")")

ln -s $scriptDir/zsh/.zshrc ~/.zshrc
ln -s $scriptDir/zsh/.zshenv ~/.zshenv
ln -s $scriptDir/.config ~/.config

chsh -s "$(which zsh)"

zsh <(curl -L micro.mamba.pm/install.sh)
micromamba config append channels conda-forge
micromamba config append channels nodefaults
micromamba config set channel_priority strict
micromamba self-update

micromamba create -n jupyterlab -c conda-forge python jupyterlab black isort ipywidgets ipympl nb_conda_kernels
micromamba activate jupyterlab
pip install jupyterlab-code-formatter lckr_jupyterlab_variableinspector
micromamba deactivate

micromamba create -n main -c conda-forge "python>=3.12" numpy pandas scipy plotly scikit-learn statsmodels ipykernel pyarrow dask dask-ml
micromamba activate main
#micromamba install pytorch torchvision torchaudio pytorch-cuda=12.1 -c pytorch -c nvidia # for nvidia
pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/rocm5.6

git clone --recursive https://github.com/microsoft/LightGBM .config/LightGBM
cd .config/LightGBM
mkdir build
cd build
cmake ..
make -j4
