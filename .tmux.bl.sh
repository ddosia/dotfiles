#/bin/sh

cur_bl=$(cat /sys/class/power_supply/BAT0/energy_now)
tot_bl=$(cat /sys/class/power_supply/BAT0/energy_full)
bl=`echo $(( $cur_bl * 100 / $tot_bl )) | bc -l | cut -d '.' -f 1`

if [[ $bl -lt 20 ]]; then
    echo "[⚡ #[fg=red]$bl#[default]%]"
else
    echo "[⚡ $bl%]"
fi
