# BEGIN: 7d5e2f1fjw4c
#!/bin/bash

# Get the name of the operating system
OS=$(uname -s)

check_sys() {
  # Check if the OS is Windows
  if [[ "$OS" == "MINGW"* ]]; then
    echo "Windows"
    # Check if dotnet-sdk is installed
    if command -v dotnet &>/dev/null; then
      echo "dotnet-sdk is installed"
    else
      echo "dotnet-sdk is not installed. Would you like to install it? (y/n)"
      read answer
      if [[ "$answer" == "y" ]]; then
        # Install dotnet-sdk for Windows
        if command -v winget &>/dev/null; then
          echo "Using Winget to install dotnet-sdk"
          winget install dotnet-sdk
        else
          echo "Winget is not installed. Please install winget to continue."
        fi
      fi
    fi
    # Check if the OS is Mac OSX
  elif [[ "$OS" == "Darwin"* ]]; then
    echo "Mac OSX"
    # Check if dotnet-sdk is installed
    if command -v dotnet &>/dev/null; then
      echo "dotnet-sdk is installed"
    else
      echo "dotnet-sdk is not installed. Would you like to install it using brew package manager? (y/n)"
      read answer
      if [[ "$answer" == "y" ]]; then
        # Install dotnet-sdk using brew package manager
        if command -v brew &>/dev/null; then
          echo "Using brew to install dotnet-sdk"
          brew install dotnet-sdk
        else
          echo "Brew is not installed. Please install brew to continue."
        fi
      fi
    fi
    # Check if the OS is Linux
  elif [[ "$OS" == "Linux"* ]]; then
    echo "It seems that you are running Linux"
    # Check if the package manager is pacman (Arch Linux)
    if command -v pacman &>/dev/null; then
      echo "Arch Linux"
      # Check if dotnet-sdk is installed
      if pacman -Qs dotnet-sdk &>/dev/null; then
        echo "dotnet-sdk is installed"
      else
        echo "dotnet-sdk is not installed. Would you like to install it? (y/n)"
        read answer
        if [[ "$answer" == "y" ]]; then
          sudo pacman -Sy dotnet-sdk
        fi
      fi
      # Check if aspnet-runtime is installed
      if pacman -Qs aspnet-runtime &>/dev/null; then
        echo "aspnet-runtime is installed"
      else
        echo "aspnet-runtime is not installed. Would you like to install it? (y/n)"
        read answer
        if [[ "$answer" == "y" ]]; then
          sudo pacman -Sy aspnet-runtime
        fi
      fi
    # Check if the package manager is emerge (Gentoo Linux)
    elif command -v emerge &>/dev/null; then
      echo "Gentoo Linux"
      # Check if dotnet-sdk is installed
      if emerge -s dotnet-sdk &>/dev/null; then
        echo "dotnet-sdk is installed"
      else
        echo "dotnet-sdk is not installed. Would you like to install it? (y/n)"
        echo "Have in mind that dotnet-sdk is not in the official Gentoo repository, and masked by default"
        read answer
        if [[ "$answer" == "y" ]]; then
          sudo emerge pkg-config dotnet-sdk
        fi
      fi
    # Check if the package manager is apt-get (Debian Linux)
    elif command -v apt-get &>/dev/null; then
      echo "Debian Linux"
      # Check if dotnet-sdk is installed
      if dpkg -s dotnet-sdk &>/dev/null; then
        echo "dotnet-sdk is installed"
      else
        echo "dotnet-sdk is not installed. Would you like to install it? (y/n)"
        read answer
        if [[ "$answer" == "y" ]]; then
          sudo apt-get update
          sudo apt-get install dotnet-sdk
        fi
      fi
    # Check if the package manager is yum (Red Hat Linux)
    elif command -v yum &>/dev/null; then
      echo "Red Hat Linux"
      # Check if dotnet-sdk is installed
      if yum list installed dotnet-sdk &>/dev/null; then
        echo "dotnet-sdk is installed"
      else
        echo "dotnet-sdk is not installed. Would you like to install it? (y/n)"
        read answer
        if [[ "$answer" == "y" ]]; then
          sudo yum install dotnet-sdk
        fi
      fi
    # Check if the package manager is nix-env (NixOS)
    elif command -v nix-env &>/dev/null; then
      echo "NixOS"
      # Check if dotnet-sdk is installed
      if nix-env -q dotnet-sdk &>/dev/null; then
        echo "dotnet-sdk is installed"
      else
        echo "dotnet-sdk is not installed. Would you like to install it? (y/n)"
        read answer
        if [[ "$answer" == "y" ]]; then
          sudo nix-env -i dotnet-sdk
        fi
      fi
    else
      echo "Unsupported Linux distribution"
      exit 1
    fi
  else
    echo "Unsupported operating system"
    exit 1
  fi
}

echo "Welcome to the mini_kompiler installer"
echo "Checking your system..."
check_sys

echo "Cloning the repo..."
if command -v git &>/dev/null; then
  git clone https://github.com/ARKye03/mini_kompiler.git
  cd mini_kompiler/
  dotnet run
  echo "Cloned the repo"
else
  echo "Git is not installed. Please install git and try again."
fi
