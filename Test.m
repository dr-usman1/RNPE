load input_image.mat;
%% Rearrange input image according to convolution 
H = 28; % output feature map height
W = 28; % output feature map width
K = 5; % kernel size
S = 1; % convolution stride
S_P = 2; % pool stride
Imap1 = cell(H, W);
for i = 1:H
    for j = 1:W
        Imap1{i,j} = input_image(j:j+(K-1),i:i+(K-1));
    end
end
Imap1_tr = Imap1';




%% Rearranged image is flattened in matrix B
cnt = 1;
for i = 1:H
    for j = 1:W
        if cnt < (H*W+1)
           B(:,cnt)=Imap1_tr{i,j}(:);
            cnt = cnt+1;
    end
    end
end

%% The flattened image is rearranged according to pool in matrix B_pool
B_pool = [];
cnt = 1;
start1 = 1;
end1 = start1+W-1;

for j = 1:(H/2)
    for i = start1:2:end1
        B_pool(:,cnt) = B(:,i);
        B_pool(:,cnt+1) = B(:,i+1);
        B_pool(:,cnt+2) = B(:,i+W);
        B_pool(:,cnt+3) = B(:,i+W+1);
        cnt = cnt+(S_P*2);
    end
    start1 = end1+W+1;
    end1 = start1+W-1;
end
%% Convert B_pool to binary in BB_bin
BB_bin = [];
B_pool_scaled = round(255*(B_pool));
B_pool_round = round(1000*(B_pool))/1000;
B_pool_round_scaled = round(255*(B_pool_round));
for i = 1:H*W
    BB_bin(:,i) = str2num(dec2bin(B_pool_scaled(:,i)));
end

save('BB_bin.mat','BB_bin')
