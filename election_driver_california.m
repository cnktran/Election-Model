%CALIFORNIA
%Population = 8600 (8.6 mil Dems in CA, 1 = 1,000)
%Candidates: San, Bid, War, Bloom, But, Klo, Stey, Gab
votes = [2100, 2900, 2400, 200, 600, 200, 100, 100];
pp_initial = (votes/sum(votes)); %so that first poll_delta is solely based on randomness of first poll

%Similarity
Q = [1, 0.4, 0.4, 0.1, 0.2, 0.1, 0.1, 0.1;
    0.4, 1, 0.3, 0.2, 0.2, 0.1, 0.1, 0.1;
    0.4, 0.3, 1, 0.1, 0.5, 0.1, 0.1, 0.1;
    0.1, 0.2, 0.1, 1, 0.1, 0.1, 0.1, 0.1;
    0.2, 0.2, 0.5, 0.1, 1, 0.1, 0.1, 0.1;
    0.1, 0.1, 0.1, 0.1, 0.1, 1, 0.1, 0.1;
    0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 1, 0.1;
    0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 1];

%Number of times to collect poll/ voter data and update transition matrix 
polls = 20;
%5 polls tends to produce a pretty reasonable result for like ~primary time
%The longer it goes, the more convergence we see, usually done-ish in like
%20 polls or so

%Initialize matrix to keep track of votes
vote_table = votes;

%Perform 
[v,p] = election_model(votes, pp_initial, Q);

for i = 1:polls
    vote_table = [vote_table; v];
    [v,p] = election_model(v, p, Q);
end 
results = round(vote_table((polls + 1), :)/(sum(votes)) * 100)

%Print out table
vote_table
%Print out final percentages
results

figure
plot((vote_table/8600))
%xline(20, '--r', {'Primary','Election'})
xlabel('Number of Polls')
ylabel('Percent of Vote')
legend('Sanders','Biden','Warren','Bloomberg','Buttigieg','Klobuchar','Steyer','Gabbard', 'Location', 'bestoutside')