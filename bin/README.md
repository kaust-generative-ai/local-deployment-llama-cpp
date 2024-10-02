
# Ibex (KAUST)

## Launching a job via Slurm to create the Conda environment

You should avoid create Conda environments and compiling software on Ibex login nodes. If you lose your connection to the 
Ibex login node whilst your Conda environment script is running the environment will be left in an inconsistent state and 
you will need to start over. Login nodes and compute nodes often have different CPU and GPU settings than compute nodes. 
Creating Conda environments on login nodes that have different CPU and GPU configurations than the compute nodes used for 
your jobs can lead to job failures (or worse inefficient use of compute). Finally, launching a job via Slurm to create 
your Conda environment is ofter much faster as the login nodes are often very busy with many concurrent users.

For your convenience the commands to launch a job via Slurm to create the Conda environment have been combined into a job 
script. The script should be run from the project root directory as follows. 

```bash
sbatch ./bin/create-conda-environment.sbatch
```

### Creating the Conda environment with NVIDIA GPU acceleration

If you intend to use GPU acceleration for your LLaMA C++ inference, then you should create your Conda environment by 
launching a job on compute nodes with the same type of GPU that you intend to use for inference. The job script below 
assumes that you wish to use an A100 GPU node.
 
```bash
sbatch ./bin/create-conda-environment-nvidia-gpu.sbatch
```

## Launching a Jupyter server for interactive work

The job script `launch-jupyter-server.sbatch` launches a Jupyter server for interactive prototyping. To launch a JupyterLab server 
use `sbatch` to submit the job script by running the following command from the project root directory.

```bash
sbatch ./bin/launch-jupyter-server.sbatch
```

If you prefer the classic Jupyter Notebook interface, then you can launch the Jupyter notebook server with the following command in 
the project root directory.

```bash
sbatch ./bin/launch-jupyter-server.sbatch notebook
```

Once the job has started, you can inspect the `./bin/launch-jupyter-server-$SLURM_JOB_ID-slurm.err` file where you will find 
instructions on how to access the server running in your local browser.

### SSH tunneling between your local machine and Ibex compute node(s)
To connect to the compute node on Ibex running your Jupyter server, you need to create an SSH tunnel from your local machine 
to a login node on Ibex using a command similar to the following.

```
ssh -L ${JUPYTER_PORT}:${IBEX_NODE}:${JUPYTER_PORT} ${USER}@glogin.ibex.kaust.edu.sa
```

The exact command for your job can be copied from the `./bin/launch-jupyter-server-$SLURM_JOB_ID-slurm.err` file.

### Accessing the Jupyter server from your local machine

Once you have set up your SSH tunnel, in order to access the Jupyter server from your local machine you need to copy the 
second URL provided in the Jupyter server logs in the `launch-jupyter-server-$SLURM_JOB_ID-slurm.err` file and paste it into 
the browser on your local machine. The URL will look similar to the following.

```
http://127.0.0.1:$JUPYTER_PORT/lab?token=$JUPYTER_TOKEN
```

The exact command for your job containing both your assigned `$JUPYTER_PORT` as well as your specific `$JUPYTER_TOKEN` can 
be copied from the `launch-jupyter-server-$SLURM_JOB_ID-slurm.err`.

