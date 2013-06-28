set title "Result of UCB Algorithm"
set xrange [0:500]
set yrange [0:0.5]
set xlabel "time (count)"
set ylabel "weight for arms"

plot "./out/ucb.csv" using 1:2 w l title "candidate 1"
replot "./out/ucb.csv" using 1:3 w l title "candidate 2"
replot "./out/ucb.csv" using 1:4 w l title "candidate 3"
replot "./out/ucb.csv" using 1:5 w l title "candidate 4"
replot "./out/ucb.csv" using 1:6 w l title "candidate 5"
