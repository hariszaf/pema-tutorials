# PEMA hands-on @ MDAWO

# Table of Contents
1. [An introduction for this PEMA hands-on](#an-introduction-for-this-pema-hands-on)
   1. [Hands-on structure](#hands-on-structure)
1. [Preparatory steps](#preparatory-steps)
   1. [Login the VSC cluster](#login-the-vsc-cluster)
   2. [Get the `pema-tutorials` repo](#get-the-pema-tutorials-repo)
   3. [Two major directories](#two-major-directories)
      1. [The `my_analysis` directory](#the-my_analysis-directory)
      2. [The `extra_material` directory](#the-extra_material-directory)
2. [Part A: Run as a black box](#part-A-run-as-a-black-box)
3. [Part B: Run your own analysis!](#Part-B-run-your-own-analysis)
   1. [Step-by-step: on terminal](#step-by-step-on-terminal)
   2. [Step-by-step: for those who prefer graphical interface](#step-by-step-for-those-who-prefer-graphical-interface)




## An introduction for this PEMA hands-on

Even if we tried hard, we finally did not make it to provide everyone access to the VSC cluster.
PEMA enables running on personal computers for a few samples. 
However, it is a High Performance Computing (HPC)-oriented workflow and one of the main goals of this hands-on is for you to become familiar with such computing environments. 
To this end, we found alternatives so you can have a first experience on such tasks. 

As we have 7 participants that already had access on the *Genius* cluster of VSC, 
we will work on a hybrid way; let's call those 7 colleagues *hubs*.
Apparently, everyone else will have to be close to a *hub*.  🖇️

🆘 ***Hubs*** please make sure you sit in different tables, and the rest of us we will come join you! 👍

* Then, everyone but the *hubs*, we will login on the [Super Dimension Fortress (SDF)](http://sdf.org/).  <br/>
SDF is a networked community of free software authors, teachers, librarians, students, researchers, hobbyists, computer enthusiasts, the aural and visually impaired and provided us with 150 accounts. 

* *Hubs* you will login on *Genius*. 

We will all see how to do both in just a while!<br/>
🥳 At this point, I think we own a great thanks to the SDF community for their support!


### Hands-on structure 

This tutorial has 3 main parts.

In the first place, we will see the basics of Command Line Interface and how to login on a server and walk around. 


In **Part A** we will go through:
* the input files of PEMA
* the single command for using PEMA
* the `.pbs` script you need to submit a job on *Genius*
* the output that PEMA returns

During this part, you will download (or make a *clone*) of this repository and we will see 
how you can transfer files from your computer to a server. 
You will also implement some basics command line commands, to become familiar working on such environments. 
Finally, each table, will submit **the exact same** PEMA job on *Genius* that returns the [`output_example`](https://github.com/hariszaf/pema-tutorials/tree/main/my_analysis/output_example). 



In **Part B** our main goal is to highlight the importance of the parameter tuning in metabarcoding. 
Each table will have to run its own PEMA job.
**All participants of a table need to work as a group** and build the `parameters.tsv` input file of PEMA, according to the instructions that they will have in the table's task. 
There will be 7 tasks, one for each *hub* so in the end we will be able to compare the
outcome of 7 different parameters sets! 


In the end of each of the following sections you will find a recording of what I did to 
run an analysis on the VSC cluster. 
Please feel free to ask anytime about anything!
Command line can be scary but team work always helps! 🦸 



## Preparatory steps

🆘 **The following section will be presented during the hands-on, however it would be better if our *hubs* would go for it *before* the workshop! The most important part for our *hubs*, is to make sure they are able to login on *Genius*,**  💯

To login in a server, a cluster or any other machine, you will probably need to first open a terminal console. 

Depending on your Operating System, to do so: 

* **Linux:** type the shortcut: `ctrl+alt+t` 
* **Mac**: type “terminal” on spotlight
* **Windows:** Start menu -> Open CMD

If you are working on **Windows** you can also use [PuTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/) that you should have already installed. 
If you are about to use *Genius* at some point, you should also have a look [here](https://vlaams-supercomputing-centrum-vscdocumentation.readthedocs-hosted.com/en/latest/access/text_mode_access_using_putty.html#text-mode-access-using-putty).

--------------------

**For a more thorough description about how you can login both on *SDF* and *Genius* (in case you have an account) can be found in the [presentation slides](https://docs.google.com/presentation/d/1e7XfTPQ-Drr9kcEFUw8vEIOYdMtzVIoeIupAR1a-oO8/edit#slide=id.gd038431b4f_0_311) of this hands-on.**

--------------------


### Once you are on the VSC cluster 

Once loged in, you automatically move to your `home` directory.
By typing `pwd` you may see what that is in your case.

```bash
✔ [Apr/17 14:03] vsc34189@tier2-p-login-2 ~ $ pwd 
/user/leuven/341/vsc34189
```

However, we will be working on the `scratch` directory. 

To move there you just need to get the output of the previous command
and replace the `/user` part with `/scratch`.

```bash
✔ [Apr/17 14:03] vsc34189@tier2-p-login-2 ~ $ cd  /scratch/leuven/341/vsc34189
```

Now, if you type `pwd` again you will see that you have been transfered in your `/scratch` directory. 

```bash
✔ [Apr/17 14:03] vsc34189@tier2-p-login-2 ~ $ pwd
/scratch/leuven/341/vsc34189
```

And if you type `ls` you will see that your `/scratch` directory is empty:
```bash
✔ [Απρ/18 01:08] vsc34189@tier2-p-login-2 /scratch/leuven/341/vsc34189 $ ls
✔ [Απρ/18 01:08] vsc34189@tier2-p-login-2 /scratch/leuven/341/vsc34189 $ 
```


:sos:🆘
We will refer to the `/leuven/341/vsc34189` part  <span style="color:green">**`USER_PATH`**</span>. <br/>
>**Attention!** This is **unique** for every user!  <br/>
So, every time you see the <span style="color:green">**`USER_PATH`**</span> flag, you will have to **replace** it with **your own** path, as I did with mine. 

For example, from now on, 
```bash
cd /scratch/USER_PATH/
```
means (**to me alone!!**)
```bash
cd /scratch/leuven/341/vsc34189
```

while for the fictional user `vsc34247` would mean 

```bash
cd /scratch/leuven/342/vsc34247
```


### Get the `pema-tutorials` repo

Once you are sure that your working directory is on the `scratch` section, you just need to type:

```bash
git clone https://github.com/hariszaf/pema-tutorials.git
```

This repo includes: 

1. The `my_analysis` directory. This directory includes a complete example of a PEMA analysis. Both the mandatory and optional input files for PEMA as well as an example output.
2. The `.pbs` script that we will use to submit a *job* in the VSC cluster 
3. The `extra_material` directory, where you will find some extra samples (raw data) along with their corresponding metadata to perform a second PEMA analysis on your own. 


This will take a few seconds. Once the clone is ready, a new directory called `pema-tutorials` will be in your `/scratch`. You need to move inside this new directory as this will be our main working directory.


```bash
✔ [Apr/17 15:46] vsc34189@tier2-p-login-2 /scratch/leuven/341/vsc34189 $ ls
pema-tutorials
✔ [Apr/17 15:47] vsc34189@tier2-p-login-2 /scratch/leuven/341/vsc34189 $ cd pema-tutorials/
✔ [Apr/17 15:47] vsc34189@tier2-p-login-2 /scratch/leuven/341/vsc34189/pema-tutorials $ ls
extra_material  MDWAO_hands_on.md  my_analysis  pema_job.pbs  README.md
```

That's all! Now we are ready to go for the PEMA analysis. 


🎗️ **Hints:**  
`pwd` stands for *print working directory*. Accordingly, `cd`  for `change directory` and `ls` for *list*.


### Two major directories

#### The `my_analysis` directory

In the [`my_analysis`](https://github.com/hariszaf/pema-tutorials/tree/main/my_analysis) directory you will find the exact input we used to run the first PEMA analysis on the VSC cluster. 

In the [`mydata`](https://github.com/hariszaf/pema-tutorials/tree/main/my_analysis/mydata) folder, you will find 6 `.fastq.gz` samples coming from 3 paired-end samples. 


🆘🙈🆘 While the name of the `my_analysis` directory can be anything, the name of the `mydata` folder needs to **stay always like this!**



#### The `extra_material` directory

In the [`extra_material`](https://github.com/hariszaf/pema-tutorials/tree/main/extra_material) folder, you will find some extra `.fastq.gz` files coming from samples from the same study with those on the `mydata` directory. 

You will also find a `.csv` file called `extra_metadata.csv` with the corresponding metadata of these extra samples.

✔️ This directory is just in the framework of this workshop. You will not need this when you will actually run PEMA.  


Here is the recording for this first part 
from my terminal console:
[![asciicast](https://asciinema.org/a/407903.svg)](https://asciinema.org/a/407903)


-------------------

Many thanks to [Dr. Christina Pavloudi](https://imbbc.hcmr.gr/user/cpavloud/) for providing us with both data and their corresponding metadata.
These data are from a study aiming to investigate the sediment bacterial diversity of a transect river-lagoon-open sea.
You may find this project in ENA under this [link](https://www.ebi.ac.uk/ena/browser/view/PRJEB20211).

-------------------


## Part A: Run as a black box

This is the first task of this hands-on



and you will implement it on the 
first part of it. 

In this task, you will run an already set up PEMA analysis, using the 3
samples that you can find in the [`mydata`](https://github.com/hariszaf/pema-tutorials/tree/main/my_analysis/mydata) directory. 


To do this, make sure you have loged in the VSC cluster and your working directory is the `/pema-tutorials`

you only have to edit the `pema_job.pbs` script. 

Type `nano pema_job.pbs` and you will see 

``` bash
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

# In the following line, these 3 commands aim to make the script to run on everyone's unique path.
# You can remove them and replace the "$work_dir" variable with your absolute path
# e.g in my case, I could remove the following lines and run 
# singularity run -B /scratch/leuven/341/vsc34189/pema-tutorials/my_analysis:/mnt/analysis /ddn1/vol1/site_scratch/leuven/314/vsc31426/pema_v.2.0.3.sif
tmp_work_dir=$(pwd) ; path="${tmp_work_dir#*user/}" ; work_dir="/scratch/leuven/$path/pema-tutorials"

singularity run -B $work_dir/my_analysis:/mnt/analysis /ddn1/vol1/site_scratch/leuven/314/vsc31426/pema_v.2.0.3.sif
```

Then you need, **optionally**, to **replace** my email with yours on the `#PBS -M`.


To save the changes you made, you may type `ctrl+x` and once you see the following message:
`Save modified buffer (ANSWERING "No" WILL DESTROY CHANGES) ?` you may type `y` and then `enter`.

Now you can submit your first job by:
```
qsub pema_job.sh
```

To check whether it is running, type `qstat`. 
<img src="https://miro.medium.com/max/900/0*Pm4WhqyKBbQecedZ.png" width= 200px;  align="right">
You may also check your email. ;)

<br/>

Once your job starts, two files are automatically built by the PBS schedulurer: 
for example `pema_job.pbs.e50705634`,  `pema_job.pbs.o50705634` denoting the standard error and output 
accordingly.



Here is the recording for what you need to do for Part A: 
[![asciicast](https://asciinema.org/a/407917.svg)](https://asciinema.org/a/407917)


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

**As we have 7 hosts, we have 7 tasks too!**

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


If you have to use all the 6 samples, you may find the extra ones in the [`extra_material`](https://github.com/hariszaf/pema-tutorials/tree/main/extra_material) directory.
Otherwise, the samples used in the initial run (already in the `mydata` folder) are just fine.



**!!! Attention !!!**
Please, always remember that *hubs* have this repo on their accounts on *Genius*. 

If for any reason you still have not done this, you need to go to your `/scratch` directory and run 

``` bash
git clone https://github.com/hariszaf/pema-tutorials.git
```

That means that, you can change your `parameters.tsv` file on your computer (locally) and upload just this file as your `.fastq.gz` files are already there.  <br/>
:100:  Remember: It is team work we need here! *Hubs* are not like the experts, it just happens to have acces on *Genius* so it is everyone that needs to controbute on that! 


I have done an example of my own in case it helps. 
I have done the exact same thing both by working on the terminal and on my computer and then using FileZilla to upload my edited files.



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

   Move to the `extra_material` directory by typing 
   ```bash
   cd pema-tutorials/extra_material
   ```

   * Let us see what is there. Type: 
   ```bash
   ✔ [Απρ/17 23:44] vsc34189@tier2-p-login-2 /scratch/leuven/341/vsc34189/pema-tutorials/extra_material $ ls
   ERR1906856_1.fastq.gz  ERR1906856_2.fastq.gz  ERR1906861_1.fastq.gz  ERR1906861_2.fastq.gz  ERR1906866_1.fastq.gz  ERR1906866_2.fastq.gz  extra_metadata.csv
   ```

   As you can see, we have 6 `.fastq.gz` files, i.e 3 paired-end samples and a `metadata.csv` file with their corresponding metadata. 

   You can see the metadata by typing:

   ```bash
   ✔ [Απρ/17 23:44] vsc34189@tier2-p-login-2 /scratch/leuven/341/vsc34189/pema-tutorials/extra_material $ more extra_metadata.csv 
   Samples,Biome,Habitat,Location,Chla_waterORflSPFluorescence,Chla_sed,Phaeop_sed,CPE_sed,POC_sed,Temperature,Salinity,O2_mglt,silt_clay,sand
   ERR1906856,Lagoon,Logarou,LOin,1.147296,6.742082534,8.99409309,15.73617562,21320.32147,11.1,27.8,8.42,3.29439559,96.70560441
   ERR1906861,Sea,Kalamitsi,Kal,0.99,2.128711019,1.760383576,3.889094595,5954.198473,19.77,38.82,6.81,1.523781402,98.4762186
   ERR1906866,River,Arachthos,AR,0.4845,0.966869609,1.527981735,2.494851344,11684.21053,14.1,0.2,10.24,21.32269099,78.67730901
   ```


2. Copy the `fastq.gz` files from there to the `mydata` directory. 

   * All the `.fastq.gz` files have the `ERR` prefix, so we can ask to copy all the files starting with that prefix to the `mydata` directory. 

   ```bash 
   cp ERR* ../my_analysis/mydata
   ```

   **Tip:** The `..` means *one directory up*. So you can use such commands without the need for a full path.


3. Edit the `metadata.csv` script

   * View the `extra_metadata.csv` file by typing

   ```bash
   cat extra_metadata.csv
   ```

   * Copy the lines corresponding to the 3 new samples we added in our `mydata` directory, but **not** the header! To do this, type

   ```bash
   tail -3 extra_metadata.csv >> ../my_analysis/metadata.csv
   ```

   To see that your `metadata.csv` has now 6 entries, move to the `my_analysis` directory 
   ```bash
   cd ../my_analysis
   ```
   and view the `metadata.csv` file by typing 
   ```bash 
   cat metadata.csv
   ```



4. Edit the `parameters.tsv` file 

>   You may think of the `parameters.tsv` file as a *paired-end* file where all lines that start with a `#` is a comment and tells you what the next parameter is about and the lines that do not start with a `#` are pairs of the type: *parameter <tab> value*. 
>   The `parameters.tsv` file is a tab separated file, meaning that you always have to remember to leave **a single tab** between the parameter and its value. Careful! Not 3 or 4 spaces, but a **tab**

   * Open the `parameters.tsv` file 
   ```bash 
   nano parameters.tsv
   ```

   <img src="https://i.ibb.co/Lx54KTP/Selection-307.png"  align="center">

   <br />

   * Find the `outputFolderName` parameter and replace its value with any name you would like your analysis to have*, e.g `my_pema_run_at_tutorials`. <br/>

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

   * And then again, save your changes and exit by typing `ctrl+x`, then `y` and `enter`. 




6. **(Optional!)** Edit the `.pbs` script. 

   * Move to the root of this repo, i.e 
   `cd /scratch/USER_PATH`

   * Edit the `.pbs` script by typing `nano pema_job.pbs` and then remove the 3 commands

   ```bash 
   tmp_work_dir=$(pwd) ; path="${tmp_work_dir#*user/}" ; work_dir="/scratch/leuven/$path/pema-tutorials"
   ```

   and the `$work_dir` variable in the PEMA execution command and replace them with your 
   `/scratch/USER_PATH/pema-tutorials`. 

   REMEMBER! You must not write `USER_PATH` but its value for your case! 


   * Save your changes and exit, i.e type `ctrl+x` and then `y`


7. Run your own analysis 


   * Move to the root of this repo, i.e 
   `cd /scratch/USER_PATH`

   * Submit your new job by typing 
      ```
      qsub my_job.pbs
      ```



Here is the corresponding recording with what you need to run on the VSC cluster to complete Part B: 
[![asciicast](https://asciinema.org/a/407924.svg)](https://asciinema.org/a/407924)


***Now you just need to wait for PEMA to run your analysis!!***



<img src="https://memegenerator.net/img/instances/65868280/we-did-it-its-done.jpg" >







### Step-by-step: for those who prefer graphical interface

This way is usually much easier and way more user-friendly. 
However, you need to make sure that your internet connection is good enough as you will have to upload your raw data from your computer to the cluster. 
If you are confident about your internet connection, you should try this way! 

0. You need to download the repository locally on your computer.  You can do this by clicking on the green "Code" button and then "Download as ZIP".  Then, move into the repo and 

1. Go to the `extra_material` directory.

2. **Cut** the `fastq.gz` files stored there. 

3. Move back and enter the `my_analysis` directory and then the `mydata` one

4. Paste the `.fastq.gz` files here

5. Move back to the `my_analysis` directory, open the `phyloseq_in_PEMA.R` script
   Move down to Section 3 and change the any name(s) as you would like to; for example you may change the name `barchart100.pdf` to something that makes more sense to you.

6. Edit the `metadata.csv` script

   * Move again to the `extra_material` directory
   * Open the `extra_metadata.csv` file and copy the lines corresponding to the 3 new samples we added in our `mydata` directory 
   * Move back to the `my_analysis` directory and open the `metadata.csv` file
   * Paste these 3 lines and save your changes

7. Edit the `parameters.tsv` file

   * Open the `parameters.tsv` file and change the value of the `outputFolderName` parameter to anything you would like 

   * Save your changes and close the file. Make sure the name of the file is exactly as it should, i.e `parameters.tsv`.


8. Upload your `analysis_directory` to the VSC cluste

   * Open a terminal and go to the `pema-tutorials` directory that you downloaded on your computer. Assuming that the `pema-tutorials` repository is on your `/home` directory, you need to run

      ```
      cd /home
      ```

   * From there, run the following command replacing the paths accordingly

      ```
      scp -r my_analysis/ vsc34189@login.hpc.kuleuven.be://scratch/leuven/341/vsc34189/
      ```

8. Run your own analysis 

   * Go to your `pema-tutorials` directory and 

   * Submit your new job by typing 
      ```
      qsub my_job.pbs
      ```








While you are waiting for your job to complete, you may have a thorough look on the [`parameters.tsv`](https://github.com/hariszaf/pema-tutorials/blob/main/my_analysis/parameters.tsv) file and all the parameters there. 
As already mentioned this is the key-bone of PEMA as it allows the user to 
specify exactly what it takes to tune the best way an analysis. 

We strongly suggest to visit the documentation sites of the tools invoked, 
for a thourough description of the parameters. 



That's it! Now you may check on your results - and maybe, based on those, run a new analysis to tune better your parameters! 



