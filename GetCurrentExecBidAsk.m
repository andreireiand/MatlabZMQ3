function [strPrice, price] = GetCurrentExecBidAsk(isBid)
%GetCurrentExecBidAsk 
%
%
    global executionDom

try    
    %index = 0;
    
    if isBid
        temp = find(~isnan(executionDom(2:end-1,4)) == 1);
        index = temp(1) + 1;
    else
        temp = find(~isnan(executionDom(2:end-1,7)) == 1);
        index = temp(end) + 1;
    end
    
    price    = executionDom(index, 2);
    strPrice = num2str(price);
    
catch ME
    disp(ME.getReport);
    rethrow(ME);
end      
end

