function CloseOrder(order, executionPrice)
%CloseOrders 
%
%   this is called from UpdateOrders with orders that HAVE to be closed

    global ordersOpen ordersExecuted
    
try
    stLoss = ordersOpen(order,6);
    disp(strcat('In CloseOrders: closing orders__',num2str(order),'_for_price:',num2str(executionPrice),';_ordersOpen_:',num2str(ordersOpen),';_stLoss(never-zero)_:', num2str(stLoss)));
    assert(stLoss ~= 0); % every ever open order should have a stopLoss    
    
    ordersOpen(order,2) = executionPrice;
    if isempty(ordersExecuted)
        ordersExecuted = ordersOpen(order,1:2);
        ordersExecuted(3) = 0;
    else
        ordersExecuted = [ordersExecuted; ...
            ordersOpen(order,1) + ordersExecuted(end,1) ...
            ordersOpen(order,2) ...
            ordersExecuted(end,3) + ordersExecuted(end,1) * (ordersOpen(order,2) - ordersExecuted(end,2))];
    end

    % check if order has an exit price; remove filled order (and its stoploss), or add reverse/exit & stLoss orders
    % UpdateOrderOpen(order, executionPrice);
    
    if ordersOpen(order,5) ~= 0 
        % we have a profitTarget. So we are flat -> filled, and need to add a profit target and stLoss in openOrders table
        UpdateOpenOrder(order, executionPrice);
    else
        % We execute a profit target entry or a stop loss entry
        ClosePosition(order);
    end
catch ME
    disp(ME.getReport);
    rethrow(ME);
end    
end

