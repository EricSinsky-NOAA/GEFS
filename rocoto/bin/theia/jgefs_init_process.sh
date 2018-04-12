#!/bin/ksh

# EXPORT list here
set -x
export NODES=5
export IOBUF_PARAMS=
export FORT_BUFFERED=TRUE
export MKL_CBWR=AVX
ulimit -s unlimited
ulimit -a

export ATP_ENABLED=0
export MALLOC_MMAP_MAX_=0
export MALLOC_TRIM_THRESHOLD_=134217728

export MPICH_ABORT_ON_ERROR=1
export MPICH_ENV_DISPLAY=1
export MPICH_VERSION_DISPLAY=1
export MPICH_CPUMASK_DISPLAY=1

export MP_EUIDEVICE=sn_all
export MP_EUILIB=us
export MP_SHARED_MEMORY=no
export MEMORY_AFFINITY=core:6

export total_tasks=20
export OMP_NUM_THREADS=6
export taskspernode=4

#export total_tasks=20

#Date and Cycle
#export PDY=20160415
#export cyc=00
#export cyc_fcst=00
#export job=Aa2016041500013

# export for development runs only begin
export envir=${envir:-dev}
export RUN_ENVIR=${RUN_ENVIR:-dev}
export gefsmachine=theia
export gefsmpexec="mpirun -np $total_tasks"
export gefsmpexec_mpmd="mpirun -np $total_tasks /scratch3/NCEPDEV/nwprod/util/exec/mpiserial"
export APRUNC="mpirun -np $total_tasks"
export aprun_gec00="mpirun -np 1"
export NTHREADS_SIGCHGRS=6

cd $SOURCEDIR/control

#. $SOURCEDIR/parm/gefs.parm

# CALL executable job script here
$SOURCEDIR/jobs/JGEFS_INIT_PROCESS

