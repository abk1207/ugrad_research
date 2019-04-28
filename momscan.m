clc

name = 's224output88m1mom';
numquads = 4;
% check = ' l eff '; %quad
check = ' total '; %mag WRONG WRONG CHECK

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

s = s(:,4);
m1 = reshape(s,numquads,1)
% length(s)
fclose all;

xlswrite(strcat(name,'.xlsx'),m1)