clc
% clear all

tol = 0.0005;
pref = 'f5';

J = '0';
J2 = '0';

numorb = 4;
fullspec = false;

error = 0;
errmat = [];

t0 = [];
t1 = [];
t2 = [];
t3 = [];
t4 = [];


% Get Ground
f = fopen(strcat(pref,'4800.lpe'));
fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f);
ground = str2num(fgetl(f));
ground = ground(1);


% Read matrices from file
f = fopen(strcat(pref,'480',J2,'.lpe'));
fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f);
c = fgetl(f);
while 1
    if isempty(c)
        break;
    end
    g = fgetl(f);
    if isempty(g)
        break
    end
    t0 = [t0;str2num(g)];
end
fclose('all');

f = fopen(strcat(pref,'380',J2,'.lpe'));
fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f);
c = fgetl(f);
while 1
    if isempty(c)
        break;
    end
    g = fgetl(f);
    if isempty(g)
        break
    end
    t1 = [t1;str2num(g)];
end
fclose('all');

f = fopen(strcat(pref,'280',J2,'.lpe'));
fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f);
c = fgetl(f);
while 1
    if isempty(c)
        break;
    end
    g = fgetl(f);
    if isempty(g)
        break
    end
    t2 = [t2;str2num(g)];
end
fclose('all');

f = fopen(strcat(pref,'180',J2,'.lpe'));
fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f);
c = fgetl(f);
while 1
    if isempty(c)
        break;
    end
    g = fgetl(f);
    if isempty(g)
        break
    end
    t3 = [t3;str2num(g)];
end
fclose('all');

f = fopen(strcat(pref,'080',J2,'.lpe'));
fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f); fgetl(f);
c = fgetl(f);
while 1
    if isempty(c)
        break;
    end
    g = fgetl(f);
    if isempty(g)
        break
    end
    t4 = [t3;str2num(g)];
end
fclose('all');

fprintf('read done\n')

% Clean up matrices
hs = max(t0(:,1));

if ~isempty(t0)
    t0(:,2:4) = [];
    t0(:,2:numorb+1) = t0(:,2:numorb+1) + t0(:,numorb+2:2*numorb+1);
    t0(:,numorb+2:2*numorb+1) = [];
    t0 = [t0 zeros(size(t0,1),1)];
end
if ~isempty(t1)
    if ~fullspec
        t1(find(t1(:,1)>(hs+tol),1):size(t1,1),:) = [];
    end
    t1(:,2:4) = [];
    t1(:,2:numorb+1) = t1(:,2:numorb+1) + t1(:,numorb+2:2*numorb+1);
    t1(:,numorb+2:2*numorb+1) = [];
    t1 = [t1 ones(size(t1,1),1)];
end
if ~isempty(t2)
    if ~fullspec
        t2(find(t2(:,1)>(hs+tol),1):size(t2,1),:) = [];
    end
    t2(:,2:4) = [];
    t2(:,2:numorb+1) = t2(:,2:numorb+1) + t2(:,numorb+2:2*numorb+1);
    t2(:,numorb+2:2*numorb+1) = [];
    t2 = [t2 2*ones(size(t2,1),1)];
end
if ~isempty(t3)
    if ~fullspec
        t3(find(t3(:,1)>(hs+tol),1):size(t3,1),:) = [];
    end
    t3(:,2:4) = [];
    t3(:,2:numorb+1) = t3(:,2:numorb+1) + t3(:,numorb+2:2*numorb+1);
    t3(:,numorb+2:2*numorb+1) = [];
    t3 = [t3 3*ones(size(t3,1),1)];
end
if ~isempty(t4)
    if ~fullspec
        t4(find(t4(:,1)>(hs+tol),1):size(t4,1),:) = [];
    end
    t4(:,2:4) = [];
    t4(:,2:numorb+1) = t4(:,2:numorb+1) + t4(:,numorb+2:2*numorb+1);
    t4(:,numorb+2:2*numorb+1) = [];
    t4 = [t4 4*ones(size(t4,1),1)];
end

fprintf('clean done\n')


% Remove extra states
if ~isempty(t1)
    I = [];
    for i = 1:size(t1,1)
        t1si = repmat(t1(i,1:numorb+1),size(t0,1),1);
        diff = abs(sum(t0(:,1:numorb+1)-t1si,2));
        if ~any(diff<=numorb+1*tol)
            I= [I;i];
        end
    end
    if ~isempty(I);
        for m = 1:length(I)
            errmat = [errmat; t1(I(m),1) 1];
        end
        error = error+length(I);
    end
    t1(I,:) = [];
end

