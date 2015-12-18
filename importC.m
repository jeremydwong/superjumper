function out = importC(fname)
% function out = importC(fname)
header = dlmread(fname,' ',[0,0,0,141]);
sys = struct;
nmus = 6;

sys.init = header(1:24);
sys.istim = header(25:30);
sys.tstim = header(31:36);
sys.m = header(37:40);
sys.j = header(41:44);
sys.l = header(45:48);
sys.d = header(49:52);
sys.fmax = header(53:58);
sys.rlceopt = header(59:64);
sys.rlsenul = header(65:70);
rmapardat = header(71:142);
sys.rmapar = zeros(12,nmus);
for i =1:12
    sys.rmapar(i,:) = rmapardat((i-1)*nmus+1:i*nmus);
end;
out.sys = sys;

dt=1/1000;
data = dlmread(fname,' ',1,0); %skip the introline.
out.t = (linspace(0,(length(data))*dt,length(data)))';
out.t = repmat(out.t,1,nmus);
out.state = data(:,1:24);
out.phi = data(:,1:4);
out.phiseg = [out.phi(:,1),diff(out.phi,1,2)];
[~,out.ddt_phiseg] = gradient(out.phiseg,dt);
out.ddt_phi = data(:,5:8);
out.base = data(:,9:10);
out.ddt_base = data(:,11:12);
out.lcerel = data(:,13:18);
[~,out.ddt_cerel] = gradient(out.lcerel,1/1000);
out.gamma = data(:,19:24);
% onesline = data(:,25);
out.x = data(:,26:30);
out.y = data(:,31:35);
out.cmx = data(:,36);
out.cmy = data(:,37);
% onesline=data(:,38);
out.tor = data(:,39:42);
out.fse = data(:,43:48);
out.fpe = data(:,49:54);
out.loi = data(:,55:60);
out.ese = data(:,61:66);
out.q = data(:,67:72);
out.stim = data(:,73:78);
out.torground = data(:,79);
% hardcoded width of the force-length relationship.
width = .56;
c1= -1.0./(width.^2);
c2= -2.0*c1;
c3=  1.0+c1;
c1col = repmat(c1,length(out.lcerel),6);
c2col = repmat(c2,length(out.lcerel),6);
c3col = repmat(c3,length(out.lcerel),6);
out.Fisomq=out.q.*max(c1col.*out.lcerel.^2+c2col.*out.lcerel+c3col,ones(length(out.lcerel),nmus)*1e-5);
out.Fisom=max(c1col.*out.lcerel.^2+c2col.*out.lcerel+c3col,ones(length(out.lcerel),nmus)*1e-5);
out.Fve=out.fse./out.q./max(c1col.*out.lcerel.^2+c2col.*out.lcerel+c3col,ones(length(out.lcerel),nmus)*1e-5)./repmat(out.sys.fmax,length(out.t),1);
out.sys.mnames = {'sol','gas','vas','rec','glu','ham'};
out.sys.jnames = {'toe','ank','kne','hip'};

out.cmxp = gradient(out.cmx,dt);
out.cmyp = gradient(out.cmy,dt);
out.height=out.cmy(end)+0.5/9.81*out.cmyp(end)^2;
out.height_s = 1.09;
out.stimOnset = zeros(nmus,1);
for i =1:nmus
    tempStim=out.stim(:,i);
    out.stimOnset(i) = find(diff(tempStim)~=0)*dt;
end;