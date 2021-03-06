#!/bin/bash
##############################################################
# Submission options for use with SGE batch-queueing systems.
#
# This script shall be run on a SGE cluster headnode with
#  qsub <script_name>
# to enqueue the specified job.
#
# Note: Commented commands (i.e. #$ ...) are intentional!
# Do not "uncomment", qsub will use these as configurations.
##############################################################
#
# Job name
#$ -N cs205
#
# Join stdout and stderr
#$ -j y
#
# Use current working directory
#$ -cwd
#
# Run job through bash shell
#$ -S /bin/bash
#
# Submission queue.
#$ -q gpubatch.q
#
# Parallel environment and number of processes.
#$ -pe ortegpu_reserve 2
#
##############################################################
# Import environment variables, libraries, and profile
##############################################################
# Harvard cluster specific software
#source /etc/profile
#module load courses/cs205/2013
#
##############################################################
# Extra information for the header of the output file.
##############################################################
date
echo "****************************************"
echo "****************************************"
echo "Computation starting"
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
PY_SCRIPT_PATH=$DIR"/image_analogies_parallel.py"

##############################################################
# Full command of the job
##############################################################
cd ~/workspaces/matlab/vfx/Data/skinRender/microgeometry
# Run 4 processes for each image
EXT="c"
#EXT=""
I=1
while [  $I -lt 11 ]; do
	echo "****************************************"
	echo "Image num:" $I
	echo "****************************************"
	mpiexec -n 4 python $PY_SCRIPT_PATH "./original/A0_"$I$EXT".png" "./original/A1_"$I$EXT".png" "./synthesized/B0_"$I$EXT".png" "./synthesized/B1_"$I$EXT".png"
	let I=I+1 
done

#mpiexec -n 8 python image_analogies_parallel.py artistic1_A1.png artistic1_A2.png artistic1_B1.png artistic1_B2_1_core.png
#mpiexec -n 8 python image_analogies_parallel.py A0g3c1.png A1g3c1.png B0g3c1.png B1_8cores.png
#mpiexec -n 4 python $PY_SCRIPT_PATH $1 $2 $3 $4
#mpiexec -n 4 python image_analogies_parallel.py embossA1g.png embossA2g.png blurB1.png embossB2g.png
#
##############################################################
# Extra information for the footer of the output file
##############################################################
echo "Computation ended"
echo "****************************************"
echo "****************************************"
date
