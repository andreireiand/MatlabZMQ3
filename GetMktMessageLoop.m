function GetMktMessageLoop(q, ticker, tcpPort)
    import org.zeromq.*
    ctx = zmq.Ctx();    

    subscriber = ctx.createSocket(ZMQ.SUB);
    subscriber.connect(strcat('tcp://127.0.0.1:',tcpPort));
    subscriber.setSocketOpt(6,ticker);  
    
    try
        %for i = 1:100
        while true
            tickData = GetTickData(subscriber.recv(0).data);
            disp(strcat('tickData:',tickData));
            send(q, tickData);
        end
    catch ME
        disp(ME.getReport);
        rethrow(ME)
    end   
end

