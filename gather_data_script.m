% Configurable parameters.
ip_addr = '192.168.1.172';
port_val = 7;
samples_len = 256*1024;
grab_trig = 2048;

% Other constants.
err = [];
sample_rate = 100e6/grab_trig;

% Perform the following statements within a try-catch block to ensure the
% socket is always properly closed if an exception is thrown.
try
    
    % Create and initialize parameters of socket.
    disp( 'Configuring socket...' );
    soc_obj = tcpip( ip_addr, port_val );
    soc_obj.InputBufferSize = samples_len*2;
    soc_obj.ByteOrder = 'littleEndian';
    soc_obj.Timeout = inf;
    
    % Open socket and acquire the data.
    disp( 'Opening socket and collecting data...' );
    fopen( soc_obj );
    fwrite( soc_obj, uint32( samples_len ), 'uint32' );
    data = fread( soc_obj, double( samples_len ), 'uint16');
    
    % Plot raw data and play sound.
    disp( 'Plotting data...' );
    close all; figure; plot( data );
    soundsc( data, sample_rate );
catch err
end

% Ensure the socket is properly closed.
disp( 'Closing socket...' );
fclose( soc_obj );
delete( soc_obj );
clear soc_obj

% Throw any exceptions.
if ( ~isempty( err ) )
    rethrow( err );
end