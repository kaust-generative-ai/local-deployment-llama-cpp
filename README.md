# local-deplyoment-llama-cpp

Project to help you get started deploying Generative AI models locally using 
[LLaMA C++](https://github.com/ggerganov/llama.cpp). LLaMA C++ enables LLM inference with minimal setup and 
state-of-the-art performance on a wide variety of hardware - locally and in the cloud.

## Installation

### Miniforge, Conda, Mamba (Mac OS, Linux, Windows)

If you haven't already done so, install [Miniforge](https://github.com/conda-forge/miniforge). Miniforge provides 
minimal installers for [Conda](https://conda.io/) and [Mamba](https://github.com/mamba-org/mamba) specific to 
[conda-forge](https://conda-forge.org/), with the following features pre-configured:

   * Packages in the base environment are obtained from the `conda-forge` channel.
   * The `conda-forge` channel is set as the default (and only) channel.

Conda/mamba will be the primary package managers used to install the required Python dependencies. For 
convenience, a script is included that will download and install Miniforge, Conda, and Mamba. You can run the 
script using the following command.

```bash
./bin/install-miniforge.sh
```

### LLaMA C++ with BLAS acceleration (Mac OS, Linux, Windows)

TLDR: run the following command.

```bash
./bin/create-conda-env.sh && ./bin/build-llama-cpp.sh
```

Details are covered below.

#### 1. Create the Conda environment

After adding any necessary dependencies that should be installed via `conda/mamba` to the `environment.yml` file and any 
dependencies that should be installed via `pip` to the `requirements.txt` file you create the Conda environment in a 
sub-directory `./env`of your project directory by running the following shell script.

```bash
./bin/create-conda-env.sh
```

Once the new environment has been created you can activate the environment with the following command.

```bash
conda activate ./env
```

Note that the `./env` directory is *not* under version control as it can always be re-created as 
necessary.

#### 2. Build and install LLaMA C++ 

After creating the Conda environment you can build and install LLaMA C++ with BLAS acceleration by running the following shell 
script.

```bash
./bin/build-llama-cpp.sh
```

This script does the following.

1. Clones [LLaMA C++](https://github.com/ggerganov/llama.cpp into `./src/llama-cpp`.
2. Activates the Conda environment.
3. Builds LLaMA C++ with support for CPU acceleration using OpenBlas in `./build/llama-cpp`.
4. Symlinks the binaries into the `bin/` directory of the Conda environment.
5. Removes the `./src/llama-cpp` as it is no longer needed.
6. Deactivates the Conda environment.

### LLaMA C++ with Metal GPU acceleration (Mac OS)

TLDR: run the following command.

```bash
./bin/create-conda-env.sh environment-metal-gpu.yml && ./bin/build-llama-cpp-metal-gpu.sh
```

Details are covered below.

#### 0. Install XCode and Command Line Tools

Install [XCode](https://developer.apple.com/xcode/). Then run the following command to install XCode Command Line Tools.

```bash
xcode-select --install
```

#### 1. Create the Conda environment

After adding any necessary dependencies that should be installed via `conda/mamba` to the `environment-metal-gpu.yml` file and any 
dependencies that should be installed via `pip` to the `requirements-metal-gpu.txt` file you create the Conda environment in a 
sub-directory `./env`of your project directory by running the following shell script.

```bash
./bin/create-conda-env.sh environment-metal-gpu.yml
```

Once the new environment has been created you can activate the environment with the following command.

```bash
conda activate ./env
```

Note that the `./env` directory is *not* under version control as it can always be re-created as 
necessary.

#### 2. Build and install LLaMA C++ 

After creating the Conda environment you can build and install LLaMA C++ with Metal GPU acceleration by running the 
following shell script.

```bash
./bin/build-llama-cpp-metal-gpu.sh
```

This script does the following.

1. Clones [LLaMA C++](https://github.com/ggerganov/llama.cpp into `./src/llama-cpp`.
2. Activates the Conda environment.
3. Builds LLaMA C++ with support for Metal GPU acceleration in `./build/llama-cpp`.
4. Installs the binaries into the `bin/` directory of the Conda environment.
5. Removes the `./src/llama-cpp` as it is no longer needed.
6. Deactivates the Conda environment.


