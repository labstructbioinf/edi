### **Introduction**

Jobs (both batch and interactive sessions) on EDI should be run through **slurm** resource manager.
For the quick overview of **slurm** you can refer to the video: [link](https://www.youtube.com/watch?v=U42qlYkzP9k&feature=player_embedded)

!!! Information
    Slurm details:

    - Two partitions are available - <code>cpu</code> and <code>gpu</code>.
    - GPU partition has higher priority.
    - No limits are currently enforced on the time of execution.
    - Constraints (<code>rtx2080</code>, <code>gtx1080</code>) can be used to select certain GPU architectures.
    
!!! Example
    To get the information on the currently running jobs run <code>squeue</code>:
    ```sh
    ~$ squeue 
    JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
    87719       gpu interact username  R 11-18:07:21      1 edi08
    ```
    To get the information on the slurm partitions and their details run <code>sinfo</code>:
    ```sh
    ~$ sinfo 
    PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
    cpu          up   infinite      1 drain* edi03
    cpu          up   infinite      1    mix edi08
    cpu          up   infinite      7   idle edi[00-02,04-07]
    gpu          up   infinite      1 drain* edi03
    gpu          up   infinite      1    mix edi08
    gpu          up   infinite      6   idle edi[01-02,04-07]
    ```
### **Interactive sessions**

EDI is commonly used for interactive work with data, e.g. performing ad-hoc analyses and visualizations
with python and jupyter-notebooks. 
To facilitate allocating resources for interactive sessions a convenient wrapper (<code>alloc</code>) has been prepared.
You can tweak your allocation depending on work needs, see the following table for details and examples.

<code>alloc</code> options are as follows:

| Argument | Description  |
|---|---|
| **-n** | Number of cores used allocated for the job (_default = 1, max = 36_) |
| **-g** | Number of GPUs allocated for the job (_default = 0, max = 2_) |
| **-m** | Amount of memory (in GBs) **per allocated core** allocated for the job (_default = 1, max = 60_) |
| **-w** | Host to start your session (_default = host you are running alloc on_) |

!!! Example
    To obtain an allocation on **edi02** with **1 gpu** and **6 cores** and a total of **12 GB of memory**:
    ```sh
    alloc -n 6 -w edi02 -g 1 -m 2
    ``` 
    **Important!** Please remember to quit your interactive allocation when you're done with your work.


### **Batch jobs**
Longer, resource demanding jobs typically should be scheduled in SLURM batch mode. Below you can find the example of the
SLURM batch script that you can use to schedule a job:

!!! Example
    Suppose the following <code>job.sh</code> batch file:
    ```sh
    #!/bin/bash
    #SBATCH -p gpu          # GPU partition
    #SBATCH -n 8            # 8 cores
    #SBATCH --gres=gpu:1    # 1 GPU 
    #SBATCH --mem=30GB      # 30 GB of RAM
    #SBATCH -J job_name     # name of your job

    your_program -i input_file -o output_path
    ```
    You can submit the specified job via <code>sbatch</code> command:
    ```sh
    ~$ sbatch job.sh
    Submitted batch job 1234
    ```
### **Array jobs**

This mechamism allows to run multiple similar jobs in batch-like fashion. 

!!! Example
    Suppose the following <code>job.slurm</code> file:
    ```sh
    #!/bin/bash
    
    #SBATCH -p cpu # cpu partition
    #SBATCH -J name of the array jon
    # exclude nodes without gpu
    #SBATCH --exclude=edi[00,01,07,08] # nodes exluded from calculations
    
    #SBATCH --array=1-20%4 # declare a set of 20 jobs, where each 4 jobs running concurently
    #SBATCH --cpus-per-task=4 # number of cores per each task
    #SBATCH --mem=8GB # memory per each task
    #SBATCH --output=%A_%a.out # output of each single job in form of JOBID_TASKID
    #SBATCH --error=%A_%a.err # similar as above
    
    #SBATCH --chdir=... directory where your job will be submit which is optional
    ```
    
    slurm provide useful enviroment variables to manage each task parametrization
    
    `SLURM_ARRAY_TASK_ID` - number of current task in our example varing from 1 to 20
    `SLURM_ARRAY_JOB_ID` - id of the array job
    
    Array job can be submit in the same way as batch jobs.
    
    More informations: https://slurm.schedmd.com/job_array.html
