function ClosePosition(order)
% ClosePosition 
%

%   We execute a profit target entry: -1, 12, -1. 0, 0, 8  
%   OR, we execute a stop loss entry:     -1,  8, -1, 0, 0, 8
%
%   upon execution, B or C cancel each other

    global ordersOpen
try    
    % profit Target = 0; this means it's a position closing order
    % we execute a profit target or a stop loss and we cancel its counterparty
    assert(size(ordersOpen,1) >= 2); % check 2 entries exist: stopLoss and profitTarget
    stLoss = ordersOpen(order,6);
    positions = find(ordersOpen(:,6) == stLoss);
    assert(numel(positions) == 2);
    orderB = positions(positions ~= order);

    ordersOpen([order orderB],:) = []; 
        
 catch ME
    disp(ME.getReport);
    rethrow(ME);
end      
end

