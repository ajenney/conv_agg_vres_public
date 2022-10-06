#!/bin/csh

# Loop through timesteps in big file and save each timestep
# as a new file

# how to save files
set fout = RCE_rcemip-small_99km_300K_nz_32_128_

# variable names
set varnames = ('CLD' 'CWP' 'IWP' 'LHF' 'LWNS' 'LWNSC' 'LWNT' 'LWNTC' 'PSFC' 'PW' 'Prec' 'SHF' 'SOLIN' 'SWNS' 'SWNSC' 'SWNT' 'SWNTC' 'SWVP' 'TB' 'U200' 'U850' 'USFC' 'V200' 'V850' 'VSFC' 'W500' 'ZC' 'ZE')

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

    ncks -v $variable $filename ${fout}${variable}_${tstr}.2Dbin.nc

    # move to folder
    mv *$variable*.nc $variable/

  end

  rm $filename

end
