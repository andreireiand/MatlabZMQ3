function GetDepMessageLoop(q, ticker, tcpPort)
    import org.zeromq.*
    ctx = zmq.Ctx();    

    subscriber = ctx.createSocket(ZMQ.SUB);
    subscriber.connect(strcat('tcp://127.0.0.1:',tcpPort));
    subscriber.setSocketOpt(6,ticker);  
    
    try
        %for i = 1:100
        while true
            tickData = GetTickData(subscriber.recv(0).data);
            send(q, tickData);
        end
    catch ME
        rethrow(ME)
    end   
end

