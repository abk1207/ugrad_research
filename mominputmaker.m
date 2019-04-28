clc

jnum = '8';
jsym = 'g';

fromstates = [1:4];

pn = '24';
nucleons = '20';
protons = '10';
core = '16'

type = 'm1';
name = 's2';

fileid = fopen(strcat(name,pn,'input',jnum,jnum,type,'mom.txt.'), 'wt');

% fprintf(fileid,'cg\n0,0,0,0,0.0000000001,0,0,0,0\n');
% fprintf(fileid,'cg\n0,0,0.0000000001,0.0000000001,0,0,0,0,0\n');

fprintf(fileid,strcat('az\n',nucleons,',',protons,'\n'));

for i=fromstates
    fprintf(fileid,strcat('mh\n',type,',10\n',jnum,',',jnum,'\n%.0f,%.0f,1,1,',core,',',name,pn,'0',jsym,'_',pn,'0',jsym,'\n'),i,i);
end

fprintf(fileid,'ex\n');
fclose all;