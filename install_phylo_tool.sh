#!/bin/bash

## install beast and other phylo tool like mafft, muscle, raxml
## the beagle library will be installed, though not sure of the OS packaged tool could use it
## actually by libhmsbeagle* packages
## expect to be called by a container install script, eg Dockerfile

## branch tool that install various tools


export TERM=dumb
export NO_COLOR=TRUE
export DEBIAN_FRONTEND=noninteractive
export NO_COLOR=1

# ubuntu focal package name
# beast2-mcmc/stable 2.6.3+dfsg-2 all
apt-get -y --quiet install libhmsbeagle1v5 libhmsbeagle-java libhmsbeagle-dev libhmsbeagle-dev  libpll0 libpll-dev libpal-java 
apt-get -y --quiet install beast2-mcmc beast2-mcmc-examples beast2-mcmc-doc mrbayes mrbayes-doc mrbayes-mpi raxml  mafft muscle libmuscle1 libmuscle-dev r-bioc-hsmmsinglecell tree-ppuzzle tree-ppuzzle-doc sumtrees seaview phyx phyutility physamp phyml phast paml  njplot  metaphlan2 metaphlan2-data clearcut examl fastdnaml 
echo $?
apt-get -y --quiet install figtree bali-phy treeviewx  belvu bppphyview 
echo $?

date