# PEMA hands-on @ MDAWO


## Preparatory steps

> 🆘 This part will be presented during the workshop however, we strongly suggest to have 
implement this at an earlier stage. 🆘


### Login the VSC cluster 

You must already have access in the VSC cluster. 
To login, you first need to open a terminal. 

Depending on your Operating System, to do so: 

* **Linux:** type the shortcut: `ctrl+alt+t` 
* **Mac**: type “terminal” on spotlight
* **Windows:** Start menu -> Type “CMD”

and then type 

```
ssh ....and geert will thell us what! :)
```

Once loged in, you automatically move to your `home` directory.
By typing `pwd` you may see what that is in your case.

```{bash}
✔ [Apr/17 14:03] vsc34189@tier2-p-login-2 ~ $ pwd 
/user/leuven/341/vsc34189
```

However, we will be working on `scratch` directory. 

To move there you just need to get the output of the previous command
and replace the `/user` part with `/scratch`.

Now, if you type `pwd` again you will that you have been transfered in 

```{bash}
✔ [Apr/17 14:03] vsc34189@tier2-p-login-2 ~ $ cd  /scratch/leuven/341/vsc34189
✔ [Apr/17 14:03] vsc34189@tier2-p-login-2 ~ $ pwd
/scratch/leuven/341/vsc34189
```

:sos:🆘
We will refer to the `/leuven/341/vsc34189` part  <span style="color:green">**`USER_PATH`**</span>. <br/>
>**Attention!** This is **unique** for every user!  <br/>
So, every time you see the <span style="color:green">**`USER_PATH`**</span> flag, you will have to **replace** it with **your own** path, as I did with mine. 

For example, from now on, 
```{bash}
cd /scratch/USER_PATH/
```
means (**to me alone!!**)
```{bash}
cd /scratch/leuven/341/vsc34189
```

while for the fictional user `vsc34247` would mean 

```{bash}
cd /scratch/leuven/342/vsc34247
```


🎗️ **Hints:**  
`pwd` stands for `print working directory`. Accordingly, `cd`  for `change directory`.

### Clone this `pema-mdawo` GitHub repo on your VSC account

Once you are sure that your working directory is on the `scratch` section, you just need to type:

```
git clone https://github.com/hariszaf/pema-mdawo.git
```

This repo includes: 

1. The `my_analysis` directory. This directory includes a complete example of a PEMA analysis. Both the mandatory and optional input files for PEMA as well as an example output.
2. The `.pbs` script that we will use to submit a *job* in the VSC cluster 
3. The `extra_material` directory, where you will find some extra samples (raw data) along with their corresponding metadata to perform a second PEMA analysis on your own. 


## Two major directories

### The `my_analysis` directory

