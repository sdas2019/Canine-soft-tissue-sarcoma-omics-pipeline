## NOTE: change the line below if you have installed the Matlab MCR in an alternative location
## This code was adapted from https://github.com/sbamin/canine_gistic2

MCR_ROOT=`pwd`/MATLAB_Compiler_Runtime
MCR_VER=v80

echo Setting Matlab MCR root to $MCR_ROOT

## set up environment variables
LD_LIBRARY_PATH=$MCR_ROOT/$MCR_VER/runtime/glnxa64:$LD_LIBRARY_PATH
LD_LIBRARY_PATH=$MCR_ROOT/$MCR_VER/bin/glnxa64:$LD_LIBRARY_PATH
LD_LIBRARY_PATH=$MCR_ROOT/$MCR_VER/sys/os/glnxa64:/home/sunetra/gistic/MATLAB_Compiler_Runtime/v80/sys/java/jre/glnxa64/jre/lib/amd64/server:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH
#XAPPLRESDIR=$MCR_ROOT/$MCR_VER/MATLAB_Component_Runtime/v80/X11/app-defaults
XAPPLRESDIR=$MCR_ROOT/$MCR_VER/X11/app-defaults
export XAPPLRESDIR


## load MCR/8.0 env; other versions may not work
#module load rvMCR/8.0
sleep 2
echo "MCR_ROOT is ${MCR_ROOT}"

## set vars
## gistic code directory
GITDIR="/home/sunetra/gistic"
## output dir
BASEDIR="/home/sunetra/gistic"
## canfam3_1_order.mat was built by @jemartinezledes
REFGENE="${GITDIR}/canfam3_1_order.mat"

# export GISTIC2 code directory in PATH
export PATH="${PATH}:${GITDIR}"

## run with scna segment file
OUTDIR1="${BASEDIR}/OS.VS.CNV"
mkdir -p "${OUTDIR1}"
## Read README on how to make segment and marker file.
SEGFILE1="${BASEDIR}/gisticInput.VS/all_segments.txt"
MARKERS1="${BASEDIR}/gisticInput.VS/markers_gistic.txt"

#### RUN GISTIC2 ####
cd "$GITDIR" && \
gp_gistic2_from_seg_upd -b "${OUTDIR1}" -seg "${SEGFILE1}" -mk "${MARKERS1}" -refgene "${REFGENE}" -maxseg 25000 -savegene 1 -genegistic 1