#!/bin/bash
# set -x

# ENV_DIR folder for Python Virtual Environments
# read more on https://docs.python.org/3/tutorial/venv.html
ENV_DIR="env"


function print_line() {
  echo "-------------------------------------------------------"
}

function promptyn() {
  while true; do
    read -p "$1 " yn
    case $yn in
    [Yy]*) return 0 ;;
    [Nn]*) return 1 ;;
    *) return 0 ;;
    esac
  done
}


function run_install_env() {

  if ! command -v python3 &>/dev/null; then
    echo "python3 could not be found, please install it from https://www.python.org/downloads" && exit 1
  fi

  echo "" && echo "Using python version:";
  python3 -c "import sys; print(sys.version)";

  # note:
  # on windows folder to activate might be different 
  # more info https://virtualenv.pypa.io/en/latest/user_guide.html#activators
  echo "Setting up virtualenv";
  if ([[ -d "$ENV_DIR" ]] && [[ -f "$ENV_DIR/bin/activate" ]]); then
    echo "'$ENV_DIR' found and now activating...";
    source $ENV_DIR/bin/activate 
  else
    echo "Installing virtualenv and create";
    python3 -m pip install virtualenv 
    python3 -m virtualenv $ENV_DIR 
    #python3 -m venv $ENV_DIR
    source $ENV_DIR/bin/activate 
    #python3 -m venv env 
    #source env/bin/activate
  fi

  python3 -m pip install -r requirements.txt 
  # Add virtualenvironment to jupyter
  python3 -m ipykernel install --user --name=$ENV_DIR
}

function run_jupyter_notebook(){
    run_install_env
    python3 -m jupyter notebook
}


function run_ensure_env_active() {
  if ([[ -d "$ENV_DIR" ]] && [[ -f "$ENV_DIR/bin/activate" ]]); then
    source $ENV_DIR/bin/activate
  else
    echo "[ERROR]: '$ENV_DIR/' NOT found.";
    echo "Please first run [ ./cli.sh --install ] !!" &&  exit 1
  fi
}


function run_cli_mode() {
  #run_ensure_env_active
  echo "" && echo ""
  echo "Welcome to the data science test automation tooling."
  while true; do
    echo ""
    echo "What do you want to do? ..."
    echo " install -> install CLI virtual env to run tests."
    echo " run_jupyter -> run jupyter notebook"
    echo " CRL+C -> to quit"
    read -p ">>> " action
    case $action in
    install)
      run_install_env
      ;;
    run_jupyter)
      run_jupyter_notebook
      ;;
    esac
  done
}

case $1 in
*)
  run_cli_mode
  ;;
esac