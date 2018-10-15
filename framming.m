function [f,fs,N,frameNo]=framming(audiofile)

[x,fs]=audioread(audiofile);
x=x*32767;
l=length(x);  %number of the samples of the whole audio
N=25*fs/1000;  %length of frames in terms of samples
M=10*fs/1000;   %distance between frames in terms of samples
frameNo=fix(l/M)-3;    %quantity of frames
f(1:frameNo,1:N)=0;
for k=1:frameNo
    for s=((M*k)+1):(N+(M*k))
        f(k,(s-(k*M)))=x(s);%f: a matrix which in each row there is a frame
    end
end

