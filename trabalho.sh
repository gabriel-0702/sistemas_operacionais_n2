echo "Top 5 — CPU"
ps -eo pid,user,pcpu,pmem,etime,comm --sort=-pcpu | head -n 6
echo
echo "Top 5 — MEM"
ps -eo pid,user,pcpu,pmem,etime,comm --sort=-pmem | head -n 6
top