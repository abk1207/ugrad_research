clc

name = 'fy240';
jsym = 'o';

f = fopen(strcat(name,'0.lpe'));
fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f);
g = fgetl(f)
g = str2num(g)
g = g(1)
fclose('all');

j2 = [];
f = fopen(strcat(name,jsym,'.lpe'));
fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f);
while 1
    line = fgetl(f);
    if isempty(line)
        break
    end
    j2 = [j2;str2num(line)];
end
j2 = j2(:,1);
fclose('all');

j2 = j2-g;

clc
words = {};
for i = 1:length(j2)
    words{i} = strcat(num2str(j2(i)),' MeV');
end

% xlswrite(strcat(name,jsym,'.xlsx'), words')
xlswrite(strcat(name,jsym,'.xlsx'), j2)

% xlswrite(strcat(name,'.xlsx'), words, 'B1:G1')
% xlswrite(strcat(name,'.xlsx'), words', 'A3:A8')