#!/bin/ksh

# EXPORT list here
set -x
export NODES=1
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

export KMP_STACKSIZE=1024m
export OMP_NUM_THREADS=2
export KMP_AFFINITY=disabled

#export OMP_NUM_THREADS=2
export KMP_AFFINITY=disabled

export MP_EUIDEVICE=sn_all
export MP_EUILIB=us
export MP_SHARED_MEMORY=yes
export MEMORY_AFFINITY=core:2

export total_tasks=12
export OMP_NUM_THREADS=2
export taskspernode=12
export POSTGRB2TBL=/gpfs/hps/nco/ops/nwprod/lib/g2tmpl/v1.3.0/src/params_grib2_tbl_new

#Date and Cycle
#export PDY=20160415
#export cyc=00
#export cyc_fcst=00
#export job=Aa2016041500302
#export RUNMEM=gep01
export FORECAST_SEGMENT=lr

#export gefsmpexec_mpmd=mpirun.lsf

# export for development runs only begin
export envir=${envir:-dev}
export RUN_ENVIR=${RUN_ENVIR:-dev}
export gefsmachine=theia
export gefsmpexec="mpirun -np $total_tasks"
export gefsmpexec_mpmd="mpirun -np $total_tasks /scratch3/NCEPDEV/nwprod/util/exec/mpiserial"
export APRUNC="mpirun"
export aprun_gec00="mpirun -np 1"
export NTHREADS_SIGCHGRS=6

cd $SOURCEDIR/control

#. $SOURCEDIR/parm/gefs.parm

# CALL executable job script here
$SOURCEDIR/jobs/JGEFS_NCEPPOST
