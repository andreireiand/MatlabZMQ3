function GenerateOrders(isBid)
%GenerateOrders Summary of this function goes here
%   
%
%
    global ordersOpen pointsProfitTarg pointsStLoss
try    
    if isempty(ordersOpen) % we only add orders if no order in the queue ... for testing initially
        if isBid
            % total order withdraws on bid side is >= queueWithdraws; we need
            % to generate a short market order and buytocover x ticks below
            
            bid = str2double(GetCurrentExecBidAsk(true));
            assert(numel(bid)==1);
            disp(strcat('In GenerateOrders: Bids are running out! we should generate a short market into bid: ',GetCurrentExecBidAsk(true),',with a close profit target.'));
            SetOrder(1, -1, bid, -1, 0, bid - pointsProfitTarg, bid + pointsStLoss);
        else
            ask = str2double(GetCurrentExecBidAsk(false));
            assert(numel(ask)==1);
            disp(strcat('In GenerateOrders: Shorts are running out! we should generate a buy market into ask: ',GetCurrentExecBidAsk(false),',with a close profit target.'));            
            SetOrder(1, +1, ask, -1, 0, ask + pointsProfitTarg, ask - pointsStLoss);
        end
    end
catch ME
    disp(ME.getReport);
    rethrow(ME);
end     
end

