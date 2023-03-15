# Short assignment for the MSc course "Applied Bioinformatics & Data Analysis" 

## Table of Contents

1. [Aim of this assignment!](#aim-of-this-assignment)
2. [Run a metabarcoding analysis with PEMA](#run-a-metabarcoding-analysis-with-pema-mandatory)
3. [Run and develop CWL toy-workflows](#run-and-develop-cwl-toy-workflows)

----------

## Aim of this assignment 

Each group will:
- run a metabarcoding analysis using PEMA
- based on its outcome, will highlight the effect of paramaters tuning in such an analysis

and optionally:

- run a CWL tool 
- develop a 2-steps workflow on CWL 

-------------

## Run a metabarcoding analysis with PEMA (mandatory)


- Login to your account on the MSc server 

- Get `pema v2.0.4` by running (this step should be already done for you): 
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

On this branch, you will find:

1. The [`my_analysis`](https://github.com/hariszaf/pema-tutorials/tree/ms-democr-class/my_analysis) folder 

   This directory includes a complete example of a PEMA analysis. 
   Both the mandatory and optional input files for PEMA as well as an example output.
   In the [`mydata`](https://github.com/hariszaf/pema-tutorials/tree/ms-democr-class/my_analysis/mydata) folder, you will find 6 `.fastq.gz` samples coming from 3 paired-end samples. 

   🆘 While the name of the `my_analysis` directory can be anything, the name of the `mydata` folder needs to **stay always like this!**

2. The [`parameters.tsv`]() file
   
   You may think of the `parameters.tsv` file as the interface between PEMA and the user. It is a *paired-end* file where all lines that start with a `#` is a comment and tells you what the next parameter is about and the lines that do not start with a `#` are pairs of the type: *parameter <tab> value*. 
      >   The `parameters.tsv` file is a tab separated file, meaning that you always have to remember to leave **a single tab** between the parameter and its value. Careful! Not 3 or 4 spaces, but a **tab**.  PEMA will **fail** if there's not a tab after a parameter namer!

3. A `.csv` file called `extra_metadata.csv` with the corresponding metadata of these extra samples.

4. The [`extra_material`](https://github.com/hariszaf/pema-mdawo/tree/ms-democr-class/extra_material) folder

   In this folder, you will find some extra `.fastq.gz` files coming from samples from the same study with those on the `mydata` directory. 



Here is an overview of how a PEMA analysis directory looks like: 
<img src="https://i.ibb.co/6Pyqwpt/pema-anlysis-dir.png">



Each group, should perform at least 2 of the first 3 tasks and at least other 2 from the rest 5, i.e. you will have 2 
analyses with 3 samples and other 2 analyses with 6 samples. All you need to do is to edit the `parameters.tsv` file and add the extra samples when needed in the `mydata` folder. 

| No Task | Task description |
|-|-|
| 1 | first 3 samples, low strictness, OTUs score = 0.99, Silva 132 |
| 2 | first 3 samples, high strictness, ASVs (d = 1), Silva 132 |
| 3 | first 3 samples, high strictness, ASVs (d = 5), Silva 132 |
| 4 | all 6 samples, low strictness, OTUs (score = 0.97), Silva 132 |
| 5 | all 6 samples, high strictness, OTUs (score = 0.99), Silva 132 |
| 6 | all 6 samples, low strictness, ASVs (d = 1), Silva 132 |
| 7 | all 6 samples, high strictness, ASVs (d = 5), remove singletons, Silva 132 |
| 8 | all 6 samples, very high value of strictness, ASVs (d = 20), Silva 132 |


To use all the 6 samples, you just need to move the extra ones from the [`extra_material`](https://github.com/hariszaf/pema-mdawo/tree/ms-democr-class/extra_material) folder to `mydata`.


Once you have set your `mydata` folder and the `parameters.tsv` accordingly, all you have to do to run PEMA is this: 
```
docker run --rm -it -v /<path_to_your>/analysis_directory/:/mnt/analysis hariszaf/pema:2.1.4
```

Based on your results, **report how the parameters you chose affected PEMA's output** with respect to the final OTU/ASV table (`final_table.tsv`)!

**If you are interested**, you may move on with the biodiversity analysis of these OTU tables and work further with the `phyloseq` package. You may do this through PEMA or by just using R on the server and the `phyloseq` library. 
You may have a look on the [`phyloseq_in_PEMA.R`](https://github.com/hariszaf/pema-tutorials/blob/mdawo/my_analysis/phyloseq_in_PEMA.R) script or in the `phyloseq` [tutorials](https://joey711.github.io/phyloseq/distance.html) to see how you can go for it! 

> Just for your interest, in case you would use Singularity instead of Docker, you would as simply run:
```
singularity run -B $work_dir/my_analysis:/mnt/analysis /ddn1/vol1/site_scratch/leuven/314/vsc31426/pema_v.2.0.4.sif
```


-------------------

Many thanks to [Dr. Christina Pavloudi](https://cpavloud.github.io/mysite/) for providing us with both data and their corresponding metadata.
These data are from a study aiming to investigate the sediment bacterial diversity of a transect river-lagoon-open sea.
You may find this project in ENA under this [link](https://www.ebi.ac.uk/ena/browser/view/PRJEB20211).

-------------------

<img src="https://camo.githubusercontent.com/762c1129f266494bbbb3faff3d673040cf7b1f19d45c6e13f49b08de12f5116a/68747470733a2f2f692e70617374652e706963732f38373031383966616466363638613935386338616163383366333865373939632e706e67" width= 220px; align="center"  />


## Run and develop CWL toy-workflows


If interested in technologies such as the Common Workflow Language (CWL), you may jump into the [hands-on session of the EMO BON hackathon 2022](https://github.com/emo-bon/hackathon2022/blob/ef2ccbb737a71feebbc0e5bd11fd656be3e5956c/handson_instructions.md). You will have to skip the commands related to the server described for that tutorial, but you may move straightforwarf from the [Clone the emo-bon/Hackathon2022 GitHub repository](https://github.com/emo-bon/hackathon2022/blob/ef2ccbb737a71feebbc0e5bd11fd656be3e5956c/handson_instructions.md#clone-the-emo-bonhackathon2022-github-repository) step.


## a short comment on the assignment

This 2-hours course attempts to present a great range of concepts both biology and computer science related. 
Apparently, only a short introduction of these topics is possible here. 
For anything that you would like to discuss furtner, either on the assignments or the presentation, you are the most welcome to contact me at haris.zafeiropoulos@kuleuven.be. Imho, communication is essential to better understand and develop! :tada:  