if ~isempty(t2)
    I = [];
    for i = 1:size(t2,1)
        t2si = repmat(t2(i,1:numorb+1),size(t1,1),1);
        diff = abs(sum(t1(:,1:numorb+1)-t2si,2));
        if ~any(diff<=numorb+1*tol)
            I= [I;i];
        end
    end
    if ~isempty(I);
        for m = 1:length(I)
            errmat = [errmat; t2(I(m),1) 1];
        end
        error = error+length(I);
    end
    t2(I,:) = [];
end

if ~isempty(t3)
    I = [];
    for i = 1:size(t3,1)
        t3si = repmat(t3(i,1:numorb+1),size(t2,1),1);
        diff = abs(sum(t2(:,1:numorb+1)-t3si,2));
        if ~any(diff<=numorb+1*tol)
            I= [I;i];
        end
    end
    if ~isempty(I);
        for m = 1:length(I)
            errmat = [errmat; t3(I(m),1) 1];
        end
        error = error+length(I);
    end
    t3(I,:) = [];
end

if ~isempty(t4)
    I = [];
    for i = 1:size(t4,1)
        t4si = repmat(t4(i,1:numorb+1),size(t3,1),1);
        diff = abs(sum(t3(:,1:numorb+1)-t4si,2));
        if ~any(diff<=numorb+1*tol)
            I= [I;i];
        end
    end
    if ~isempty(I);
        for m = 1:length(I)
            errmat = [errmat; t4(I(m),1) 1];
        end
        error = error+length(I);
    end
    t4(I,:) = [];
end

fprintf('remove done\n')


% Sort states
if ~isempty(t4)
    for i = 1:size(t4,1)
        t4si = repmat(t4(i,1:numorb+1),size(t3,1),1);
        diff = abs(sum(t3(:,1:numorb+1)-t4si,2));
        while 1
            [si, pi] = min(diff);
            if t3(pi,numorb+2)==3
                break
            else
                diff(pi)=max(diff)+1;
            end
        end
        t3(pi,numorb+2) = t4(i,numorb+2);
    end
end

fprintf('t4 done\n')

if ~isempty(t3)
    for i = 1:size(t3,1)
        t3si = repmat(t3(i,1:numorb+1),size(t2,1),1);
        diff = abs(sum(t2(:,1:numorb+1)-t3si,2));
        while 1
            [si, pi] = min(diff);
            if t2(pi,numorb+2)==2
                break
            else
                diff(pi)=max(diff)+1;
            end
        end
        [si, pi] = min(diff);
        t2(pi,numorb+2) = t3(i,numorb+2);
    end
end

fprintf('t3 done\n')

if ~isempty(t2)
    for i = 1:size(t2,1)
        t2si = repmat(t2(i,1:numorb+1),size(t1,1),1);
        diff = abs(sum(t1(:,1:numorb+1)-t2si,2));
        while 1
            [si, pi] = min(diff);
            if t1(pi,numorb+2)==1
                break
            else
                diff(pi)=max(diff)+1;
            end
        end
        [si, pi] = min(diff);
        t1(pi,numorb+2) = t2(i,numorb+2);
    end
end

fprintf('t2 done\n')

if ~isempty(t1)
    for i = 1:size(t1,1)
        t2si = repmat(t1(i,1:numorb+1),size(t0,1),1);
        diff = abs(sum(t0(:,1:numorb+1)-t1si,2));
        while 1
            [si, pi] = min(diff);
            if t0(pi,numorb+2)==0
                break
            else
                diff(pi)=max(diff)+1;
            end
        end
        [si, pi] = min(diff);
        t0(pi,numorb+2) = t1(i,numorb+2);
    end
end

fprintf('t1 done\n')

S = t0;

if ~isempty(S)
    S(:,2:numorb+1) = [];
    S(:,1) = S(:,1)-ground;
    fprintf('sort done\n')

    % Wrtie to excel
    name = strcat('I=',J,'.xlsx');
    xlswrite(name,S);
    fprintf('write done\n')

    % Print Errors
    if ~isempty(errmat)
        f = fopen(strcat('I=',J,' errors.txt'),'wt');
        fprintf(f,'Number of errors: %.0f\n\n',error);
        for i = 1:size(errmat,1)
            fprintf(f,'%.4f  %.0f\n', errmat(i));
        end
    end
    fclose('all');
    fprintf('errors done\n')
else
    fprintf('NO STATES - NO STATES - NO STATES - NO STATES\n')
end

if ~isempty(errmat)
    fprintf('ERROR - ERROR\nERROR - ERROR\nERROR - ERROR\nERROR - ERROR\nERROR - ERROR\nERROR - ERROR\nERROR - ERROR\n')
    errmat
end