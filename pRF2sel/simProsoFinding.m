pProso = .05;

bstraps = 1000;

countProso = zeros(1,bstraps);

for b=1:bstraps
    smple = rand(1,80);
    countProso(b)=length(find(smple<=pProso))
end

    
figure;
[h i]=hist(countProso)

h/1000
