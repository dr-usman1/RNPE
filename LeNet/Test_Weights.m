
W5_L1 = load('W5_L1.mat');
% W0_L1 = W0_L1.W0_L1
% A = []
% A(:,1) = W0_L1(:)

A = []
A(:,1) = (W5_L1.W5_L1(:));
A_scaled(:,1) = round((W5_L1.W5_L1(:))*1000)/1000;

% save('W5_L1nonscaled.mat','A')
% save('W5_L1scaled.mat','A_scaled')