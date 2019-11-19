%CodeStart--------------------------------------------------------
%Resetting MATLAB environment
  instrreset
  clear
  clc
%Creating UDP object
  UDPComIn=udp('192.168.43.32','LocalPort',12345);
  set(UDPComIn,'DatagramTerminateMode','off')
%Opening UDP communication
  fopen(UDPComIn);
%Reading data
t0 = clock;
headers = {'A','B','C','D','E','F'};
csvwrite('TestData.csv',headers);
  while etime(clock, t0) < 3
    csvdata=fscanf(UDPComIn);
    scandata=textscan(csvdata,'%f %f %f %f %f %f','Delimiter',',');
    data=[scandata{1},scandata{2},scandata{3},scandata{4},scandata{5},scandata{6}];
    disp(data)
    
    dlmwrite('TestData.csv',data,'delimiter',',','-append');
  end
%Closing UDP communication
  fclose(UDPComIn);
%Deleting UDP communication
  %delete(UDPComIn)
%CodeEnd----------------------------------------------------------