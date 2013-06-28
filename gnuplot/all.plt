set xrange [0:300]
set yrange [0:0.5]
set key box

set multiplot layout 3,1

set size 1,0.33
set origin 0,0
set bmargin 3
set tmargin 0
set ylabel 'Result of UCB Algorithm'
set title ''
set xlabel 'time(count)'
plot "./out/ucb.csv" using 1:2 w l title "candidate 1",\
  "./out/ucb.csv" using 1:3 w l title "candidate 2",\
  "./out/ucb.csv" using 1:4 w l title "candidate 3",\
  "./out/ucb.csv" using 1:5 w l title "candidate 4",\
  "./out/ucb.csv" using 1:6 w l title "candidate 5"

set size 1,0.33
set origin 0,0.33
set bmargin 1
set tmargin 1
set ylabel 'Result of Softmax Algorithm'
set xlabel ''
set title ''
set format x''
plot "./out/softmax.csv" using 1:2 w l title "candidate 1",\
  "./out/softmax.csv" using 1:3 w l title "candidate 2",\
  "./out/softmax.csv" using 1:4 w l title "candidate 3",\
  "./out/softmax.csv" using 1:5 w l title "candidate 4",\
  "./out/softmax.csv" using 1:6 w l title "candidate 5"

set size 1,0.33
set origin 0,0.66
set bmargin 0
set tmargin 2
set ylabel 'Result of Epsilon-Greedy Algorithm'
plot "./out/epsilon.csv" using 1:2 w l title "candidate 1",\
  "./out/epsilon.csv" using 1:3 w l title "candidate 2",\
  "./out/epsilon.csv" using 1:4 w l title "candidate 3",\
  "./out/epsilon.csv" using 1:5 w l title "candidate 4",\
  "./out/epsilon.csv" using 1:6 w l title "candidate 5"

unset multiplot
