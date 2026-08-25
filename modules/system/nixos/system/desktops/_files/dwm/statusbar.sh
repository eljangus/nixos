# dwm status bar text, updated via xsetroot. Colours are Tokyo Night Moon
# (see modules/home-manager/common/_files/kitty/themes/tokyo-night-moon.conf)
# and require dwm's status2d patch to render (^c#RRGGBB^...^d^ colour codes).

red="ff757f"    # color1
green="c3e88d"  # color2
blue="82aaff"   # color4
fg_dark="828bb8" # color7, used for the separators

sep=" ^c#${fg_dark}^│^d^ "

read_cpu_sample() {
	read -r _ user nice system idle iowait irq softirq steal _ < /proc/stat
	local total=$((user + nice + system + idle + iowait + irq + softirq + steal))
	echo "$idle $total"
}

read -r prev_idle prev_total < <(read_cpu_sample)

while true; do
	sleep 2

	read -r idle total < <(read_cpu_sample)
	diff_idle=$((idle - prev_idle))
	diff_total=$((total - prev_total))
	cpu=0
	if ((diff_total > 0)); then
		cpu=$(( (100 * (diff_total - diff_idle)) / diff_total ))
	fi
	prev_idle=$idle
	prev_total=$total

	mem_total_kib=0
	mem_avail_kib=0
	while read -r key value _; do
		case "$key" in
		MemTotal:) mem_total_kib=$value ;;
		MemAvailable:) mem_avail_kib=$value ;;
		esac
	done < /proc/meminfo
	mem_used_gib=$(awk -v t="$mem_total_kib" -v a="$mem_avail_kib" 'BEGIN { printf "%.1f", (t - a) / 1024 / 1024 }')
	mem_total_gib=$(awk -v t="$mem_total_kib" 'BEGIN { printf "%.1f", t / 1024 / 1024 }')

	clock=$(date '+%a %d.%m  %H:%M')

	xsetroot -name "^c#${red}^ ${cpu}%^d^${sep}^c#${green}^ ${mem_used_gib}/${mem_total_gib}G^d^${sep}^c#${blue}^ ${clock}^d^ "
done
