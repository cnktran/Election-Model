function o = top_two_order(results)
[sorted, rankings] = sort(results, 'descend');

%Sanders wins
if rankings(1) == 1
    if (rankings(2) == 2)
        ord = "Sanders, Biden";
    elseif (rankings(2) == 3)
        ord = "Sanders, Warren";
    else
        ord = "Other candidate in top 2";
    end 
%Biden wins
elseif rankings(1) == 2
    if (rankings(2) == 1)
        ord = "Biden, Sanders";
    elseif (rankings(2) == 3)
        ord = "Biden, Warren";
    else
        ord = "Other candidate in top 2";
    end 

%Warren wins
elseif rankings(1) == 3
    if (rankings(2) == 1)
        ord = "Warren, Sanders";
    elseif (rankings(2) == 2)
        ord = "Warren, Biden";
    else
        ord = "Other candidate in top 2";
    end 


else
    ord = "Other Winner";
end

o = ord;

end

