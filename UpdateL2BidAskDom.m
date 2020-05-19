function UpdateL2BidAskDom(key, volSize, isBid)
%
%
%
%global totalVolCol priceCol relBidQueueCol bidQueueCol bidExecCol 
%global askExecCol askQueueCol relAskQueueCol pauseCol bidVolCol askVolCol

% totalVol, key, bidQueue, bidExec, askExec, askQueue, paus, bidVol, askVol

% [2 x] => 2 here represents replace existing value with x

try    
    if isBid
        if volSize == 0 
            UpdateDomLine(0, key, [2 nan], 0, 0, 0, nan, 0, 0);
        else
            UpdateDomLine(0, key, [2 volSize], 0, 0, [2 nan], nan, 0, 0);
        end
    else
        if volSize == 0 
            UpdateDomLine(0, key, 0, 0, 0, [2 nan], nan, 0, 0);
        else
            UpdateDomLine(0, key, [2 nan], 0, 0, [2 volSize], nan, 0, 0);
        end
    end
catch ME
    disp(ME.getReport);
    rethrow(ME);
end        
end

