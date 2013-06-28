set title "Result of Epsilon-Greedy Algorithm"
set xrange [0:300]
set yrange [0:0.5]
set xlabel "time (count)"
set ylabel "weight for arms"

plot "./out/epsilon.csv" using 1:2 w l title "candidate 1",\
  "./out/epsilon.csv" using 1:3 w l title "candidate 2",\
  "./out/epsilon.csv" using 1:4 w l title "candidate 3",\
  "./out/epsilon.csv" using 1:5 w l title "candidate 4",\
  "./out/epsilon.csv" using 1:6 w l title "candidate 5"

