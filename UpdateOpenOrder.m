function UpdateOpenOrder(order, executionPrice)
%
%
%
%   We have an entry of type: 1, 10, -1, 0, 12, 8 which means we go long with a 2 points target and 2 points loss

    global ordersOpen
try    
    % The two below have the same stop loss ... and they cancel eachother, and identify each other by last (6th) element, the stop loss.
    % Also, price needs to be between profit target and stop loss.
    if ordersOpen(order,1) == 1
        assert(ordersOpen(order,6) < executionPrice & executionPrice < ordersOpen(order,5));
    elseif ordersOpen(order,1) == -1
        assert(ordersOpen(order,6) > executionPrice & executionPrice > ordersOpen(order,5));
    else
        disp('In UpdateOrderOpen, this branch should never be reached. ordersOpen(order,1) is neither 1 nor -1.');
        assert(false);
    end

    stLoss = ordersOpen(order,6);
    si = ordersOpen(order,1);
    % you need to update scan of ordersOpen & convert stLoss orders from code 2/-2 to 1/-1 when price hits level
    
    % the below should be 2 or -2. A stLoss should convert into market when price hits level.
    stLossCode = -(si*(abs(ordersOpen(order,1)) + 1)); % this should have the reverse sign of si.
    SetOrder(order,        -si, ordersOpen(order,5), -1, 0, 0, stLoss); % re-cycle table entry for pfTarget; no need to remove entry
    % below is a strange one ... 
    SetOrder(-1,    stLossCode, ordersOpen(order,6), -1, 0, 0, stLoss); % adds stLoss order at the end of ordersOpen 
    
 catch ME
    disp(ME.getReport);
    rethrow(ME);
end       
end

