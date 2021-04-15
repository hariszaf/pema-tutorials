# PEMA hands-on @ MDAWO

In this folder, you will find some extra `.fastq.gz` files coming from samples from the same study with those 
we have already run in the first part of the hands-on. 

You will also find a `.csv` file called `extra_metadata.csv`. 


The aim is to follow the instructions on the presentation (or you may see below) and run 
a new PEMA analysis including both the initial and the samples stored here, their metadata as well.  


1. Download the `pema-mdawo` repository. <br/>
You can either `git pull https://github.com/hariszaf/pema-mdawo.git`  <br/>
or download it as a `.zip` file.


2. Add the extra samples located at the `extra_material` directory. 

   * Open the repository and enter the extra_material directory
   * Cut all the .fastq.gz files from there
   * Move back and enter the my_analysis directory and then to the mydata
   * And paste the fastq.gz files here


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
   Change the names as you would like t


5. Edit the `metadata.csv` script

   * Move again to the `extra_material` directory
   * Open the `extra_metadata.csv` file and copy the lines corresponding to the 3 new samples we added in our `mydata` directory 
   * Move back to the `my_analysis` directory and open the `metadata.csv` file
   * Paste these 3 lines and save your changes


6. Upload your `analysis_directory` to the VSC cluste

   * run the following command replacing the paths accordingly

      ```
      scp -r my_analysis/ vsc34189@login.hpc.kuleuven.be://scratch/leuven/341/vsc34189/
      ```


7. Edit the `.pbs` script. 

   * Move to your home directory, i.e type `cd `
   * Edit the `.pbs` script using the `nano` program, i.e type `nano pema_job.pbs`
   * Replace the `/mdawo/` directory with your `my_analysis` one
   * Save your changes and exit, i.e type `ctrl+x` and then `y`


8. Run your own analysis 

   * Submit your new job by typing 
      ```
      qsub pema_job.pbs
      ```


Now you just need to wait for PEMA to run your analysis. 

Im the meanwhile you may have a thorough look on the `parameters.tsv` file
and all the parameters there. 

As already mentioned this is the key-bone of PEMA as it allows the user to 
specify exactly what it takes to tune the best way an analysis. 

It is strongly suggested to visit the documentation sites of the tools invoked 
for a thourough description of the parameters. 

-------------------

Many thanks to Dr. Christina Pavloudi for providing us with both data and their corresponding metadata.
You may find this project in ENA under this [link](https://www.ebi.ac.uk/ena/browser/view/PRJEB20211).
