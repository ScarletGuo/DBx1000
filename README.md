DBx1000
=======

DBx1000 is a single node OLTP database management system (DBMS). The goal of DBx1000 is to make DBMS scalable on future 1000-core processors. We implemented all the seven classic concurrency control schemes in DBx1000. They exhibit different scalability properties under different workloads. 

The concurrency control scalability study is described in the following paper. 

    Staring into the Abyss: An Evaluation of Concurrency Control with One Thousand Cores
    Xiangyao Yu, George Bezerra, Andrew Pavlo, Srinivas Devadas, Michael Stonebraker
    http://www.vldb.org/pvldb/vol8/p209-yu.pdf
    
Build & Run
------------

To build the database.

    make -j

To test the database

    python test.py $workload $algorithm $threads $max_txn_count $penalty $abort_penalty $num_warehouses


$workload: Supported workloads include YCSB and TPCC
$alg: Concurrency control algorithm. Five algorithms are supported (CLV, WOUND_WAIT, NO_WAIT, WAIT_DIE, HEKATON)
$threads: int, number of threads
$max_txn_count:  int, number of transactions to run per thread, default is 100000
$abort_penalty: int, default is 1
$num_warehouses: int, default is 1
    
Run with Customized Configuration
---

The DBMS can be run with customized configuration by modifying config.h. 

    ./rundb

Output
------

txn_cnt: The total number of committed transactions. This number is close to but smaller than THREAD_CNT * MAX_TXN_PER_PART. When any worker thread commits MAX_TXN_PER_PART transactions, all the other worker threads will be terminated. This way, we can measure the steady state throughput where all worker threads are busy.

abort_cnt: The total number of aborted transactions. A transaction may abort multiple times before committing. Therefore, abort_cnt can be greater than txn_cnt.

run_time: The aggregated transaction execution time (in seconds) across all threads. run_time is approximately the program execution time * THREAD_CNT. Therefore, the per-thread throughput is txn_cnt / run_time and the total throughput is txn_cnt / run_time * THREAD_CNT.

time_{wait, ts_alloc, man, index, cleanup, query}: Time spent on different components of DBx1000. All numbers are aggregated across all threads.

time_abort: The time spent on transaction executions that eventually aborted.

latency: Average latency of transactions.







