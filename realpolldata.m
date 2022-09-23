rpd = [18, 28, 13, 3, 8, 1, 3, 2;
       24, 14, 22, 2, 12, 3, 1, 1;
       20, 21, 17, 5, 9, 2, 1, 2;
       26, 19, 23, 3, 12, 1, 2, 3;
       27, 24, 23, 1, 6, 4, 2, 3;
       20, 30, 20, 6, 8, 2, 4, 2;
       26, 15, 20, 6, 7, 5, 2, 2;
       30, 15, 16, 4, 8, 3, 2, 4;
       29, 21, 20, 8, 6, 3, 2, 2;
       32, 14, 13, 12, 12, 5, 3, 1;
       25, 15, 9, 21, 12, 6, 3, 1;
       24, 13, 16, 12, 12, 7, 2, 4;
       24, 17, 10, 13, 9, 4, 5, 2;
       37, 12, 20, 6, 11, 15, 3, 2;
       34, 8, 17, 12, 11, 6, 2, 2;
       35, 13, 14, 12, 7, 6, 3, 1;
       28, 19, 18, 13, 9, 6, 4, 3;
       35, 14, 12, 16, 7, 5, 3, 3;
       31, 19, 18, 12, 9, 4, 3, 1;
       38, 21, 16, 11, 7, 5, 2, 1;
       32, 25, 16, 17, 5, 3, 2, 2;
       33.8, 25.1, 12.2, 14.1, 6.2, 3.1, 2.6, 0.7];
for r = 1:22
    s = sum (rpd(r,:));
    rpd(r,:) = (rpd(r,:)) / s;
end
plot(rpd)
xlabel('Number of Polls')
ylabel('Percent of Vote')
legend('Sanders','Biden','Warren','Bloomberg','Buttigieg','Klobuchar','Steyer','Gabbard', 'Location', 'bestoutside')