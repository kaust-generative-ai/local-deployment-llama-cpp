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

### Install XCode and Command Line Tools (Mac OS)

Install [XCode](https://developer.apple.com/xcode/). Then run the following command to install XCode Command Line Tools.

```bash
xcode-select --install
```

### Create the Conda environment

After adding any necessary dependencies that should be installed via `conda/mamba` to the `environment.yml` file and any 
dependencies that should be installed via `pip` to the `requirements.txt` file you create the Conda environment in a 
sub-directory `./env`of your project directory by running the following shell script.

```bash
./bin/create-conda-env.sh
```

#### Support for Metal GPU acceleration (Mac M1+ only)

In order to support Metal GPU acceleration you need to install a few extra dependecies. These dependencies are added to the 
`environment-metal-gpu.yml` and `requirements-metal-gpu.txt` files. Create the Conda environment in a sub-directory `./env`of 
your project directory by running the following shell script.

```bash
./bin/create-conda-env.sh environment-metal-gpu.yml
```

### Building LLaMA C++ with BLAS acceleration (Mac OS, Linux, Windows)

After creating the Conda environment you can build LLaMA C++ by running the following command.

```bash
conda run --prefix ./env --live-stream ./bin/build-llama-cpp.sh
```

This command does the following.

1. Properly configures the Conda environment.
2. Clones [LLaMA C++](https://github.com/ggerganov/llama.cpp into `./src/llama-cpp`.
4. Builds LLaMA C++ with support for CPU acceleration using OpenBlas in `./build/llama-cpp`.
5. Installs the binaries into the `bin/` directory of the Conda environment.
6. Removes the `./src/llama-cpp` directory as it is no longer needed.
7. Removes the `./build/llama-cpp` directory as it is no longer needed.

#### Support for Metal GPU acceleration (Mac M1+ only)

After creating the Conda environment you can build LLaMA C++ with support for GPU acceleration 
using Metal GPU by running the following command.

```bash
conda run --prefix ./env --live-stream ./bin/build-llama-cpp-metal-gpu.sh
```

#### Support for NVIDIA GPU acceleration (Linux and Windows)

After creating the Conda environment you can build LLaMA C++ by with support for GPU acceleration 
by running the following command.

```bash
conda run --prefix ./env --live-stream ./bin/build-llama-cpp-nvidia-gpu.sh
```

### Activating the Conda environment

Once the new environment has been created you can activate the environment with the following command.

```bash
conda activate ./env
```

Note that the `./env` directory is *not* under version control as it can always be re-created as 
necessary.

## Funding Acknowledgment

This project is supported by funding from King Abdullah University of Science and Technology (KAUST) - Center of Excellence for Generative AI, under award number 5940.
