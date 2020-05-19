function execDomVect = UpdateQueue(row, theQueue, paus, lineExecDom, relQueueCol, queueCol, execDomVect, isBid)
%UpdateQueue Summary of this function goes here
%   Detailed explanation goes here
    %
    %
    %

    global executionDom 
try    
    % being called only from UpdateDomLine; lineExecDom can be 1 Mil or 0
    firstLastRow = AddFindRowInDom(lineExecDom, paus); % either first or last row
    
    executionDom(row, relQueueCol)          = UpdateDLItem(executionDom(row, queueCol), -2, theQueue(2));
    
    UpdateRelQColDelta(isBid, relQueueCol, firstLastRow);
    
    executionDom(row, queueCol)             = UpdateDLItem(executionDom(row, queueCol), theQueue(1), theQueue(2)); 
    
    executionDom(firstLastRow, queueCol)    = UpdateDLItem(0, 2, sum(executionDom(2:end-1, queueCol),'omitnan'));    
    
catch ME
    disp(ME.getReport);
    rethrow(ME);
end     
end