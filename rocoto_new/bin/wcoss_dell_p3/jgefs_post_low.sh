#!/bin/ksh
#

# EXPORT list here
set -x

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

export NODES=2
export total_tasks=24
export OMP_NUM_THREADS=2
export taskspernode=12
export POSTGRB2TBL=/gpfs/dell1/nco/ops/nwprod/lib/g2tmpl/v1.5.0/src/params_grib2_tbl_new

export FORECAST_SEGMENT=lr

export envir=${envir:-dev}
export RUN_ENVIR=${RUN_ENVIR:-dev}

export gefsmpexec=" mpirun -n $total_tasks "

# CALL executable job script here
$SOURCEDIR/jobs/JGEFS_NCEPPOST
