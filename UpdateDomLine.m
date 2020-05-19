function UpdateDomLine(totalVol, key, bidQueue, bidExec, askExec, askQueue, paus, bidVol, askVol)
%
%   totalVol, key, bidQueue, bidExec, askExec, askQueue, paus, bidVol, askVol
%

    global executionDom  
    global execBidDomVect execAskDomVect    
    global totalVolCol relBidQueueCol bidQueueCol bidExecCol 
    global askExecCol askQueueCol relAskQueueCol bidVolCol askVolCol
    global firstLineExecDom lastLineExecDom
    
try
    
    row = AddFindRowInDom(key, paus);
    
    if totalVol(1)~=0
        executionDom(row, totalVolCol)      = UpdateDLItem(executionDom(row, totalVolCol), totalVol(1), totalVol(2)); 
    end
    
    if bidQueue(1)~=0 
        % lastLineExecDom is 0      => UpdateQueue will reference last line
        execBidDomVect = UpdateQueue(row, bidQueue, paus, lastLineExecDom, relBidQueueCol, bidQueueCol, execBidDomVect, true);
    end
    
    if bidExec(1)~=0
        executionDom(row, bidExecCol)       = UpdateDLItem(executionDom(row, bidExecCol), bidExec(1), bidExec(2)); 
    end
    
    if askExec(1)~=0
        executionDom(row, askExecCol)       = UpdateDLItem(executionDom(row, askExecCol), askExec(1), askExec(2)); 
    end
    
    if askQueue(1)~=0
        % firstLineExecDom = 1 Mil => UpdateQueue will reference first line
        execAskDomVect = UpdateQueue(row, askQueue, paus, firstLineExecDom, relAskQueueCol, askQueueCol, execAskDomVect, false);
    end
    
    if bidVol(1)~=0
        executionDom(row, bidVolCol)        = UpdateDLItem(executionDom(row, bidVolCol), bidVol(1), bidVol(2));
    end
    
    if askVol(1)~=0
        executionDom(row, askVolCol)        = UpdateDLItem(executionDom(row, askVolCol), askVol(1), askVol(2));
    end
    
catch ME
    disp(ME.getReport);
    rethrow(ME);
end        
end

