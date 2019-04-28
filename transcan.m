clc

name = 'f524output02e2';
from = 10;
to = 10;
check = ' l eff '; %e2
% check = ' total '; %m1

f = fopen(strcat(name,'.txt'));
s = [];

while 1
    l = fgetl(f);
    i = i+1;
    if ~ischar(l)
        break
    elseif length(l)>7;
        if all(l(1:7)==check)
            l(1:7) = [];
            s = [s;str2num(l)];
        end
    end
end

s = s(:,5);
m1 = reshape(s,to,from)
% length(s)
fclose all;

xlswrite(strcat(name,'.xlsx'),m1)