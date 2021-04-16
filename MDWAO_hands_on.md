# PEMA hands-on @ MDAWO

## The `my_analysis` directory

In the [`my_analysis`](https://github.com/hariszaf/pema-mdawo/tree/main/my_analysis) directory you will find the exact input we used to run the first PEMA analysis on the VSC cluster. 

In the [`mydata`](https://github.com/hariszaf/pema-mdawo/tree/main/my_analysis/mydata) folder, you will find 6 `.fastq.gz` samples coming from 3 paired-end samples. 


🆘 While the name of the `my_analysis` directory can be anything, the name of the `mydata` folder needs to stay always like this!



## The `extra_material` directory

In the [`extra_material`](https://github.com/hariszaf/pema-mdawo/tree/main/extra_material) folder, you will find some extra `.fastq.gz` files coming from samples from the same study with those we have already run in the first part of the hands-on. 

You will also find a `.csv` file called `extra_metadata.csv`. 

This directory is just for you to practice, as a simulation of how you would set up 
a PEMA analysis. It has nothing to do with the PEMA actual code. 


-------------------

Many thanks to Dr. Christina Pavloudi for providing us with both data and their corresponding metadata.
You may find this project in ENA under this [link](https://www.ebi.ac.uk/ena/browser/view/PRJEB20211).


## Run your own analysis! 

Our goal is to set everything needed for a PEMA analysis. 

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
   💯 No we have seen exactly that the `analysis_directory` includes. <br/>
   This is how this directory is supposed to be. <br/> 
   
   
   🆘 **However, to save time, please remove all the `.fastq.gz` from the `mydata` folder.<br/>**
   **We will upload everything else to the VSC cluster and we will copy our raw data from 
   my account on VSC to yours.** 🆘

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


