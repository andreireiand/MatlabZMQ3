function UpdateExecutionDom(key, volSize, isBidHit)
%
%   if isBidHit = true, execution happened on a bid hit; else on an ask hit
%  
% global totalVolCol priceCol relBidQueueCol bidQueueCol bidExecCol 
% global askExecCol askQueueCol relAskQueueCol pauseCol bidVolCol askVolCol
global executionDom relBidQueueCol bidQueueCol relAskQueueCol askQueueCol

% totalVol, key, bidQueue, bidExec, askExec, askQueue, paus, bidVol, askVol

    % 0     = leave unchanged
    % 1     = add to existing value
    % -1    = substract new from existing value
    % 2     = replace
    % -2    = substract existing from new value
    
try
    if isBidHit
        %                totalVol, key, bidQueue, bidExec, askExec, askQueue, paus, bidVol, askVol
        %UpdateDomLine([1 volSize], key, 0,           0, [2 volSize], 0, nan, [1 volSize],           0);
        UpdateDomLine([1 volSize], key, 0, [2 volSize],           0, 0, nan,           0, [1 volSize]);
        % below is important for finding the bid/ask spread lines in GetCurrentExecBidAsk
        executionDom(1:AddFindRowInDom(key,nan)-1,[relBidQueueCol,bidQueueCol]) = nan; 
    else
        %UpdateDomLine([1 volSize], key, 0, [2 volSize],           0, 0, nan,           0, [1 volSize]);
        UpdateDomLine([1 volSize], key, 0,           0, [2 volSize], 0, nan, [1 volSize],           0);
        % below is important for finding the bid/ask spread lines in GetCurrentExecBidAsk
        executionDom(AddFindRowInDom(key,nan)+1:end,[relAskQueueCol,askQueueCol]) = nan;
    end
catch ME
    disp(ME.message);
    rethrow(ME);
end    
end

