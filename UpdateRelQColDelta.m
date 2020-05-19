function UpdateRelQColDelta(isBid, relQueueCol, firstLastRow)
%UpdateRelQueueColDelta Summary of this function goes here
%   
%   updates first&last row col 1, which is a delta of relQueueColumn,
%   tracking essentially what's the total delta on bid pulls or ask pulls
%   on all available order book levels.
%
%   GenerateOrders creates orders towards direction where order pull
%   happens above a trigger queueWithdraws, with a pointsProfitTarg profit target
%
%

    % 0     = leave unchanged
    % 1     = add to existing value
    % -1    = substract new from existing value
    % 2     = replace
    % -2    = substract existing from new value
    
    global executionDom queueWithdraws
try
    sumOfRelatives = sum(executionDom(2:end-1, relQueueCol),'omitnan');
    if sumOfRelatives ~= executionDom(firstLastRow, relQueueCol)
        executionDom(firstLastRow, 1)       = UpdateDLItem(executionDom(firstLastRow, relQueueCol), -2, sumOfRelatives);
        %execDomVect = [execDomVect; executionDom(firstLastRow, 1)];
        currentDelta = executionDom(firstLastRow, 1);
        
        if currentDelta >= queueWithdraws
            disp(strcat('In UpdateRelQColDelta; PrevDelta =',num2str(executionDom(firstLastRow, relQueueCol)),'; sumOfRelatives = ',num2str(sumOfRelatives),'; currentValue = ',num2str(currentDelta),'; queueWithdraws = ', num2str(queueWithdraws),'; Generating order for isBid = ', num2str(isBid), '; firstLastRow = ',num2str(firstLastRow)));
            GenerateOrders(isBid);
        else
            %disp(strcat('In UpdateRelQColDelta; currentValue = ',num2str(currentDelta),'; queueWithdraws = ', num2str(queueWithdraws),'; No order generation for isBid = ', num2str(isBid)));
        end
    end
    
    executionDom(firstLastRow, relQueueCol) = UpdateDLItem(0, 2, sumOfRelatives);    
    
catch ME
    disp(ME.message);
    rethrow(ME);
end     
end

