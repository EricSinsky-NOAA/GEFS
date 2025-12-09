import os
import shutil
import re
def stage_ecflow(dicBase):
    ECF_dir2 = "/lfs/h2/emc/ens/noscrub/eric.sinsky/ecflow/ecflow_home/submit/prod/primary/00/gefs/v12.2"
    packagedir =  dicBase['SOURCEDIR']
    ecfoutput = dicBase['WORKDIR']+"/ecf/output"
    GEFS_ROCOTO =  dicBase['GEFS_ROCOTO']
    EXPID =  dicBase['EXPID']
    WORKDIR = dicBase['WORKDIR']

    # 1. mkdir -p $ECF_dir2
    os.makedirs(ECF_dir2, exist_ok=True)

    # 2. cp -rvf $packagedir/* $ECF_dir2
    #    shutil.copytree handles directories recursively.
    #    We'll merge contents manually to mimic cp -rvf
    for item in ["ecf"]:
        src = os.path.join(packagedir, item)
        dest = os.path.join(ECF_dir2)
        if os.path.isdir(src):
            shutil.copytree(src, dest, dirs_exist_ok=True)
        else:
            shutil.copy2(src, dest)

    # 3. File paths
    prod00def = os.path.join(ECF_dir2, "def", "gefs_prod00.def")
    prod00def_temp = os.path.join(ECF_dir2, "def", "gefs_prod00_tmp.def")

    # 4. awk part: insert lines after /suite prod/
    with open(prod00def, "r") as infile, open(prod00def_temp, "w") as outfile:
        for line in infile:
            if "suite prod" in line:
                outfile.write(line)
                outfile.write("  edit ENVIR 'dev'\n")
                outfile.write("  edit MACHINE_SITE 'development'\n")
                outfile.write("  edit CYC '00'\n")
                outfile.write("  edit PROJ 'GEFS'\n")
                outfile.write("  edit PROJENVIR 'DEV'\n")
                outfile.write("  edit QUEUE 'dev'\n")
                outfile.write(f"  edit OUTPUTDIR '{ecfoutput}'\n")
                outfile.write(f"  edit GEFS_ROCOTO '{GEFS_ROCOTO}'\n")
                outfile.write(f"  edit EXPID '{EXPID}'\n")
                outfile.write(f"  edit WORKDIR '{WORKDIR}'\n")
#               outfile.write("  edit PDY '2025080'\n")
            else:
                outfile.write(line)

    # Replace the original
    shutil.move(prod00def_temp, prod00def)

    # 5. sed part: replace PACKAGEHOME path
    with open(prod00def, "r") as f:
        content = f.read()

    pattern = r"^(\s*)edit PACKAGEHOME '.*'"
    replacement = rf"\1edit PACKAGEHOME '{packagedir}'"
    content = re.sub(pattern, replacement, content, flags=re.MULTILINE)

    with open(prod00def, "w") as f:
        f.write(content)

