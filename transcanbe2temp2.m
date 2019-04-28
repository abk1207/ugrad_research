clc

name = 'f54coutput';

% number of J=2 states transitioned between
num0j = 15;
num2j = 15;


f = fopen(strcat(name,'02e2.txt'));
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
zero2two = reshape(s,num0j,num2j);
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
two2two = reshape(s,num2j,num2j);
fclose all;


f = fopen(strcat(name,'22e2mom.txt'));
s = [];
while 1
    l = fgetl(f);
    if ~ischar(l)
        break
    elseif length(l)>7;
        if all(l(1:7)==' l eff ')
            l(1:7) = [];
            l = str2num(l);
            if ~l(4)==0
                s = [s;l];
            end
        end
    end
end
s = s(:,4);
quads2j = s;
fclose all;







f = fopen(strcat(name(1:4),'00.lpe'));
fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f);
ground = str2num(fgetl(f));
ground = ground(1);

f = fopen(strcat(name(1:4),'04.lpe'));
fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f);
c = fgetl(f);
j2eng = [];
while 1
    if isempty(c)
        break;
    end
    g = fgetl(f);
    if isempty(g)
        break
    end
    j2eng = [j2eng;str2num(g)];
end
fclose('all');

j2eng = j2eng(:,1)-ground;

f = fopen(strcat(name(1:4),'00.lpe'));
fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f);
c = fgetl(f);
j0eng = [];
while 1
    if isempty(c)
        break;
    end
    g = fgetl(f);
    if isempty(g)
        break
    end
    j0eng = [j0eng;str2num(g)];
end
fclose('all');

j0eng = j0eng(:,1)-ground;

j0data = [j0eng';zeros(1,num0j)];
j2data = [j2eng,quads2j];

final02 = [zeros(2,2),j0data;
          j2data,zero2two];
final22 = [zeros(2,2),j2data';
          j2data,two2two];

xlswrite(strcat(name,'02.xlsx'),final02)
xlswrite(strcat(name,'22.xlsx'),final22)