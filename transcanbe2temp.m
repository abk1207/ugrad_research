clc

name = 'sy24output';
% number of J=2 states transitioned between
num0j = 15
num2j = 15;


f = fopen(strcat(name,'20e2.txt'));
s = [];
while 1
    l = fgetl(f);
    if ~ischar(l)
        break
    elseif length(l)>7;
        if all(l(1:7)==' l eff ')
            l(1:7) = [];
            s = [s;str2num(l)];
        end
    end
end
s = s(:,5);
m1 = reshape(s,1,num2j);
fclose all;


f = fopen(strcat(name,'22e2.txt'));
s = [];
while 1
    l = fgetl(f);
    if ~ischar(l)
        break
    elseif length(l)>7;
        if all(l(1:7)==' l eff ')
            l(1:7) = [];
            s = [s;str2num(l)];
        end
    end
end
s = s(:,5);
m1 = [m1;reshape(s,num2j,num2j)];
fclose all;


f = fopen(strcat(name,'22m1.txt'));
s = [];
while 1
    l = fgetl(f);
    if ~ischar(l)
        break
    elseif length(l)>7;
        if all(l(1:7)==' total ')
            l(1:7) = [];
            s = [s;str2num(l)];
        end
    end
end
s = s(:,4);
m1 = [m1;s'];
fclose all;


f = fopen(strcat(name,'22e2.txt'));
s = [];
while 1
    l = fgetl(f);
    if ~ischar(l)
        break
    elseif length(l)>7;
        if all(l(1:7)==' l bare')
            l(1:7) = [];
            l = str2num(l);
            if ~l(4)==0
                s = [s;l];
            end
        end
    end
end
s = s(:,4);
m1 = [m1;s']
fclose all;

xlswrite(strcat(name,'.xlsx'),m1)