# Phylo Tool

This repo attempts to create a container with an assorment of phylogenetic analysis tools.
It is build as a docker container, but mostly inteded to be pulled as a singularity container, 
for running on a HPC cluster environment.

(This repo has nothing to do with the R/CRAN package phylotools)

## tool

the 'tool' branch contains a number of phylo tools that are available as standard os packages under Ubuntu 20.04.
Tools include MrBayes, mafft, seaview, phyml, etc.

Example setup:

ProgName=phylotool.sif
singularity pull --name ProgName  docker://ghcr.io/tin6150/beast:tool
ln -s $ProgName mb
ln -s $ProgName mafft
ln -s $ProgName tree-puzzle
ln -s $ProgName metaphlan2

then calling mb, mafft, tree-puzzle would get "dispatched" into the right tool inside the container.

See the DevNotes.rst under that branch for more info.


## beast

The phylogenetic software BEAST was the original tool that started this container, and to that end there are a couple of versions,
branch names still centered on this fact.

```{bash}
v2.6.4: contain beast 2.6.3,  build from source
r2.6.3: contain beast 2.6.3,  from Debian 11 bullseyes .deb package.  no beagle-lib to tap gpu 
r1:     contain beast 1.10.4, from Debian 11 bullseyes .deb package, beast 1 works, no beagle-lib.
tool:   contain mrbayes, mafft, muscle and many phylo tool avail from apt install.

# release -> os provided package
# version -> compiled from source
```

Running beast2 on savio hpc using singularity:

```{bash}
[[ -d /global/scratch/users/${USER}/cacheDir ]] && export cacheDir=/global/scratch/users/${USER}/cacheDir
[[ -d $cacheDir ]] && export SINGULARITY_CACHEDIR=$cacheDir
[[ -d $cacheDir ]] && export SINGULARITY_TMPDIR=$cacheDir
[[ -d $cacheDir ]] && export SINGULARITY_WORKDIR=$cacheDir

cd $cacheDir
singularity pull --name beast2.6.4.sif  docker://ghcr.io/tin6150/beast:v2.6.4
# ... /global/scratch/users/tin/singularity-repo/beast2.6.4    # place in consultsw TBD
singularity pull --name beast2.6.4+beagle_b20.sif  docker://ghcr.io/tin6150/beast:v2.6.4

singularity run --nv $cacheDir/image/beast2.6.4+beagle_b15.sif /usr/bin/java -Dlauncher.wait.for.exit=true -Xms256m -Xmx8g -Duser.language=en -cp /opt/gitrepo/beast/lib/launcher.jar beast.app.beastapp.BeastLauncher -beagle_info
but testHKY.xml fails

singularity exec --nv $cacheDir/image/beast2.6.4+beagle_b20.sif /usr/bin/java -Dlauncher.wait.for.exit=true -Xms256m -Xmx8g -Duser.language=en -cp /opt/gitrepo/beast/lib/launcher.jar beast.app.beastapp.BeastLauncher -beagle_info

DataDir=~/myDataDir   								# local host home dir
DataDir=~/gs/tin-gh/beast2/examples   # local host home dir
cd $DataDir


```


Running beast1 on savio hpc using singularity:
(no beagle gpu lib, beast-mcmc distributed as debian os package)

```{bash}
singularity pull --name beast1 docker://ghcr.io/tin6150/beast:r1
```


Docker usage (cloud usage):

```{bash}

docker run -it --rm --gpus all -v ~:/mnt  --entrypoint=/usr/bin/java   ghcr.io/tin6150/beast:v2.6.4  -Dlauncher.wait.for.exit=true -Xms256m -Xmx8g -Duser.language=en -cp /opt/gitrepo/beast/lib/launcher.jar beast.app.beastapp.BeastLauncher -beagle_info


```


beast1 example command

```
docker run -v ~:/mnt -it --entrypoint=/usr/bin/java  ghcr.io/tin6150/beast:v1 -cp ${ContainerBeastJarDir}/beast.jar dr.app.beast.BeastMain -seed 2020 -beagle_double -beagle_gpu -save_every 1000000 -save_state myBeast.checkpoint ${DataDir}/beast1_travel.xml
```



ps.  
the main branch now is mostly a place holder with summary info about the various tools under the various branches.
It has a old container with beast (v1), which was not fully tested.

many of the tested tools are on the other branches.

See DevNotes.rst under those branches for specific info on how such container was build and usage tricks.

