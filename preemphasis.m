function [pframes]= preemphasis(frames)
alfa=0.95;
f1=frames(:,1);
f=[f1 frames];  %repeating the first column for preemphasis
sz=size(f);
pframes=zeros(sz);
for i=1:sz(1)
    for k=2:sz(2)
        pframes(i,k)=f(i,k)-alfa*f(i,k-1);       %preemphasis
    end
end