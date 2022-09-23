%%

%Initialize results table
results_table = [];

%Initialize poll table for each replication (saves memory to initialize
%outside for lop)
poll_table = zeros(8,23);

%Initialize counters for winners
sanders = 0;
biden = 0;
warren = 0;
bloom = 0;
butt = 0;  %lol
klo = 0;
stey = 0;
gab = 0;

%Initialize arrays for result tables (top 2)
SB = {};
SW = {};
BS = {};
BW = {};
WS = {};
WB = {};
OTHER_C2 = {};
OTHER2 = {};



for i = 1:10000
%CALIFORNIA
Pop = 5800; %(5.8 mil people voted in CA dem primary, 1 = 1,000)
%Candidates: San, Bid, War, Bloom, But, Klo, Stey, Gab

%Calculate 
x = 1:8;
initial_poll = [20, 21, 17, 5, 9, 2, 1, 2];
ip_percents = initial_poll/sum(initial_poll); %don't account for undecided/ unpopular candidates
votes_sim = randsrc(1, Pop,[x; ip_percents]);
votes = hist(votes_sim, x);

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
polls = 21 ; %on RCP there are 21 polls between Bloomberg entry and election day

%Perform 
[v,p] = election_model(votes, pp_initial, Q);

%Initialize matrix to keep track of polls
poll_table = [p];


for i = 1:polls
    poll_table = [poll_table; p];
    [v,p] = election_model(v, p, Q);
end

results = v / sum(v);
results_table = [results_table; results];

[top_votes, top_cand] = max(results);
if top_cand == 1
    sanders = sanders + 1;
elseif top_cand == 2
    biden = biden + 1;
elseif top_cand == 3
    warren = warren + 1;
elseif top_cand == 4
    bloom = bloom + 1;
elseif top_cand == 5
    butt = butt + 1;
elseif top_cand == 6
    klo = klo + 1;
elseif top_cand == 7
    stey = stey + 1;
else
    gabbard = gabbard + 1;
end

%Add final result to end of poll table for graphing
poll_table = [poll_table; results];

[top_votes, winner] = max(results);

order = top_two_order(results);

if order == "Sanders, Biden";
    SB{end + 1} = poll_table;
elseif order == "Sanders, Warren";
    SW{end + 1} = poll_table;
elseif order == "Biden, Sanders";
    BS{end + 1} = poll_table;
elseif order == "Biden, Warren";
    BW{end + 1} = poll_table;
elseif order == "Warren, Sanders";
    WS{end + 1} = poll_table;
elseif order == "Warren, Biden";
    WB{end + 1} = poll_table;
elseif order == "Other candidate in top 2";
    OTHER_C2{end + 1} = poll_table;
else
    OTHER2{end + 1} = poll_table;
end
end


%% GRAPHING

% %Sanders Biden
% 
% s = size(SB);
% 
% avg = zeros(polls + 2, 8);
% 
% for i = 1:s(2)
%     avg = avg + SB{i};
% end
% 
% avg = avg/s(2);
% 
% plot(avg)

% Warren Biden

s = size(WB);

avg = zeros(polls + 2, 8);

for i = 1:s(2)
    avg = avg + WB{i};
end

avg = avg/s(2);

plot(avg)
