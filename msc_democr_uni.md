# Short assignment for the MSc course "Applied Bioinformatics & Data Analysis" 

## Table of Contents

1. [Aim of this assignment!](#aim-of-this-assignment)
2. [Running PEMA](#running-pema)
3. [Part A: Run as a black box](#part-A-run-as-a-black-box)
4. [Part B: Run your own analysis!](#Part-B-run-your-own-analysis)
   1. [Step-by-step: on terminal](#step-by-step-on-terminal)
   2. [Step-by-step: for those who prefer graphical interface](#step-by-step-for-those-who-prefer-graphical-interface)

----------

## Aim of this assignment 

Each group will:
- run a metabarcoding analysis using PEMA
- based on its outcome, will highlight the effect of paramaters tuning in such an analysis

-------------

## Running PEMA

- Login to your account on the MSc server 
- Get `pema v2.0.4` by running: 
```bash
docker pull hariszaf/pema:v.2.1.4
```
By running `docker images` you will see that `pema` is now on your machine. 
- Get the `pema-tutorials` repo
```bash
git clone https://github.com/hariszaf/pema-mdawo.git
```
and checkout to the branch for this class 
```bash
git checkout ms-democr-class
```


This repo includes: 

1. The [`my_analysis`](https://github.com/hariszaf/pema-tutorials/tree/main/my_analysis) directory. This directory includes a complete example of a PEMA analysis. Both the mandatory and optional input files for PEMA as well as an example output.
2. A `.pbs` script that is **not** 
3. The `extra_material` directory, where you will find some extra samples (raw data) along with their corresponding metadata to perform a second PEMA analysis on your own. 




In the [`mydata`](https://github.com/hariszaf/pema-tutorials/tree/main/my_analysis/mydata) folder, you will find 6 `.fastq.gz` samples coming from 3 paired-end samples. 


🆘🙈🆘 While the name of the `my_analysis` directory can be anything, the name of the `mydata` folder needs to **stay always like this!**



#### The `extra_material` directory

In the [`extra_material`](https://github.com/hariszaf/pema-mdawo/tree/main/extra_material) folder, you will find some extra `.fastq.gz` files coming from samples from the same study with those on the `mydata` directory. 

You will also find a `.csv` file called `extra_metadata.csv` with the corresponding metadata of these extra samples.

✔️ This directory is just in the framework of this workshop. You will not need this when you will actually run PEMA.  




## Part A: Run as a black box


In this task, you will run an already set up PEMA analysis, using the 3
samples that you can find in the [`mydata`](https://github.com/hariszaf/pema-mdawo/tree/main/my_analysis/mydata) directory. 


To do this, make sure you have loged in the VSC cluster and your working directory is the `/pema-mdawo`

you only have to edit the `pema_job.pbs` script. 

Type `nano pema_job.pbs` and you will see 

``` bash

tmp_work_dir=$(pwd) 
path="${tmp_work_dir#*user/}" 
work_dir="/scratch/leuven/$path/pema-mdawo"

singularity run -B $work_dir/my_analysis:/mnt/analysis /ddn1/vol1/site_scratch/leuven/314/vsc31426/pema_v.2.0.4.sif
```



## Part B: Run your own analysis! 


In the first part we ran a PEMA analysis as a black box. The raw data and the parameteres were already set and the only thing we did was to submit a job in the VSC cluster. 

In this part, our goal is to set all needed to run PEMA on your own. 


Here is an overview of how a PEMA analysis directory looks like: 
<img src="https://i.ibb.co/6Pyqwpt/pema-anlysis-dir.png">




As we were not able to provide everyone with an account on *Genius*, remember that 
those who had already access before this workshop will be our *hubs* and will be seated
in separate tables. 
Everyone else, needs to join a table where a *hub* is also there. 
Each table builds up a **team** that has to submit a job on *Genius* with a certain set of parameteres. 





## Tasks  

Here is the list of these tasks:

| No Task | Task description |
|-|-|
| 1 | first 3 samples, low strictness, OTUs score = 0.99, Silva 132 |
| 2 | first 3 samples, high strictness, ASVs (d = 2), Silva 132 |
| 3 | all 6 samples, low strictness, OTUs (score = 0.97), Silva 132 |
| 4 | all 6 samples, high strictness, OTUs (score = 0.99), Silva 132 |
| 5 | all 6 samples, low strictness, ASVs (d = 5), Silva 132 |
| 6 | all 6 samples, high strictness, ASVs (d = 5), remove singletons, Silva 132 |
| 7 | all 6 samples, very high value of strictness, ASVs (d = 20), Silva 132 |


If you have to use all the 6 samples, you may find the extra ones in the [`extra_material`](https://github.com/hariszaf/pema-mdawo/tree/main/extra_material) directory.
Otherwise, the samples used in the initial run (already in the `mydata` folder) are just fine.




### Step-by-step: on terminal 

0. To see what is you own path, type: 
   ```bash
   ✔ [Απρ/17 23:05] vsc34189@tier2-p-login-2 ~ $ pwd
   /user/leuven/341/vsc34189
   ```

   The output of this command will be unique for each of us, 
   so when we use a path we need to make sure we use the one of our own. 

   Now, we need to move to the `/scratch` storage of our account on the VSC cluster to start Part B. 

   To do so
   ```bash
   cd /scratch/$USER_PATH
   ```

   :sos: **REMEMBER!:** The `USER_PATH` variable corresponds to the `/leuven/341/vsc34189` part of the output of the `pwd` command. 
   Thus, it will have to change for each of you, according to what `pwd` returned.
   That said, in my case I have to run
   ```bash 
   cd /scratch/leuven/341/vsc34189
   ```

   🆘 **If you still have not clone the repo, here and now is the time!!**

<br />

1. Go to the `extra_material` directory . <br/>


2. Copy the `fastq.gz` files from there to the `mydata` directory. 

3. Edit the `metadata.csv` script

   * View the `extra_metadata.csv` file by typing

   * Copy the lines corresponding to the 3 new samples we added in our `mydata` directory, but **not** the header! To do this, type

4. Edit the `parameters.tsv` file 

   >   You may think of the `parameters.tsv` file as a *paired-end* file where all lines that start with a `#` is a comment and tells you what the next parameter is about and the lines that do not start with a `#` are pairs of the type: *parameter <tab> value*. 
   >   The `parameters.tsv` file is a tab separated file, meaning that you always have to remember to leave **a single tab** between the parameter and its value. Careful! Not 3 or 4 spaces, but a **tab**

   * Open the `parameters.tsv` file 

   * Find the `outputFolderName` parameter and replace its value with any name you would like your analysis to have*, e.g `my_pema_run_at_mdawo`. <br/>

   * Save your changes and exit by typing `ctrl+x` and then `y` and `enter`.

   ***Tip:** Avoid special characters in the names you give to your files and folders like `@` or even `.`. It is better to use `_` or `-`. 

   🆘:sos: **Important !**  This is a **tab separated file**! That means you **always** have to leave a **tab between a parameter and its value**! Otherwise, PEMA will fail!


5. Edit the `phyloseq_in_PEMA.R` script

   * Open the `phyloseq_in_PEMA.R` script

   ```bash
   nano phyloseq_in_PEMA.R
   ```

   * Sections 0 and 1 stay always the same, so we move down to Section 3

   * Find where the name of a plot is given and edit it. For example 
   ```bash
   #here you can change the taxonomic rank and the grouping of samples
   barchart100 <- plot_bar(physeq.top100, fill="Phylum") + facet_wrap(~Habitat, scales="free_x")
   pdf("barchart100.pdf")
   print(barchart100)
   dev.off()
   ```
   Change the name `barchart100.pdf` as you like




7. Run your own analysis 


   * Move to the root of this repo, i.e 
   `cd /scratch/USER_PATH`

   * Submit your new job by typing 
      ```
      qsub my_job.pbs
      ```







While you are waiting for your job to complete, you may have a thorough look on the [`parameters.tsv`](https://github.com/hariszaf/pema-mdawo/blob/main/my_analysis/parameters.tsv) file and all the parameters there. 
As already mentioned this is the key-bone of PEMA as it allows the user to 
specify exactly what it takes to tune the best way an analysis. 

We strongly suggest to visit the documentation sites of the tools invoked, 
for a thourough description of the parameters. 



That's it! Now you may check on your results - and maybe, based on those, run a new analysis to tune better your parameters! 






-------------------

Many thanks to [Dr. Christina Pavloudi](https://cpavloud.github.io/mysite/) for providing us with both data and their corresponding metadata.
These data are from a study aiming to investigate the sediment bacterial diversity of a transect river-lagoon-open sea.
You may find this project in ENA under this [link](https://www.ebi.ac.uk/ena/browser/view/PRJEB20211).

-------------------
