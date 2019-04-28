clc

pn = '24';
nucleons = '44';
protons = '22';
core = '40';

fromj = '0';
toj = '2';

from2j = '0';
to2j = '4';

type = 'e2';
lpelabel = 'f5';

fromstates = [1:10];
tostates = [1:10];


fileid = fopen(strcat(lpelabel,pn,'input',fromj,toj,type,'.txt.'), 'wt');

% fprintf(fileid,'cg\n0,0,0,0,0.0000000001,0,0,0,0\n');
% fprintf(fileid,'cg\n0,0,0.0000000001,0.0000000001,0,0,0,0,0\n');

fprintf(fileid,strcat('az\n',nucleons,',',protons,'\n'));

for i=fromstates
    for j=tostates
        fprintf(fileid,strcat('mh\n',type,',10\n',fromj,',',toj,'\n%.0f,%.0f,1,1,',core,',',lpelabel,pn,'0',from2j,'_',pn,'0',to2j,'\n'),i,j);
    end
end

fprintf(fileid,'ex\n');
fclose all;