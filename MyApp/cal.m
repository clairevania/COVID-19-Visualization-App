%Calculate Cumulative Data
function [s, c] = cal()
covid_data = load('covid_data.mat');
s = [];
c = [];
a = covid_data;
b = a.covid_data;
[~,col]=size(b);
for i = 3:col
s = [s sum(cellfun(@(v)v(1),b(2:10,i)))+sum(cellfun(@(v)v(1),b(19:42,i)))+sum(cellfun(@(v)v(1),b(59:62,i)))+...
    sum(cellfun(@(v)v(1),b(96:106,i)))+sum(cellfun(@(v)v(1),b(109:112,i)))+sum(cellfun(@(v)v(1),b(134:195,i)))+...
    sum(cellfun(@(v)v(1),b(200:256,i))+sum(cellfun(@(v)v(1),b(267,i))))+sum(cellfun(@(v)v(1),b(324:end,i)))];
c = [c sum(cellfun(@(v)v(2),b(2:10,i)))+sum(cellfun(@(v)v(2),b(19:42,i)))+sum(cellfun(@(v)v(2),b(59:62,i)))+...
    sum(cellfun(@(v)v(2),b(96:106,i)))+sum(cellfun(@(v)v(2),b(109:112,i)))+sum(cellfun(@(v)v(2),b(134:195,i)))+...
    sum(cellfun(@(v)v(2),b(200:256,i))+sum(cellfun(@(v)v(2),b(267,i))))+sum(cellfun(@(v)v(2),b(324:end,i)))];
end

end