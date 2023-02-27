% input
width = 592; % from single mode

%name  = 'single mode';
%name  = 'double modes';
name  = 'triple modes';
%file  = '5th-st_pseudo_1_mode.txt';
%file  = '5th-st_2_modes.txt';
file  = '5th-st_3_modes.txt';

% read file
fid       = fopen(file,'r');
format    = '%f %f';
sizeftn58 = [1 Inf];
data      = fscanf(fid,format,sizeftn58);
data      = data - min(data);

hold on
npts      = length(data);
%freq      = (1:npts);
freq      = (1.5/width)*(1:npts);

figure()
hold on
%plot(freq,data,'b-o')
findpeaks(data,freq,'Annotate','extents','WidthReference','halfheight')
xlabel('Relative Frequency (GHz)','FontSize',36);
ylabel('Intensity (mV)','FontSize',36);
title(['Confocal Interferometer Spectrum (',name,')'],'FontSize',36)
ax = gca;
ax.FontSize = 36;
axis([freq(1),freq(end),-Inf,Inf])
