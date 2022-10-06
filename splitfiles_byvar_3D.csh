#!/bin/csh

# Loop through timesteps in big file and save each timestep
# as a new file

# how to save files
# RCE_rcemip-small_99km_300K_nz_32_128_0000864000.nc
set fout = RCE_rcemip-small_99km_300K_nz_32_128_

# variable names
set varnames = ('p' 'U' 'V' 'W' 'PP' 'QRAD' 'TABS' 'QV' 'QN' 'QP') 

# loop through each variable name and create a directory 
foreach variable ( $varnames )
  mkdir $variable
end

# read file names
set files = ( `ls *.nc` )

# loop through files
foreach filename ( $files )

  # time string
  set tstr = `echo ${filename} | cut -c38-47`

  # loop through variables
  foreach variable ( $varnames )

    ncks -v $variable $filename ${fout}${variable}_${tstr}.nc

    # move to folder
    mv *_${variable}_*.nc $variable/

  end

  rm $filename

end
