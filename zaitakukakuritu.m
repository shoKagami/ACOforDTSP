%% �ݑ�m���v�Z�v���O����

function P_fam = zaitakukakuritu(NUM,Rx_level,Ry_level)
%% �ݒ�
%�l��
% NUM = 80;
num = NUM*6;
% %�m���m�C�Y�̍ő��[%]�i�ő�9%�܂ŁA����ȏ��100%�𒴉߂���j
% Ry_level = 5;
% %�����Y���ő�l[hour]�i�ő�1.5h�܂ŁA����ȏ��24���𒴉߂���j
% Rx_level = 4;
% 
% %�ǂݍ��݃t�@�C���t�H���_
% folder_name = 'E:\��w\M1\�V�X�e������v���W�F�N�g\program\';

%�O���t�\���̗L��(0�ŕ\�����Ȃ��A1�ŕ\��)
graph = 0;

%�ۑ��̗L��(0�ŕۑ����Ȃ��A1�ŕۑ�)
SAVE = 1;

%% �f�[�^�ǂݍ��� �� �j�����Ƃ̕���
time = 0:0.5:23.5;  %������
Yusyokusya = textread('Yusyokusya.txt');
meanY = mean([Yusyokusya Yusyokusya]);
Syuhu = textread('Syuhu.txt');
meanS = mean([Syuhu Syuhu]);
Musyoku = textread('Musyoku.txt');
meanM = mean([Musyoku Musyoku]);

%% �v���b�g
if(graph == 1)
    figure()
    h = plot(time,meanY,time,meanS,time,meanM);
    xlabel('Time[h]');
    ylabel('�ݑ�m�����ϒl');
    legend('�L�E��','��w','���E');
end
%% �c�����m�C�YRy

Ry_Y = (rand(num,48*2)-0.5)*2*Ry_level;
Ry_S = (rand(num,48*2)-0.5)*2*Ry_level;
Ry_M = (rand(num,48*2)-0.5)*2*Ry_level;

%�l�����̔z��Ɋg�����ăm�C�Y�����Z
Y_n1 = ones(num,1)*meanY + Ry_Y;
S_n1 = ones(num,1)*meanS + Ry_S;
M_n1 = ones(num,1)*meanM + Ry_M;

% 0�ȉ��̒l�͋����I��0�ɂ���i�ی��j�i�m�C�Y��10%�����Ȃ�100%�͒����Ȃ��̂Ŗ����j
Y_n2 = Y_n1.*(Y_n1>0);
S_n2 = S_n1.*(S_n1>0);
M_n2 = M_n1.*(M_n1>0);

if(graph == 1)
    figure()
    plot(time,Ry_Y');
    xlabel('Time[h]');
    ylabel('�m�C�Y��[%]');

    figure()
    plot(time,Y_n2');
    xlabel('Time[h]');
    ylabel('�L�E�҂̍ݑ�m���i�m���m�C�Y�܂ށj');

    figure()
    plot(time,S_n2');
    xlabel('Time[h]');
    ylabel('��w�̍ݑ�m���i�m���m�C�Y�܂ށj');
    
    figure()
    plot(time,M_n2');
    xlabel('Time[h]');
    ylabel('���E�̍ݑ�m���i�m���m�C�Y�܂ށj');
end

%% �����Y��Rx
num_day = 19:45;        %9~22���ɂ�����z��̔ԍ�
daytime = time(num_day);%9~22���̎�����

%�z������Y�������̗���
Rx_Y = randi(4*Rx_level+1,[num,1])-(2*Rx_level+1);
Rx_S = randi(4*Rx_level+1,[num,1])-(2*Rx_level+1);
Rx_M = randi(4*Rx_level+1,[num,1])-(2*Rx_level+1);


%% �����Y�����l������9���`22���܂ł𔲂��o��
for k = 1:1:num
    P_Yusyokusya(k,:) = Y_n2(k,num_day+Rx_Y(k));
end

for k = 1:1:num
    P_Syuhu(k,:) = S_n2(k,num_day+Rx_S(k));
end

for k = 1:1:num
    P_Musyoku(k,:) = M_n2(k,num_day+Rx_M(k));
end

%% �\��
if(graph ==1)
    figure()
    plot(daytime,P_Yusyokusya')
    xlabel('Time[h]');
    ylabel('�L�E�҂̍ݑ�m���i�ŏI�l�j');
    figure()
    plot(daytime,P_Syuhu')
    xlabel('Time[h]');
    ylabel('��w�̍ݑ�m���i�ŏI�l�j');
    figure()
    plot(daytime,P_Musyoku')
    xlabel('Time[h]');
    ylabel('���E�̍ݑ�m���i�ŏI�l�j');
end
%% �f�[�^�̕ۑ�
%�ۑ���͓ǂݍ��݂����t�H���_�Ɠ���
if(SAVE==1)
    save('P_Yusyokusya.mat');
    save('P_Syuhu.mat');
    save('P_Musyoku.mat'); 
end

%% �z��܂Ƃ߂�
% 1:�L�E�ҁ@2:��w�@3:���E�@4:null
P_parsonal = zeros(27,num,4);
P_parsonal(:,:,1) = P_Yusyokusya'/100;
P_parsonal(:,:,2) = P_Syuhu'/100;
P_parsonal(:,:,3) = P_Musyoku'/100;

P_not = 1-P_parsonal;
%% �Ƒ��\�����f
family = [26.9 31.5 20.2 13.9 5.1 2.4]/100;
rand_fam = randsample([1:1:6],NUM,true,family);
job = [56.2 13 16.4]/100;

if(graph ==1)
    figure()
    histogram(rand_fam)
end

Pnot_fam = ones(27,NUM);
job_fam = zeros(NUM,6);
for k = 1:1:NUM
    for m = 1:1:rand_fam(k)
        job_ = randsample([1:1:3],1,true,job);
        Pnot_fam(:,k) =  Pnot_fam(:,k).*P_not(:,(k-1)*6+m,job_);
        job_fam(k,m) = job_;     
    end    
end

if(graph ==1)
    figure()
    histogram(job_fam)
end

P_fam = 1-Pnot_fam;
figure()
plot(daytime,P_fam)
xlabel('TIme [hour]');
ylabel('Probability (someone is at home)');

end