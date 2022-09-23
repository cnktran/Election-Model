function [f, p] = election_model(votes, previous_poll, Q) %outputs votes from this round (f) and poll from last round (p)
s = size(votes);
%M is the number of candidates
M = s(2);
%N is the population size
N = sum(votes);

%Take poll, where probability of picking a certain candidate is the true
%percentage of voters that support them
sample_size = round(.005 * N); %.5 percent of voters are polled (1/200)
true_points = votes/(sum(votes)); %true percentage of voters that support each candidate
x = 1:M;
p_votes = randsrc(1,sample_size,[x;true_points]);
p = (hist(p_votes,x))/sample_size; %poll yields percentages rather than raw numbers of votes
[top_points, top_candidate] = max(p);

%Change in points from the previous poll 
poll_delta = p - previous_poll;
sorted_poll = sort(p);

%Calculate new transition probabilities based on poll
T = zeros(M);
for r = 1:M
    %for top candidates who have a 5 point lead or greater
    if (r == top_candidate) && (sorted_poll(M) - sorted_poll(M - 1) > .05)
        %set staying probability to be 0.9, calculate the rest based off
        %of Candidate c's traction and simliarity
        for c = 1:M
            if r ~= c
                if poll_delta(c) > 0
                    traction = 1 + poll_delta(c);
                else
                    traction = 1;
                end
                if poll_delta(c) - poll_delta(r) >= 0 %if other candidate has more momentum than leading candidate 
                    %where 0.1 is the "remaining" probability so to speak
                    T(r,c) = 0.1 * traction * Q(r,c);
                else
                    T(r,c) = 0.1 * 0.1 * traction * Q(r,c);
                end
            else
                T(r,c) = 0.9;
            end
        end
    else
        %for candidates not in the lead, use a weighted disparity to
        %calculate probability of staying and calculate the rest of the
        %probabilities based on traction and similarity
        disp = 0.3 * (top_points - p(r));
        for c = 1:M
            if r ~= c
                if poll_delta(c) > 0
                    traction = 1 + poll_delta(c);
                else
                    traction = 1;
                end
                if p(c) - p(r) >= 0
                    T(r,c) = (1 - 0.85 + disp) * traction * Q(r,c);
                else
                    T(r,c) = (1 - 0.85 + disp) * 0.5 * traction * Q(r,c);
                end
            else
                T(r,c) = 0.85 - disp;
            end
        end
    end
end

%If a candidate drops below 1 point then they drop out (using true number
%of votes because a candidate would not drop out because of 1 bad poll)
%for c = 1:M
%    if votes(c) < (0.01 * N)
%        T(:,c) = 0;
%    end
%end

%Normalizing T into S so that rows sum to 1.
S = zeros(M);
for i = 1:M
    S(i,:) = T(i,:)/sum(T(i,:));
end    

%Multiply current votes by S to get votes for next round
f = round(votes * S);

end
