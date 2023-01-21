% input
bg = 0;

% read file
fid       = fopen('1d.txt','r');
format    = '%f %f';
sizeftn58 = [2 Inf];
ftn58     = fscanf(fid,format,sizeftn58);
order     = ftn58(1,:);
data      = ftn58(2,:);

hold on

% subtracting baseline then normalization
data      = data - bg;
order_big = interpn(order);
do        = diff([order_big(1),order_big(2:2:end),order_big(end)]);
area      = sum(data.*do);
data      = data/area;

% find centroid
for i=2:length(order) 
    order_bigc = interpn(order(1:i));
    doc        = diff([order_bigc(1),order_bigc(2:2:end),order_bigc(end)]);
    centroid_area = sum(data(1:i).*doc);
    if centroid_area >= 1/2
        centroid = i;
        break
    end
end

plot(order,data,'b-o')
xline(centroid,'r:',num2str(centroid),'FontSize',36,'LineWidth',4)
text(0.2*max(order),0.9*max(data),['area = ',num2str(area)],'FontSize',36);

title('normalized data in 1d.txt w/ BG=0','FontSize',36)
legend({'data','centroid'},'FontSize',36)
ax = gca;
ax.FontSize = 36;

fid = fopen('1d_st.txt','w');
for ii = 1:length(order)
    fprintf(fid,"%9f\t%9f\n",order(ii),data(ii));
end
fclose(fid);