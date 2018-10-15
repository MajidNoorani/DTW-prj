function [Hf]= Hamming(frames,N,frameNo)
n=1:N;
w(n)=0.54-0.46*cos(2*pi*n/(N-1));   %hamming window
Hf=zeros(size(frames));
for k=1:frameNo
    for i=1:N
    Hf(k,i)=frames(k,i)*w(i);   %multiplication of hamming window in frames
    end
end
