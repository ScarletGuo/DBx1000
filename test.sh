rm debug-1.out
cp -r config_tpcc_debug.h config.h
#cp -r config_real.h config.h
wl='tpcc'
#wl='ycsb'
python test_debug.py ${wl} "NO_WAIT,CLV,WOUND_WAIT,WAIT_DIE" |& tee debug-1.out
#python test_debug.py ${wl} "CLV" |& tee debug-1.out
#python test_debug.py ${wl} "WAIT_DIE" |& tee debug.out