In the [`my_analysis`](https://github.com/hariszaf/pema-mdawo/tree/main/my_analysis) directory you will find the exact input we used to run the first PEMA analysis on the VSC cluster. 

In the [`mydata`](https://github.com/hariszaf/pema-mdawo/tree/main/my_analysis/mydata) folder, you will find 6 `.fastq.gz` samples coming from 3 paired-end samples. 


🆘🙈🆘 While the name of the `my_analysis` directory can be anything, the name of the `mydata` folder needs to **stay always like this!**



### The `extra_material` directory

In the [`extra_material`](https://github.com/hariszaf/pema-mdawo/tree/main/extra_material) folder, you will find some extra `.fastq.gz` files coming from samples from the same study with those we have already run in the first part of the hands-on. 

You will also find a `.csv` file called `extra_metadata.csv` with the corresponding metadata of these extra samples.

✔️ This directory is just in the framework of this workshop. You will not need this when you will actually run PEMA.  


-------------------

Many thanks to Dr. Christina Pavloudi for providing us with both data and their corresponding metadata.
You may find this project in ENA under this [link](https://www.ebi.ac.uk/ena/browser/view/PRJEB20211).

-------------------



## Part A: Run as a black box

This will be the first task of the workshop and you will implement it on the 
first part of it (09:00 AM - 10:45 AM). 

In this task, you will run an already set up PEMA analysis, using the 3
samples that you can find in the [`mydata`](https://github.com/hariszaf/pema-mdawo/tree/main/my_analysis/mydata) directory. 


To do this, you only have to edit the `pema_job.pbs` script. 

Type `nano pema_job.pbs` and you will see 

```{bash}
#!/bin/bash -l

# ~~~~~~~  A. PBS-related part  ~~~~~~~

#PBS -A lp_h_mdaw
#PBS -l nodes=1:ppn=6
#PBS -l walltime=01:00:00
#PBS -l pmem=5gb
#PBS -m bae
# >>>>>    Replace my email with yours    <<<<<<<
#PBS -M haris-zaf@hcmr.gr
  
# ~~~~~~~  B. PEMA execution command  ~~~~~~~
# >>>>>    Replace my path to my_analysis with yours    <<<<<<<
singularity run -B /scratch/leuven/341/vsc34189/pema-mdawo/my_analysis:/mnt/analysis /ddn1/vol1/site_scratch/leuven/314/vsc31426/pema_v.2.0.3.sif
```

Then you need to **replace** my email with yours on the `#PBS -M` 
and my path to the `my_analysis` directory with yours.

To do this, you may type `pwd` and then replace the `/scratch/leuven/341/vsc34189` part 
of the PEMA execution command, with its output.


To save the changes you made, you may type `ctrl+x` and once you see the following message:
`Save modified buffer (ANSWERING "No" WILL DESTROY CHANGES) ?` you may type `y`.

Now you can submit your first job by:
```
qsub pema_job.sh
```

To check whether it is running, type `qstat`. 
<img src="https://miro.medium.com/max/900/0*Pm4WhqyKBbQecedZ.png" width= 200px;  align="right">
You may also check your email. ;)



## Part B: Run your own analysis! 

In the first 

Our goal is to set all needed to run PEMA and then run an analysis. 

In the first 

As raw data, we will use both the samples used in the initial run (already in the `mydata` folder) but also those stored in the `extra_material` directory.  
The same applies for their corresponding metadata too. 

Therefore, once our analysis is complete, we will have an OTUs/ASVs table of 6 samples. <br/>
Let' start.


### Step-by-step

1. Download the `pema-mdawo` repository. <br/>
You can either `git pull https://github.com/hariszaf/pema-mdawo.git`  <br/>
or download it as a `.zip` file.
In case you do the latter, unzip the file to get access to its contents. 
The size of the `.zip` is 549.1 MB.

2. Add the extra samples located at the `extra_material` directory. 

   * Open the repository and enter the `extra_material` directory
   * Cut all the `.fastq.gz` files from there
   * Move back and enter the my_analysis directory and then to the mydata
   * And paste the `.fastq.gz` files here



3. Edit the `parameters.tsv` file 

   * Move back to the `my_analysis` directory 
   * Open the `parameters.tsv` file 
   * Find the `outputFolderName` parameter and replace the `test_16S_mdawo_phyloseq` value with any name you would like your analysis to have*, e.g `my_pema_run_at_mdawo`. <br/>
   * Save your changes and close the file

   ***Tip:** Avoid special characters in the names you give to your files and folders like `@` or even `.`. It is better to use `_` or `-`. 


4. Edit the `phyloseq_in_PEMA.R` script

   * From the `my_analysis` directory, open the `phyloseq_in_PEMA.R` script
   * Let us see and talk about Sections 0 and 1; as we mentioned these sections stay always the same
   * Move down to Section 2; this is where the `div_indices.csv` file we saw earlier is built. 
   You can remove it, change its name, ask for less or more etc 
   * Finally, move down to Section 3 where the various plots are built. <br />
   Change the names as you would like to


5. Edit the `metadata.csv` script

   * Move again to the `extra_material` directory
   * Open the `extra_metadata.csv` file and copy the lines corresponding to the 3 new samples we added in our `mydata` directory 
   * Move back to the `my_analysis` directory and open the `metadata.csv` file
   * Paste these 3 lines and save your changes

---------------
   💯 Now we have seen exactly what the `analysis_directory` should include. <br/>
   This is how this directory is supposed to be. <br/> 
   
   
   🆘 
   However, to save time, **please remove all the `.fastq.gz` from the `mydata` folder**, i.e *delete everything in this directory*. <br/>
   
   **We will upload everything else to the VSC cluster and we will copy our raw data from 
   my account on VSC to yours.**
   🆘 

---------------

6. Upload your `analysis_directory` to the VSC cluste

   * Once, you have removed all your `.fastq.gz` files from the `mydata` folder, 
   open a terminal and go to the `pema-mdawo` directory. Assuming that the `pema-mdawo` repository is on your Desktop, you need to run

      ```
      cd /home/username/Desktop
      ```

   * From there, run the following command replacing the paths accordingly

      ```
      scp -r my_analysis/ vsc34189@login.hpc.kuleuven.be://scratch/leuven/341/vsc34189/
      ```



7. Add the raw data on VSC 
   Go to your VSC terminal and move to your just uploaded `my_analysis` directory by running 

   ```
   cd /scratch/leuven/341/vsc34189/
   ```

8. Edit the `.pbs` script. 

   * Move to your home directory, i.e type `cd `
   * Make a copy of the original `.pbs` by running `cp pema_job.pbs my_job.pbs`
   * Edit your new file with the `nano` program, i.e type `nano pema_job.pbs`
   * Replace the `/mdawo/` directory with your `my_analysis` one
   * Save your changes and exit, i.e type `ctrl+x` and then `y`


8. Run your own analysis 

   * Submit your new job by typing 
      ```
      qsub my_job.pbs
      ```


Now you just need to wait for PEMA to run your analysis. 

In the meanwhile you may have a thorough look on the [`parameters.tsv`](https://github.com/hariszaf/pema-mdawo/blob/main/my_analysis/parameters.tsv) file
and all the parameters there. 
As already mentioned this is the key-bone of PEMA as it allows the user to 
specify exactly what it takes to tune the best way an analysis. 

We strongly suggest to visit the documentation sites of the tools invoked, 
for a thourough description of the parameters. 


