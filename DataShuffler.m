data=importdata('Dataset3.data');
TotalNo=size(data,1);
data=data(randperm(TotalNo),:);
fID=fopen('Shuffeled_Dataset3.data','w');
for i=1:TotalNo
fprintf(fID,'%.1f %.1f %.0f\n',[data(i,1),data(i,2),data(i,3)]);
end
fclose(fID);
