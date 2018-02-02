clc; clear;
%rat_1and2 = [];
rat_2andInf = [];
cond_p1 = [];
m_min = 100; step_sz = 40; m_max = 4100;
for m = m_min:step_sz:m_max
    mu = 0;
    sigma = sqrt(m);
    A = normrnd(mu, sigma, m, m);
    
    %norm_p1 = norm(A,1);
    norm_p2 = norm(A,2);
    norm_pInf = norm(A,Inf);
    %rat_1and2 = [rat_1and2, norm_p1/norm_p2];
    rat_2andInf = [rat_2andInf, norm_p2/norm_pInf];
    
    cond_p1 = [cond_p1, cond(A,1)];
end

%fileID = fopen('p4_1.txt','w');
%fprintf(fileID, '%f,%f\n', [rat_2andInf; cond_p1]);
%fclose(fileID);

x = m_min:step_sz:m_max;
y = {rat_2andInf cond_p1};
ylabels = {'2-norm/Inf-norm ratio', '1-norm Condition Number'};
fignames = {'2-norm_Inf-norm', '1-norm_Condition_Number'};
P4Plot(x, y, ylabels, fignames);

clc; clear;
rat_2andInf = []; cond_p1 = [];
m_min = 100; step_sz = 100; m_max = 800;
for m = m_min:step_sz:m_max
    mu = 0;
    sigma = sqrt(m);
    
    rat_2andInf_temp = []; cond_p1_temp = [];
    for k = 1:1:100
        A = normrnd(mu, sigma, m, m);
        norm_p2 = norm(A,2);
        norm_pInf = norm(A,Inf);
        rat_2andInf_temp = [rat_2andInf_temp, norm_p2/norm_pInf];
        cond_p1_temp = [cond_p1_temp, cond(A,1)];
    end
    rat_2andInf = [rat_2andInf, mean(rat_2andInf_temp)];
    cond_p1 = [cond_p1, mean(cond_p1_temp)];
end

%fileID = fopen('p4_2.txt','w');
%fprintf(fileID, '%f,%f\n', [rat_2andInf; cond_p1]);
%fclose(fileID);

x = m_min:step_sz:m_max;
y = {rat_2andInf cond_p1};
ylabels = {'2-norm/Inf-norm ratio', '1-norm Condition Number'};
fignames = {'2-norm_Inf-norm_avg', '1-norm_Condition_Number_avg'};
P4Plot(x, y, ylabels, fignames);