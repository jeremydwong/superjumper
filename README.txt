this folder contains data files:

justBiarticularsPOS3.txt
justHipPOS3.txt
baselinePOS3.txt
optPOS3.txt

the file importC loads the datafiles (header and time-series data) into Matlab. The meaning of each column is transparent from the loading function. 

init = initial conditions of the model (24 states)
istim = initial stimulation of the muscles (dim.less)
tstim = stim onset times for the muscles (s)
m = segment masses (kg)
j = segment inertias (kg m^2)
l = segment lengths (m)
d = distance between proximal joint and segment mass center (m)
fmax = maximum isometric muscle force (N)
rlceopt = optimum muscle length (m)
rlsenul = tendon slack length (m)

dt=1/1000;
out.t = time (s)
out.state = ode states
out.phi = angles [external reference frame, angles all from positive X axis] (radians)
out.phiseg = inter-segment angles (radians)
ddt_phiseg
out.ddt_phi
out.base = position of the foot (m)
out.lcerel = contractile element length (dim.less)
 out.gamma = calcium concentration (dim.less)
out.x = center of mass horizontal position (m)
out.y = center of mass vertical position (m)
out.cmx = position of segments (m)
out.cmy = position of segments (m)
out.tor = net joint torques (N m)
out.fse = force in the series-elastic element (N)
out.fpe = force in the parallel-elastic element (N)
out.loi = muscle-tendon complex length (m)
out.ese = tendon excursion (m)
out.q = muscle active state (dim.less)
out.stim = muscle stimulation (dim.less)