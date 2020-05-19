function UpdateL1BidAskDom(key, volSize, updateType)
%
%
%
% UpdateDomLine takes as params:
% totalVol, key, bidQueue, bidExec, askExec, askQueue, paus, bidVol, askVol

% let's replace bid or ask levels w/ new received values (resulted from
% trades or from sitting limit orders being updated


try    
    if updateType == 1      % is Bid update
        UpdateDomLine(0, key, [2 volSize], 0, 0, [2 nan], nan, 0, 0); % 2 is defined in UpdateDLItem, its meaning is replace; volSize = new size value (size of volume)
        %UpdateDomLine(0, lastLineExecDom, 3, 0, 0, 0, nan, 0, 0);       % 3 is vertical sum
    elseif updateType == -1 % is Ask update
        UpdateDomLine(0, key, [2 nan], 0, 0, [2 volSize], nan, 0, 0); % 2 is defined in UpdateDLItem, its meaning is replace
        %UpdateDomLine(0, firstLineExecDom, 0, 0, 0, 3, nan, 0, 0);       % 3 is vertical sum
    end
    
catch ME
    disp(ME.message);
    rethrow(ME);
end        
end

